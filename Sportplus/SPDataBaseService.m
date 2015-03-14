//
//  SPDataBaseService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/14.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPDataBaseService.h"
#import "SPUtils.h"
#import "SPCacheService.h"
#import "spChatroom.h"

static FMDatabaseQueue* dbQueue;

static NSString *messagesTableSQL=@"create table if not exists messages (id integer primary key, objectId varchar(63) unique not null,ownerId varchar(255) not null,fromPeerId varchar(255) not null, convid varchar(255) not null,toPeerId varchar(255),content varchar(1023) ,status integer,type integer,roomType integer,readStatus integer default 1,timestamp varchar(63) not null)";

@implementation SPDataBaseService

+(void)initialize{
    [super initialize];
    dbQueue=[FMDatabaseQueue databaseQueueWithPath:[self databasePath]];
    [self createTable];
}

+(void)createTable{
    [dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"messages"]) {
            [db executeUpdate:messagesTableSQL];
        }
    }];
}

+ (NSString *)databasePath {
    static NSString *databasePath = nil;
    if (!databasePath) {
        NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        databasePath = [cacheDirectory stringByAppendingPathComponent:@"chat.db"];
    }
    return databasePath;
}

+(void)upgradeToAddField{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeStatements:@"drop table if exists messages"];
        [db executeUpdate:messagesTableSQL];
    }];
}

+(spMsg* )getMsgByResultSet:(FMResultSet*)rs{
    NSString *fromid = [rs stringForColumn:FROM_PEER_ID];
    NSString *toid = [rs stringForColumn:TO_PEER_ID];
    NSString *convid=[rs stringForColumn:CONV_ID];
    NSString *objectId=[rs stringForColumn:OBJECT_ID];
    NSString* timestampText = [rs stringForColumn:TIMESTAMP];
    int64_t timestamp=[timestampText longLongValue];
    NSString* content=[rs stringForColumn:CONTENT];
    CDMsgRoomType roomType=[rs intForColumn:ROOM_TYPE];
    CDMsgType type=[rs intForColumn:TYPE];
    CDMsgStatus status=[rs intForColumn:STATUS];
    CDMsgReadStaus readStatus=[rs intForColumn:READ_STATUS];
    
    spMsg* msg=[[spMsg alloc] init];
    msg.fromPeerId=fromid;
    msg.objectId=objectId;
    msg.toPeerId=toid;
    msg.timestamp=timestamp;
    msg.content=content;
    msg.type=type;
    msg.status=status;
    msg.roomType=roomType;
    msg.convid=convid;
    msg.readStatus=readStatus;
    return msg;
}

+(NSMutableArray*)getMsgsByResultSet:(FMResultSet*)rs{
    NSMutableArray *result = [NSMutableArray array];
    while ([rs next]) {
        spMsg *msg=[self getMsgByResultSet :rs];
        [result addObject:msg];
    }
    [rs close];
    return result;
}

+(void)findConversationsWithCallback:(AVArrayResultBlock)callback{
    [SPUtils runInGlobalQueue:^{
        [dbQueue inDatabase:^(FMDatabase *db) {
            AVUser* user=[AVUser currentUser];
            FMResultSet *rs = [db executeQuery:@"select * from messages where ownerId=? group by convid order by timestamp desc" withArgumentsInArray:@[user.objectId]];
            NSArray *msgs=[self getMsgsByResultSet:rs];
            [SPCacheService cacheMsgs:msgs withCallback:^(NSArray *objects, NSError *error) {
                if(error){
                    [SPUtils runInMainQueue:^{
                        callback(nil,error);
                    }];
                }else{
                    NSMutableArray *chatRooms=[[NSMutableArray alloc] init];
                    for(spMsg* msg in msgs){
                        spChatroom* chatRoom=[[spChatroom alloc] init];
                        chatRoom.roomType=msg.roomType;
                        FMResultSet * countResult=[db executeQuery:@"select count(*) from messages where convid=? and readStatus=?" withArgumentsInArray:@[msg.convid,@(CDMsgReadStatusUnread)]];
                        NSInteger count=0;
                        if([countResult next]){
                            count=[countResult intForColumnIndex:0];
                        }
                        [countResult close];
                        chatRoom.unreadCount=count;
                        
                        NSString* otherId=[msg getOtherId];
                        if(msg.roomType==CDMsgRoomTypeSingle){
                            chatRoom.chatUser=[SPCacheService lookupUser:otherId];;
                        }else{
                            chatRoom.chatGroup=[SPCacheService lookupChatGroupById:otherId];
                        }
                        chatRoom.latestMsg=msg;
                        [chatRooms addObject:chatRoom];
                    }
                    [SPUtils runInMainQueue:^{
                        callback(chatRooms,error);
                    }];
                }
            }];
        }];
    }];
}

+(void)insertMsgToDB:(spMsg*)msg{
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSDictionary *dict=[msg toDatabaseDict];
        [db executeUpdate:@"insert into messages (objectId,ownerId , fromPeerId, toPeerId, content,convid,status,type,roomType,readStatus,timestamp) values (:objectId,:ownerId,:fromPeerId,:toPeerId,:content,:convid,:status,:type,:roomType,:readStatus,:timestamp)" withParameterDictionary:dict];
    }];
}

+ (void)getMsgsForConvid:(NSString*)convid block:(AVArrayResultBlock)block{
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs=[db executeQuery:@"select * from messages where convid=? order by timestamp" withArgumentsInArray:@[convid]];
        NSMutableArray* array=[self getMsgsByResultSet:rs];
        block(array,nil);
    }];
}

+(NSArray*)getMsgsWithConvid:(NSString*)convid maxTimestamp:(int64_t)timestamp limit:(int)limit db:(FMDatabase*)db{
    NSString* timestampStr=[[NSNumber numberWithLongLong:timestamp] stringValue];
    FMResultSet* rs=[db executeQuery:@"select * from messages where convid=? and timestamp<? order by timestamp desc limit ?" withArgumentsInArray:@[convid,timestampStr,@(limit)]];
    NSMutableArray* msgs=[self getMsgsByResultSet:rs];
    return [SPUtils reverseArray:msgs];
}

+(int64_t)getMaxTimestampFromDB:(FMDatabase*)db{
    FMResultSet* rs=[db executeQuery:@"select * from messages order by timestamp desc limit 1"];
    NSArray* array=[self getMsgsByResultSet:rs];
    if([array count]>0){
        spMsg* msg=[array firstObject];
        return msg.timestamp;
    }else{
        return -1;
    }
}

+(int64_t)getMaxTimetstampWithDB:(FMDatabase*)db{
    int64_t timestamp=[self getMaxTimestampFromDB:db];
    int64_t result;
    if(timestamp!=-1){
        result=timestamp+1;
    }else{
        result=(int64_t)([[NSDate date] timeIntervalSince1970]+10)*1000;
    }
    return result;
}

+(void)markHaveReadWithConvid:(NSString*)convid{
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update messages set readStatus=? where convid=?" withArgumentsInArray:@[@(CDMsgReadStatusHaveRead),convid]];
    }];
}

+(void)updateMsgWithId:(NSString*)objectId status:(CDMsgStatus)status timestamp:(int64_t)timestamp{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self updateMsgWithId:objectId status:status];
    NSString* timestampText=[NSString stringWithFormat:@"%lld",timestamp];
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update messages set timestamp=? where objectId=?" withArgumentsInArray:@[timestampText,objectId]];
    }];
}

+(void)updateMsgWithId:(NSString*)objectId content:(NSString*)content{
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update messages set content=? where objectId=?" withArgumentsInArray:@[objectId,content]];
    }];
}

+(void)updateMsgWithId:(NSString*)objectId status:(CDMsgStatus)status{
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update messages set status=? where objectId=?" withArgumentsInArray:@[@(status),objectId]];
    }];
}

+(FMDatabaseQueue*) databaseQueue{
    return dbQueue;
}

@end

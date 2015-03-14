//
//  spMsg.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/14.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spMsg.h"
#import "spEmotionUtilis.h"

@implementation spMsg

@synthesize fromPeerId;
@synthesize toPeerId;
@synthesize timestamp;

@synthesize content;
@synthesize convid;
@synthesize objectId;

@synthesize type;
@synthesize roomType;
@synthesize status;
@synthesize readStatus;

-(NSDictionary*)toMessagePayloadDict{
    if(content==nil || objectId==nil){
        [NSException raise:@"null pointer exception" format:nil];
    }
    return @{OBJECT_ID:objectId,CONTENT:content,TYPE:@(type)};
}

-(NSDictionary*)toDatabaseDict{
    NSMutableDictionary *dict=[[self toMessagePayloadDict] mutableCopy];
    [dict setValue:@(status) forKey:STATUS];
    [dict setValue:@(roomType) forKey:ROOM_TYPE];
    [dict setValue:@(readStatus) forKey:READ_STATUS];
    [dict setValue:convid forKey:CONV_ID];
    [dict setValue:[[NSNumber numberWithLongLong:timestamp] stringValue] forKey:TIMESTAMP];
    [dict setValue:fromPeerId forKey:FROM_PEER_ID];
    [dict setValue:toPeerId forKey:TO_PEER_ID];
    NSString* curUserId=[AVUser currentUser].objectId;
    [dict setValue:curUserId forKey:OWNER_ID];
    if(curUserId==nil || fromPeerId==nil){
        [NSException raise:@"fromPeerId or curUserId is null" format:nil];
    }
    return dict;
}

-(NSString *)toMessagePayload{
    NSDictionary* dict=[self toMessagePayloadDict];
    NSError* error=nil;
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *payload=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return payload;
}

-(NSString*)getOtherId{
    NSString* curUserId=[AVUser currentUser].objectId;
    if(roomType==CDMsgRoomTypeSingle){
        if([curUserId isEqualToString:fromPeerId]){
            return toPeerId;
        }else{
            return fromPeerId;
        }
    }else{
        return convid; // groupId
    }
}

+(spMsg*)fromAVMessage:(AVMessage *)avMsg{
    NSString *payload=[avMsg payload];
    NSData *data=[payload dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error=nil;
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(error){
        [NSException raise:@"json deserialize error" format:nil];
    }
    int typeValue=[dict[@"type"] intValue];
    spMsg* msg=[[spMsg alloc] init];
    msg.fromPeerId=avMsg.fromPeerId;
    msg.toPeerId=avMsg.toPeerId;
    msg.content=dict[@"content"];
    msg.timestamp = avMsg.timestamp ;
    msg.objectId = dict[@"objectId"] ;
    msg.type=(CDMsgType)typeValue;
    return msg ;
}

-(NSDate*)getTimestampDate{
    return [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
}

-(NSString*)getStatusDesc{
    switch (status) {
        case CDMsgStatusSendStart:
            return @"发送中";
        case CDMsgStatusSendFailed:
            return @"失败";
        case CDMsgStatusSendReceived:
            return @"";
        case CDMsgStatusSendSucceed:
            switch (roomType) {
                case CDMsgRoomTypeSingle:
                    return @"已发送";
                case CDMsgRoomTypeGroup:
                    return @"";
            }
    }
    [NSException raise:@"invalid status" format:nil];
}

-(NSString*)getReadStatusDesc{
    switch (readStatus) {
        case CDMsgReadStatusHaveRead:
            return @"已读";
        case CDMsgReadStatusUnread:
            return @"未读";
    }
    [NSException raise:@"invalid read status" format:nil];
}

-(BOOL)fromMe{
    AVUser* curUser=[AVUser currentUser];
    assert(curUser!=nil);
    return [fromPeerId isEqualToString:curUser.objectId];
}

-(NSString*)getMsgDesc{
    switch (type) {
        case CDMsgTypeText:
            return [spEmotionUtilis convertWithText:content toEmoji:YES];
        case CDMsgTypeAudio:
            return @"语音";
        case CDMsgTypeImage:
            return @"图片";
        case CDMsgTypeLocation:
            return content;
        default:
            return nil;
    }
}

+(NSString*)getObjectIdByAVMessage:(AVMessage*)avMsg{
    spMsg* msg=[spMsg fromAVMessage:avMsg];
    return  msg.objectId;
}

@end

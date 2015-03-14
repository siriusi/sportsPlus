//
//  SPDataBaseService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/14.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "spMsg.h"
#import "SPUtils.h"
#import <FMDB/FMDB.h>

@interface SPDataBaseService : NSObject

+(void)markHaveReadWithConvid:(NSString*)convid;

+(void)insertMsgToDB:(spMsg*)msg;

+(void)findConversationsWithCallback:(AVArrayResultBlock)callback;

+(NSArray*)getMsgsWithConvid:(NSString*)convid maxTimestamp:(int64_t)timestamp limit:(int)limit db:(FMDatabase*)db;

+(int64_t)getMaxTimetstampWithDB:(FMDatabase*)db;

+(void)upgradeToAddField;

+(void)updateMsgWithId:(NSString*)objectId status:(CDMsgStatus)status timestamp:(int64_t)timestamp;

+(void)updateMsgWithId:(NSString*)objectId status:(CDMsgStatus)status;

+(void)updateMsgWithId:(NSString*)objectId content:(NSString*)content;

+(FMDatabaseQueue*) databaseQueue;


@end

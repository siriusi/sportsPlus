//
//  spMsg.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/14.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

#define OWNER_ID @"ownerId"
#define FROM_PEER_ID @"fromPeerId"
#define TO_PEER_ID @"toPeerId"
#define CONV_ID @"convid"
#define TYPE @"type"
#define CONTENT @"content"
#define TIMESTAMP @"timestamp"
#define OBJECT_ID @"objectId"
#define ROOM_TYPE @"roomType"
#define STATUS @"status"
#define READ_STATUS @"readStatus"

typedef enum : NSUInteger {
    CDMsgRoomTypeSingle = 0,
    CDMsgRoomTypeGroup=1,
} CDMsgRoomType;

typedef enum : NSUInteger{
    CDMsgTypeText=0,
    CDMsgTypeImage=1,
    CDMsgTypeAudio=2,
    CDMsgTypeLocation=3,
    CDMsgTypeWithEngagement = 4 ,
}CDMsgType;

typedef enum : NSUInteger{
    CDMsgStatusSendStart=0,
    CDMsgStatusSendSucceed=1,
    CDMsgStatusSendReceived=2,
    CDMsgStatusSendFailed=3,
}CDMsgStatus;

typedef enum : NSUInteger{
    CDMsgReadStatusUnread=0,
    CDMsgReadStatusHaveRead
}CDMsgReadStaus;


@interface spMsg : NSObject

@property NSString* fromPeerId;
@property NSString* toPeerId;
@property int64_t timestamp;

@property NSString* content;
@property NSString* objectId;
@property NSString* convid;

@property CDMsgRoomType roomType;
@property CDMsgStatus status;
@property CDMsgType type;
@property CDMsgReadStaus readStatus;

+(spMsg*)fromAVMessage:(AVMessage *)avMsg;

-(NSString *)toMessagePayload;

-(NSString*)getOtherId;

-(NSDictionary*)toDatabaseDict;

-(NSDate*)getTimestampDate;

-(NSString*)getStatusDesc;

-(NSString*)getMsgDesc;

-(NSString*)getReadStatusDesc;

-(BOOL)fromMe;

+(NSString*)getObjectIdByAVMessage:(AVMessage*)avMsg;

@end

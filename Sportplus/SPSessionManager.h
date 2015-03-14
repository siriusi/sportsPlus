//
//  SPSessionManager.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "spCommon.h"
#import "spMsg.h"

@interface SPSessionManager : NSObject<AVSessionDelegate,AVSignatureDelegate,AVGroupDelegate>

+ (instancetype)sharedInstance;

#pragma mark - session
- (void)watchPeerId:(NSString *)peerId;

-(void)unwatchPeerId:(NSString*)peerId;

-(void)openSession;

-(void)closeSession;

#pragma mark - operation message

- (void)sendMessageWithObjectId:(NSString*)objectId content:(NSString *)content type:(CDMsgType)type toPeerId:(NSString *)toPeerId group:(AVGroup*)group;

-(void)resendMsg:(spMsg*)msg toPeerId:(NSString*)toPeerId group:(AVGroup*)group;

+(NSString*)getConvidOfRoomType:(CDMsgRoomType)roomType otherId:(NSString*)otherId groupId:(NSString*)groupId;

- (void)clearData;

+(NSString*)convidOfSelfId:(NSString*)myId andOtherId:(NSString*)otherId;

+(NSString*)getPathByObjectId:(NSString*)objectId;

#pragma mark - histroy
- (void)getHistoryMessagesForPeerId:(NSString *)peerId callback:(AVArrayResultBlock)callback;

- (void)getHistoryMessagesForGroup:(NSString *)groupId callback:(AVArrayResultBlock)callback;


-(AVSession*)getSession;

@end

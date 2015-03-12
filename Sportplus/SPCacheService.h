//
//  SPCacheService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/12.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "spCommon.h"
#import "spChatGroup.h"

@interface SPCacheService : NSObject

+ (void)registerUsers:(NSArray*)users;

+ (void)registerUser:(AVUser*)user;

+ (AVUser *)lookupUser:(NSString*)userId;

+(spChatGroup*)lookupChatGroupById:(NSString*)groupId;

+(void)registerChatGroup:(spChatGroup*)chatGroup;

+(void)cacheUsersWithIds:(NSSet*)userIds callback:(AVArrayResultBlock)callback;

+(void)cacheChatGroupsWithIds:(NSMutableSet*)groupIds withCallback:(AVArrayResultBlock)callback;

+(void)registerChatGroups:(NSArray*)chatGroups;

+(void)cacheMsgs:(NSArray*)msgs withCallback:(AVArrayResultBlock)callback;

#pragma mark - current chat group

+(void)setCurrentChatGroup:(spChatGroup*)chatGroup;

+(spChatGroup*)getCurrentChatGroup;

+(void)refreshCurrentChatGroup:(AVBooleanResultBlock)callback;

+(void)setFriends:(NSArray*)_friends;

+(NSArray*)getFriends;

@end

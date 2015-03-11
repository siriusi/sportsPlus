//
//  SPGroupService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import "spChatGroup.h"

@interface SPGroupService : NSObject

+(void)findGroupsWithCallback:(AVArrayResultBlock)callback cacheFirst:(BOOL)cacheFirst;

+(void)findGroupsByIds:(NSMutableSet*)groupIds withCallback:(AVArrayResultBlock)callback;

+ (void)saveNewGroupWithName:(NSString*)name withCallback:(AVGroupResultBlock)callback;

+(void)inviteMembersToGroup:(spChatGroup*) chatGroup userIds:(NSArray*)userIds callback:(AVArrayResultBlock)callback;

+(void)kickMemberFromGroup:(spChatGroup*)chatGroup userId:(NSString*)userId;

+(void)quitFromGroup:(spChatGroup*)chatGroup;

+ (AVGroup *)joinGroupById:(NSString *)groupId;

+(AVGroup*)getGroupById:(NSString*)groupId;

+(void)setDelegateWithGroupId:(NSString*)groupId;

@end

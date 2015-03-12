//
//  SPCacheService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/12.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPCacheService.h"
#import "SPGroupService.h"
//#import "CDMsg.h"

@implementation SPCacheService

static NSMutableDictionary *cachedChatGroups;
static NSMutableDictionary *cachedUsers;
static spChatGroup* currentChatGroup;
static NSArray* friends;

+(void)initialize{
    [super initialize];
    cachedChatGroups=[[NSMutableDictionary alloc] init];
    cachedUsers=[[NSMutableDictionary alloc] init];
}

#pragma mark - user cache

+ (void)registerUsers:(NSArray*)users{
    for(int i=0;i<users.count;i++){
        [self registerUser:[users objectAtIndex:i]];
    }
}

+(void) registerUser:(AVUser*)user{
    [cachedUsers setObject:user forKey:user.objectId];
}

+(AVUser *)lookupUser:(NSString*)userId{
    return [cachedUsers valueForKey:userId];
}

#pragma mark - group cache

+(spChatGroup*)lookupChatGroupById:(NSString*)groupId{
    return [cachedChatGroups valueForKey:groupId];
}

+(void)registerChatGroup:(spChatGroup*)chatGroup{
    [cachedChatGroups setObject:chatGroup forKey:chatGroup.objectId];
}

+(void)registerChatGroups:(NSArray*)chatGroups{
    for(spChatGroup* chatGroup in chatGroups){
        [self registerChatGroup:chatGroup];
    }
}

+(void)notifyGroupUpdate{
    [SPUtils postNotification:NOTIFICATION_GROUP_UPDATED];
}

+(void)cacheChatGroupsWithIds:(NSMutableSet*)groupIds withCallback:(AVArrayResultBlock)callback{
    NSMutableSet* uncacheGroupIds=[[NSMutableSet alloc] init];
    for(NSString * groupId in groupIds){
        if([self lookupChatGroupById:groupId]==nil){
            [uncacheGroupIds addObject:groupId];
        }
    }
    if([uncacheGroupIds count]>0){
        [SPGroupService findGroupsByIds:uncacheGroupIds withCallback:^(NSArray *objects, NSError *error) {
            [SPUtils filterError:error callback:^{
                for(spChatGroup* chatGroup in objects){
                    [self registerChatGroup:chatGroup];
                }
                callback(objects,error);
            }];
        }];
    }else{
        callback([[NSMutableArray alloc] init],nil);
    }
}

+(void)cacheUsersWithIds:(NSSet*)userIds callback:(AVArrayResultBlock)callback{
    NSMutableSet* uncachedUserIds=[[NSMutableSet alloc] init];
    for(NSString* userId in userIds){
        if([self lookupUser:userId]==nil){
            [uncachedUserIds addObject:userId];
        }
    }
    if([uncachedUserIds count]>0){
        [SPUserService findUsersByIds:[[NSMutableArray alloc] initWithArray:[uncachedUserIds allObjects]] callback:^(NSArray *objects, NSError *error) {
            if(objects){
                [self registerUsers:objects];
            }
            callback(objects,error);
        }];
    }else{
        callback([[NSMutableArray alloc] init],nil);
    }
}

+(void)cacheMsgs:(NSArray*)msgs withCallback:(AVArrayResultBlock)callback{
#warning cache msg 
//    NSMutableSet* userIds=[[NSMutableSet alloc] init];
//    NSMutableSet* groupIds=[[NSMutableSet alloc] init];
//    for(CDMsg* msg in msgs){
//        if(msg.roomType==CDMsgRoomTypeSingle){
//            [userIds addObject:msg.fromPeerId];
//            [userIds addObject:msg.toPeerId];
//        }else{
//            [userIds addObject:msg.fromPeerId];
//            [groupIds addObject:msg.convid];
//        }
//    }
//    [self cacheUsersWithIds:userIds callback:^(NSArray *objects, NSError *error) {
//        if(error){
//            callback(objects,error);
//        }else{
//            [self cacheChatGroupsWithIds:groupIds withCallback:callback];
//        }
//    }];
}

#pragma mark - current cache group

+(void)setCurrentChatGroup:(spChatGroup*)chatGroup{
    currentChatGroup=chatGroup;
}

+(spChatGroup*)getCurrentChatGroup{
    return currentChatGroup;
}


+(void)refreshCurrentChatGroup:(AVBooleanResultBlock)callback{
    if(currentChatGroup!=nil){
        [currentChatGroup fetchInBackgroundWithBlock:^(AVObject *object, NSError *error) {
            if(error){
                callback(NO,error);
            }else{
                [self notifyGroupUpdate];
                callback(YES,nil);
            }
        }];
    }else{
        callback(NO,[NSError errorWithDomain:nil code:0 userInfo:@{NSLocalizedDescriptionKey:@"currentChatGroup is nil"}]);
    }
}

#pragma mark - friends

+(void)setFriends:(NSArray*)_friends{
    friends=_friends;
}

+(NSArray*)getFriends{
    return friends;
}

@end

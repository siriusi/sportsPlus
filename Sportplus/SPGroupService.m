//
//  SPGroupService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPGroupService.h"
#import "spChatGroup.h"
#import "SPCloudSevice.h"
//#import "sp"

@implementation SPGroupService
//
//+(void)findGroupsWithCallback:(AVArrayResultBlock)callback cacheFirst:(BOOL)cacheFirst{
//    AVUser* user=[AVUser currentUser];
//    AVQuery* q=[CDChatGroup query];
//    [q includeKey:@"owner"];
//    if(cacheFirst){
//        [q setCachePolicy:kAVCachePolicyCacheElseNetwork];
//    }else{
//        [q setCachePolicy:kAVCachePolicyNetworkElseCache];
//    }
//    [q whereKey:@"m" equalTo:user.objectId];
//    [q orderByDescending:@"updatedAt"];
//    [q findObjectsInBackgroundWithBlock:callback];
//}
//
//+(void)findGroupsByIds:(NSMutableSet*)groupIds withCallback:(AVArrayResultBlock)callback{
//    if(groupIds.count>0){
//        AVQuery* q=[CDChatGroup query];
//        [q whereKey:@"objectId" containedIn:[groupIds allObjects]];
//        [q includeKey:@"owner"];
//        [q setCachePolicy:kAVCachePolicyNetworkElseCache];
//        [q findObjectsInBackgroundWithBlock:callback];
//    }else{
//        callback([[NSMutableArray alloc] init],nil);
//    }
//}
//
//+(void)inviteMembersToGroup:(CDChatGroup*) chatGroup userIds:(NSArray*)userIds callback:(AVArrayResultBlock)callback {
//    AVGroup* group=[self getGroupById:chatGroup.objectId];
//    [group invitePeerIds:userIds callback:callback];
//}
//
//+(void)kickMemberFromGroup:(CDChatGroup*)chatGroup userId:(NSString*)userId{
//    AVGroup* group=[self getGroupById:chatGroup.objectId];
//    NSMutableArray* arr=[[NSMutableArray alloc] init];
//    [arr addObject:userId];
//    [group kickPeerIds:arr];
//}
//
//+(void)quitFromGroup:(CDChatGroup*)chatGroup{
//    AVGroup* group=[self getGroupById:chatGroup.objectId];
//    [group quit];
//}
//
//
//+ (AVGroup *)joinGroupById:(NSString *)groupId {
//    AVGroup *group = [self getGroupById:groupId];
//    [self setDelegateWithGroupId:groupId];
//    [group join];
//    return group;
//}
//
//+(AVGroup*)getGroupById:(NSString*)groupId{
//    return [AVGroup getGroupWithGroupId:groupId session:[self getSession]];
//}
//
//+(void)setDelegateWithGroupId:(NSString*)groupId{
//    AVGroup* group=[self getGroupById:groupId];
//    CDSessionManager* man=[CDSessionManager sharedInstance];
//    group.delegate=man;
//}
//
//+(AVSession*)getSession{
//    CDSessionManager* man=[CDSessionManager sharedInstance];
//    AVSession* session=[man getSession];
//    return session;
//}
//
//+ (void)saveNewGroupWithName:(NSString*)name withCallback:(AVGroupResultBlock)callback {
//    CDSessionManager* man=[CDSessionManager sharedInstance];
//    [AVGroup createGroupWithSession:[self getSession] groupDelegate:man callback:^(AVGroup *group, NSError *error) {
//        if(error==nil){
//            [CDCloudService saveChatGroupWithId:group.groupId name:name callback:^(id object, NSError *error) {
//                callback(group,error);
//            }];
//        }else{
//            callback(group,error);
//        }
//    }];
//}
//
@end

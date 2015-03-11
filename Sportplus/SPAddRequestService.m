//
//  SPAddRequestService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPAddRequestService.h"
#import "SPUtils.h"

@implementation SPAddRequestService

+(void)findAddRequestsOnlyByNetwork:(BOOL)onlyNetwork withCallback:(AVArrayResultBlock)callback{
    AVUser *curUser=[AVUser currentUser] ;
    AVQuery *q=[addFriendRequest query] ;
    [q includeKey:@"fromUser"];
    [q whereKey:@"toUser" equalTo:curUser];
    [q orderByDescending:@"createdAt"];
    [SPUtils setPolicyOfAVQuery:q isNetwokOnly:onlyNetwork] ;
    [q findObjectsInBackgroundWithBlock:callback];
}

+(void)countAddRequestsWithBlock:(AVIntegerResultBlock)block{
    AVQuery *q=[addFriendRequest query] ;
    AVUser *user=[AVUser currentUser];
    [q whereKey:TO_USER equalTo:user];
    [q setCachePolicy:kAVCachePolicyNetworkElseCache];
    [q countObjectsInBackgroundWithBlock:block];
}

@end

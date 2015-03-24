//
//  SPInviteService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPInviteService.h"

@implementation SPInviteService

+(void)getStrangersWithfromId:(NSString *)fromId sex:(NSString *)sex engagementType:(EngagementType)type sportType:(SPORTSTYPE)sportType count:(NSInteger)count WithBlock:(AVArrayResultBlock)block ;{
    assert(fromId) ;
    assert(sex) ;//@"男" ,@"女"
    assert(type) ;
    assert(sportType) ;
    assert(count) ;
    assert(block) ;
    
    NSMutableDictionary *Parameters = [[NSMutableDictionary alloc] init] ;
    [Parameters setObject:fromId forKey:@"fromId"] ;
    [Parameters setObject:sex forKey:@"sex"] ;
    [Parameters setObject:SPNum(type) forKey:@"engagementType"] ;
    [Parameters setObject:SPNum(sportType) forKey:@"sportType"] ;
    [Parameters setObject:SPNum(count) forKey:@"count"] ;
    
    [AVCloud callFunctionInBackground:@"getStrangers" withParameters:Parameters block:block] ;
}

+(void)tryCreageEngagementToStranger:(spUser *)stranger sportType:(SPORTSTYPE)sportType WithBlock:(AVObjectResultBlock)block {
    assert(stranger) ;
    assert(sportType) ;
    assert(block) ;
    
    NSMutableDictionary *Parameters = [[NSMutableDictionary alloc] init] ;
    
    spUser *fromUser = [spUser currentUser] ;
    
    [Parameters setObject:[fromUser objectId] forKey:@"fromId"] ;
    [Parameters setObject:[stranger objectId] forKey:@"toId"] ;
    [Parameters setObject:SPNum(EngagementStatusCreatedByCreaterUser) forKey:@"status"] ;
    [Parameters setObject:SPNum(sportType) forKey:@"sportType"] ;
    
    [AVCloud callFunctionInBackground:@"engagementWithStrangers" withParameters:Parameters block:block] ;
}

+(void)findEngagementOfStrangerIsNetWorkOnly:(BOOL)networkOnly ToUser:(spUser *)me WithBlock:(AVArrayResultBlock)block{
    assert(block) ;
    if (me == nil) {
        me = [spUser currentUser] ;
    }
    spUser *curUser = [spUser currentUser] ;
    AVQuery *q = [spEngagement_Stranger query] ;
    
    [SPUtils setPolicyOfAVQuery:q isNetwokOnly:networkOnly] ;
    
    [q setCachePolicy:kAVCachePolicyNetworkElseCache] ;
    [q includeKey:@"fromId"] ;
    [q whereKey:@"toId" equalTo:curUser] ;
    //状态不为拒绝－1
    [q whereKey:@"status" notEqualTo:[NSNumber numberWithInteger:EngagementStatusRejected]] ;
    [q findObjectsInBackgroundWithBlock:block] ;
}

@end

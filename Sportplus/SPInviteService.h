//
//  SPInviteService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import "spCommon.h"

@interface SPInviteService : NSObject

//+(void)countAddRequestsWithBlock:(AVIntegerResultBlock)block;

+(void)getStrangersWithfromId:(NSString *)fromId sex:(NSString *)sex engagementType:(EngagementType)type sportType:(SPORTSTYPE)sportType count:(NSInteger)count WithBlock:(AVArrayResultBlock)block ;

+(void)tryCreageEngagementToStranger:(spUser *)stranger sportType:(SPORTSTYPE)sportType WithBlock:(AVObjectResultBlock)block ;

+(void)findEngagementOfStrangerIsNetWorkOnly:(BOOL)networkOnly ToUser:(spUser *)me WithBlock:(AVArrayResultBlock)block ;

@end

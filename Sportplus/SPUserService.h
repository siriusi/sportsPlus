//
//  SPUserService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "spCommon.h"

@interface SPUserService : NSObject

+(void)findFriendsIsNetworkOnly:(BOOL)networkOnly callback:(AVArrayResultBlock)block;

+(void)findFriendsWithCallback:(AVArrayResultBlock)callback;

//搜索用户
+(void)findUsersByPartname:(NSString*)partName withBlock:(AVArrayResultBlock)block;

//获取用户的peerId
+(NSString*)getPeerIdOfUser:(AVUser*)user;

+(void)findUsersByIds:(NSArray*)userIds callback:(AVArrayResultBlock)callback;

#pragma mark - 头像相关

//显示方的
+(void)displayAvatarOfUser:(AVUser*)user avatarView:(UIImageView*)avatarView;

//显示圆的
+(void)displayCycleAvatarOfUser:(AVUser *)user avatarView:(UIImageView *)avatarView ;

+(UIImage*)getAvatarOfUser:(AVUser*)user;

+(void)saveAvatar:(UIImage*)image callback:(AVBooleanResultBlock)callback;

+(void)saveAvatarAtLocalFile:(UIImage *)image ;

+(void)saveAvatarAtLocal:(UIImage *)image forUser:(AVUser *)user ;

@end

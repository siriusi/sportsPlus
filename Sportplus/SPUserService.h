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

+(void)findUsersByPartname:(NSString*)partName withBlock:(AVArrayResultBlock)block;

+(NSString*)getPeerIdOfUser:(AVUser*)user;

+(void)findUsersByIds:(NSArray*)userIds callback:(AVArrayResultBlock)callback;

+(void)displayAvatarOfUser:(AVUser*)user avatarView:(UIImageView*)avatarView;

+(UIImage*)getAvatarOfUser:(AVUser*)user;

+(void)saveAvatar:(UIImage*)image callback:(AVBooleanResultBlock)callback;


@end

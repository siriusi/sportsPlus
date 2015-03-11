//
//  SPAddRequestService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "addFriendRequest.h"

@interface SPAddRequestService : NSObject

+(void)countAddRequestsWithBlock:(AVIntegerResultBlock)block;

+(void)findAddRequestsOnlyByNetwork:(BOOL)onlyNetwork withCallback:(AVArrayResultBlock)callback;


@end

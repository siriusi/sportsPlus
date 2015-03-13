//
//  spEngagement_Friend.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

#import "spCommonDefine.h"

@interface spEngagement_Friend : AVObject<AVSubclassing>

@property NSDate *when ;
@property AVObject *stadium ;
@property NSString *newstadium ;
@property SPORTSTYPE sportType ;
@property EngagementFriendAnswerStatus answer ;
@property AVUser *fromId ;
@property AVUser *toId ;

+ (NSString *)parseClassName;

@end

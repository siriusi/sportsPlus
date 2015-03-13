//
//  spEngagement_Stranger.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

#import "spCommonDefine.h"


@interface spEngagement_Stranger : AVObject<AVSubclassing>

@property NSDate *when ;
@property AVObject *stadium ;
@property NSString *newstadium ;
@property SPORTSTYPE sportType ;
@property NSInteger status ;
@property AVUser *fromId ;
@property AVUser *toId ;


+ (NSString *)parseClassName;

@end

//
//  spCampus.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/25.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface spCampus : AVObject<AVSubclassing>

@property NSString *campus ;
@property NSString *school ;
@property NSString *schoolFullName ;

+ (NSString *)parseClassName;

@end

//
//  spAcademy.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/26.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface spAcademy : AVObject<AVSubclassing>

@property NSString * academy ;
@property NSString * city ;
@property NSString * province ;
@property NSString * school ;

+ (NSString *)parseClassName;

@end

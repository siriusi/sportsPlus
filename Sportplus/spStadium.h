//
//  spStadium.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface spStadium : AVObject<AVSubclassing>

@property NSString *school ;
@property NSString *city ;
@property NSString *stadium ;
@property NSString *type ;
@property NSString *campus ;
@property NSString *province ;

+ (NSString *)parseClassName;

@end

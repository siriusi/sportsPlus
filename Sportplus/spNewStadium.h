//
//  spNewStadium.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface spNewStadium : AVObject<AVSubclassing>

@property AVUser *createrUserId ;
@property NSString *newstadium ;

+ (NSString *)parseClassName;

@end

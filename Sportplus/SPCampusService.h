//
//  SPCampusService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/25.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "spCommon.h"

@interface SPCampusService : NSObject

+ (void)findCampusByPartname:(NSString *)partname withBlock:(AVArrayResultBlock)block ;

#warning 查找学院没写
+ (void)findAcademyBySchoolName:(NSString *)schoolName withBlock:(AVArrayResultBlock)block ;

@end

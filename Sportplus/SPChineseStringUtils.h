//
//  SPChineseStringUtils.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "pinyin.h"
#import "ChineseString.h"

@interface SPChineseStringUtils : NSObject

+ (NSMutableArray *)getChineseStringArrWithSpUserArray:(NSArray *)dataSourceOfFriendList ;

+ (NSMutableArray *)getChineseStringArr ;

+ (NSMutableArray *)getTitleArray ;

@end

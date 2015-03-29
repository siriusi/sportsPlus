//
//  SPChineseStringUtils.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPChineseStringUtils.h"

#import "spCommon.h"

#define DescriptorKey_PINYIN @"pinYin"

@implementation SPChineseStringUtils

static NSMutableArray *_titleArray = nil ;
static NSMutableArray *_ChineseStringArr = nil ;


//拍好序的user数组
+ (NSMutableArray *)getChineseStringArrWithSpUserArray:(NSArray *)dataSourceOfFriendList ;{
    NSMutableArray *chineseStringsArray = [NSMutableArray array] ;
    
    for (NSInteger i = 0 ; i < [dataSourceOfFriendList count]; i ++ ) {
        ChineseString *chineseString = [[ChineseString alloc] init] ;
        spUser *targetUser = [dataSourceOfFriendList objectAtIndex:i] ;
        [chineseString initChinseseStringWithSPUser:targetUser] ;
        
        [chineseStringsArray addObject:chineseString] ;
    }
    
    _ChineseStringArr = [self sortTheChindeseStringArr:chineseStringsArray] ;
    
    return _ChineseStringArr ;
}

+ (NSMutableArray *)getChineseStringArr {
    return _ChineseStringArr ;
}

+ (NSMutableArray *)getTitleArray {
    return _titleArray ;
}

+ (NSMutableArray *)sortTheChindeseStringArr:(NSMutableArray *)chineseStringsArray {
    NSMutableArray *titleArray = [NSMutableArray array] ;
    
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:DescriptorKey_PINYIN ascending:YES]] ;
    
    [chineseStringsArray sortUsingDescriptors:sortDescriptors] ;
    
    NSMutableArray *arrayForArrays = [NSMutableArray array] ;
    BOOL checkValueAtIndex = NO ;
    NSMutableArray *TempArrForGrouping = nil ;
    for (NSInteger index = 0 ; index < [chineseStringsArray count] ; index++ ) {
        ChineseString *chineseStr = (ChineseString *)chineseStringsArray[index] ;
        NSMutableString *strchar = [NSMutableString stringWithString:chineseStr.pinYin] ;
        NSString *sr = [strchar substringToIndex:1] ;
        NSLog(@"%@",sr) ;
        
        if ( ![titleArray containsObject:[sr uppercaseString]]) {
            [titleArray addObject:[sr uppercaseString]] ;
            TempArrForGrouping = [[NSMutableArray alloc] initWithObjects:nil] ;
            checkValueAtIndex = NO ;
        }
        
        if ([titleArray containsObject:[sr uppercaseString]]) {
            [TempArrForGrouping addObject:chineseStringsArray[index]] ;
            if (checkValueAtIndex == NO) {
                [arrayForArrays addObject:TempArrForGrouping] ;
                checkValueAtIndex = YES ;
            }
        }
    }
    
    _titleArray = titleArray ;
    return arrayForArrays ;
}

@end

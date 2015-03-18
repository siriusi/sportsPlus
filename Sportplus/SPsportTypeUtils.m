//
//  SPsportTypeUtils.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/17.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPsportTypeUtils.h"

@implementation SPsportTypeUtils

+ (UIImage *)getSportImgAtFriendCellWithSportType:(SPORTSTYPE)type {
    NSArray *sportImgNameList = @[@"",@"乒乓球",@"网球",@"足球",@"跑步",@"健身",@"篮球",@"羽毛球"] ;
    return [UIImage imageNamed:sportImgNameList[type]] ;
}

+ (UIImage *)getSportImgAtMainPageWithSportType:(SPORTSTYPE)type Selected:(BOOL)selected {
    
    if ( selected ) {
        return [SPsportTypeUtils getSportSelectedImgAtMainPageWithSportType:type] ;
    } else {
        return [SPsportTypeUtils getSportNormalImgAtMainPageWithSportType:type] ;
    }
    
}

//获取普通图片
+ (UIImage *)getSportNormalImgAtMainPageWithSportType:(SPORTSTYPE)type {
    NSArray *sportImgNameList = @[@"",@"乒乓球",@"网球",@"足球",@"跑步",@"健身",@"篮球",@"羽毛球"] ;
    
    return [UIImage imageNamed:[sportImgNameList[type] stringByAppendingString:@"白2"]] ;
}

//获取选中图片
+ (UIImage *)getSportSelectedImgAtMainPageWithSportType:(SPORTSTYPE)type {
    NSArray *sportImgNameList = @[@"",@"乒乓球",@"网球",@"足球",@"跑步",@"健身",@"篮球",@"羽毛球"] ;
    
    return [UIImage imageNamed:[sportImgNameList[type] stringByAppendingString:@"白2"]] ;
}

+ (UIImage *)getSportLvImageWithSportlevel:(NSInteger)level Selected:(BOOL)selected {
    NSString *preStreing = @"lv" ;
    NSString *appendString = selected ? @"_selected" : @"_normal" ;
    
    NSString *imageName = [NSString stringWithFormat:@"%@%ld%@",preStreing,(long)level,appendString] ;
    
    return [UIImage imageNamed:imageName] ;
}

@end

//
//  SPsportTypeUtils.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/17.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "spCommon.h"

@interface SPsportTypeUtils : NSObject

+ (NSString *)getSPortNameBySportType:(SPORTSTYPE)type ;

+ (UIImage *)getSportImgAtFriendCellWithSportType:(SPORTSTYPE)type ;

+ (UIImage *)getSportImgAtMainPageWithSportType:(SPORTSTYPE)type Selected:(BOOL)selected ;

+ (UIImage *)getSportLvImageWithSportlevel:(NSInteger)level Selected:(BOOL)selected;

@end

//
//  ChineseString.h
//  Sportplus
//
//  Created by Forever.H on 15/3/15.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "spCommon.h"

@interface ChineseString : NSObject

@property(nonatomic, copy)NSString *string;
@property(nonatomic, copy)NSString *pinYin;

@property (nonatomic , weak)spUser *myUser ;

- (void)initChinseseStringWithSPUser :(spUser *)user ;

@end

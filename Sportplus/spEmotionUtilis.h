//
//  spEmotionUtilis.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/14.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface spEmotionUtilis : NSObject

+(NSArray*)getEmotionManagers;
+(NSString*)convertWithText:(NSString*)text toEmoji:(BOOL)toEmoji;

@end

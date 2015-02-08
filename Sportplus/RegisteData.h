//
//  RegisteData.h
//  Sportplus
//
//  Created by humao on 14-12-31.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisteData : NSObject

+(RegisteData *)shareInstance;

@property (nonatomic,strong) NSMutableDictionary *info ;

@end

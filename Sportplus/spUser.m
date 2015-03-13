//
//  spUser.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spUser.h"

@implementation spUser

@dynamic sP_userName ;

@dynamic sP_userTrueName ;
@dynamic sP_school ;
@dynamic sP_academy ;
@dynamic sP_sex ;
@dynamic sP_enterScYear ;
@dynamic sP_friendCount ;
@dynamic sP_validateCount ;
@dynamic sP_reportedCount ;
@dynamic sP_successCount ;

@dynamic sP_tagList ;
@dynamic sP_sportList ;
#warning sP_photoList ;
@dynamic sP_avatar ;

+(NSString *)parseClassName {
    return @"_User" ;
}

- (NSString *)toInfoLabelString {
    NSString *sex = [self sP_sex] ;
    NSString *academy = [self sP_academy] ;
    NSInteger enterSchoolYear = [[self sP_enterScYear] integerValue];

    NSString *info = [NSString stringWithFormat:@"%@，%@，%ld届",sex,academy,(long)enterSchoolYear] ;
    
    return info ;
}

@end

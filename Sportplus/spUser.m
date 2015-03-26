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

@dynamic sP_campus ;

@dynamic sP_academy ;
@dynamic sP_sex ;
@dynamic sP_enterScYear ;
@dynamic sP_friendCount ;
@dynamic sP_validateCount ;
@dynamic sP_reportedCount ;
@dynamic sP_successCount ;

@dynamic sP_tagList ;
@dynamic sP_sportList ;
@dynamic sP_photoIdList ;
@dynamic sP_avatar ;

+(NSString *)parseClassName {
    return @"_User" ;
}

- (NSString *)toInfoLabelString {
    NSString *info ;
    
    NSString *sex = [self sP_sex] ;
    NSString *academy = [self sP_academy] ;
    NSNumber *enterSchoolYear = [self sP_enterScYear] ;

    info = [NSString stringWithFormat:@"%@，%@，%@届",sex,academy,enterSchoolYear] ;
    
    return info ;
}

- (NSString *)toInfoLabelStringOfEnterSchoolJobAndSex {
    NSString *info ;
    
    NSString *sex = [self sP_sex] ;
    NSNumber *enterSchoolYear = [self sP_enterScYear] ;
    
    info = [NSString stringWithFormat:@"%@级 学生 %@",enterSchoolYear,sex] ;
    
    return info ;
}

@end

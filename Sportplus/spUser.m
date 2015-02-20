//
//  spUser.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spUser.h"

@implementation spUser

@dynamic SP_userName ;

@dynamic SP_userTrueName ;
@dynamic SP_school ;
@dynamic SP_academy ;
@dynamic SP_sex ;
@dynamic SP_enterScYear ;
@dynamic SP_friendCount ;
@dynamic SP_validateCount ;
@dynamic SP_reportedCount ;
@dynamic SP_successCount ;

@dynamic SP_tagList ;
@dynamic SP_sportList ;
@dynamic SP_head ;


+(NSString *)parseClassName {
    return @"_User" ;
}


@end

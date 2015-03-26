//
//  SPCampusService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/25.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPCampusService.h"

@implementation SPCampusService

+ (void)findCampusByPartname:(NSString *)partname withBlock:(AVArrayResultBlock)block {
    AVQuery *q = [spCampus query] ;
    
    [q setCachePolicy:kAVCachePolicyNetworkElseCache];
    [q whereKey:@"schoolFullName" containsString:partname];
    [q findObjectsInBackgroundWithBlock:block];
}

@end

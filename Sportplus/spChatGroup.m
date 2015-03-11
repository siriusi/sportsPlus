//
//  spChatGroup.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spChatGroup.h"

@implementation spChatGroup

@dynamic owner ;
@dynamic name ;
@dynamic m ;

+ (NSString *)parseClassName{
    return @"AVOSRealtimeGroups" ;
}

- (NSString *)getTitle {
    NSInteger cnt = self.m.count ;
    return [NSString stringWithFormat:@"%@(%ld)",self.name,(long)cnt];
}

@end

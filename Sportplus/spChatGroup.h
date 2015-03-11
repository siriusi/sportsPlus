//
//  spChatGroup.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface spChatGroup : AVObject<AVSubclassing>

@property NSString* name;
@property NSArray* m;
@property AVUser* owner;

- (NSString *)getTitle ;

@end

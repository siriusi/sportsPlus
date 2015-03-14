//
//  spChatroom.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/14.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "spMsg.h"
#import "spChatGroup.h"

@interface spChatroom : NSObject

@property CDMsgRoomType roomType;
@property spChatGroup* chatGroup;
@property AVUser* chatUser;
@property spMsg* latestMsg;
@property NSInteger unreadCount;//badge

@end

//
//  addFriendRequest.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/8.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#define kAddRequestStatusWait 0
#define kAddRequestStatusDone 1

@interface addFriendRequest : AVObject<AVSubclassing>

@property AVUser *fromUser;
@property AVUser *toUser;
@property int status;

@end

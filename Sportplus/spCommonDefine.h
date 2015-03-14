//
//  spCommonDefine.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/20.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#ifndef Sportplus_spCommonDefine_h
#define Sportplus_spCommonDefine_h

#define USE_US 0
#if !USE_US
//国内节点
#define AppName @"sports"
#define AVOSAppID @"68y9mskzle3aaj8o3gvbsy5zgrtaq9tobl2t0f8uevvvkkrz"
#define AVOSAppKey @"k3wvj25usdhs8y2j0s4fqdavnr5hvjv3yibzfs6b3zsdyfpp"

//LeanChat-Public App
//#define PublicAppId @"g7gz9oazvrubrauf5xjmzp3dl12edorywm0hy8fvlt6mjb1y"
//#define PublicAppKey @"01p70e67aet6dvkcaag9ajn5mff39s1d5jmpyakzhd851fhx"

//Test App
//#define CloudAppId @"xcalhck83o10dntwh8ft3z5kvv0xc25p6t3jqbe5zlkkdsib"
//#define CloudAppKey @"m9fzwse7od89gvcnk1dmdq4huprjvghjtiug1u2zu073zn99"

#else
//北美节点
#define AVOSAppID @""
#define AVOSAppKey @""
#endif

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgb) [UIColor colorWithRed:((rgb) & 0xFF0000 >> 16)/255.0 green:((rgb) & 0xFF00 >> 8)/255.0 blue:((rgb) & 0xFF)/255.0 alpha:1.0]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define USERNAME_MIN_LENGTH 1
#define PASSWORD_MIN_LENGTH 1

#define FROM_USER @"fromUser"
#define TO_USER @"toUser"
#define STATUS @"status"

#warning set NO when release
#define CD_DEBUG YES

#define sp_notificationCenter [NSNotificationCenter defaultCenter]

typedef enum {
    SPORTSTYPE_pingpong = 1 ,
    SPORTSTYPE_tennise ,
    SPORTSTYPE_soccer ,
    SPORTSTYPE_run ,
    SPORTSTYPE_build ,
    SPORTSTYPE_basketball ,
    SPORTSTYPE_badminton
} SPORTSTYPE ;

typedef enum {
    EngagementTypeStrength = 1 , //实力型
    EngagementTypeFriendly , //交友型
}EngagementType;

typedef enum {
    EngagementStatusDone = -1 , //完成
    EngagementStatusCreatedByCreaterUser = 0 , //创建还未回应
    EngagementStatusReceivedUserHasInputInfo = 1 ,//创建，对方用户已经回复信息.
    EngagementStatusCreaterUserHasChangedInfo = 2 ,//修改，己方用户修改信息并回复.
}EngagementStatus ;

typedef enum {
    EngagementFriendAnswerStatusReject = -1 , //拒绝邀约
    EngagementFriendAnswerStatusWait = 0 , //没回复
    EngagementFriendAnswerStatusAccept = 1 ,//同意邀约
} EngagementFriendAnswerStatus;

#define SPNum(s) [NSNumber numberWithInteger:s]

#endif

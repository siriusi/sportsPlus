//
//  spUser.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface spUser : AVUser<AVSubclassing> 

@property NSString *SP_userName ;//电话 [spUser user].username 相同


@property NSString *SP_userTrueName ;//实名
@property NSString *SP_school ;//学校
@property NSString *SP_academy ;//学院
@property NSString *SP_sex ; //{男,女}
@property NSNumber *SP_enterScYear ;//入学年份

@property NSNumber *SP_friendCount ;//朋友数
@property NSNumber *SP_validateCount ;//验证次数
@property NSNumber *SP_reportedCount ;//被举报次数
@property NSNumber *SP_successCount ;//成功运动次数

@property NSArray *SP_tagList ;//tag列表
//@property NSArray *SP_picList ;//照片列表
@property NSArray *SP_sportList ;//运动列表

@property AVFile *SP_avatar ;//头像

@end

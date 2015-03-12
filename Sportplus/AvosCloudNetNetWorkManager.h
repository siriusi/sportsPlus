//
//  AvosCloudNetNetWorkManager.h
//  Sportplus
//
//  Created by humao on 14-12-25.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

typedef NS_OPTIONS(NSUInteger, SportEnum) {
    SportNone       = 0,
    SportPingpang   = 1 << 0 ,
    SportTennis     = 1 << 1 ,
    SportFootball   = 1 << 2 ,
    SportRun        = 1 << 3 ,
    SportBuild      = 1 << 4 ,
    SportBasketball = 1 << 5 ,
    SportBadmintion = 1 << 6 ,
};

typedef enum : BOOL {
    MALE = false ,
    FEMALE = true
} sexEnum;

@protocol AVDataDelegate <NSObject>

@optional

-(void)registeSuccessed:(BOOL) successed ;

/**
 *  更名接口调用后需完成这个回调函数。用于接受状态码.
 *
 *  @param userName  
 *  @param successed
 */
-(void)changeNameToName:(NSString *)userName Successed:(BOOL) successed;

/**
 *  搜索user接口调用回调，接收搜索结果。
 *
 *  @param userList 搜索到的user结果。
 */
-(void)getSearchedUserList:(NSArray *)userList Successed:(BOOL)successed;

@end

@interface AvosCloudNetNetWorkManager : NSObject

+(AvosCloudNetNetWorkManager *)sharedInstace ;

#pragma mark-登录注册退出
-(void)registeWithInfo:(NSDictionary *)Info delegate:(id<AVDataDelegate>)delegate;//注册 [name,psd,school,academy(学院),enterSchoolTime(入学时间),sex,sportsList,sportsLevelList,tagList]
-(void)loginWithUserName:(NSString *)username andPsd:(NSString *)psd ;//登录 [name,psd]
-(void)logoff:(id)sender ;//退出登录

#pragma mark-个人信息

-(void)changeNameToName:(NSString *)userName ; // [name]
-(void)changePsdToPsd:(NSString *)Psd ;// [psd]


-(void)uploadHeadPic ;//上传头像 [pic]
-(void)uploadSelfPic ;//上传照片 [pic]
-(void)changeTags ;//  [tagList]
-(void)changePreferSports ;// [sportsList]

#pragma mark-好友管理
/**
 *  搜索用户名，接收返回值对象应该实现delegate里的getSearchdUserList方法.
 *
 *  @param name     要搜索的用户名
 *  @param delegate 接收返回值的对象。
 */
-(void)searchUserWithUsername:(NSString *)name delegate:(id<AVDataDelegate>)delegate;

/**
 *  发送好友申请
 *
 *  @param target   对象的［userInfo valueForKey:@"target"］ ;
 *  @param delegate
 */
-(void)addFriend:(NSString *)target delegate:(id<AVDataDelegate>)delegate;//申请添加好友 [PeoId]
-(void)acceptAddFriend ;//同意添加好友
-(void)rejectAddFriend ;//拒绝添加好友
-(void)removeFriends ;//解除好友关系 [PeoId]
-(void)report ;//举报 [被举报5次会被封号]这个怎么实现 [PeoId]
-(void)addBlackList ;//添加到黑名单 [PeoId]
-(void)getFriendsList ;//获取好友信息

#pragma mark-约伴管理
-(void)inviteFriends ;//约好友
-(void)inviteStranger ;//约陌生人-->开始匹配[查找对因条件的几个]-->呈现给用户

-(void)acceptInvitation ;//戳 发送消息给戳的人。
-(void)backAcceptInvigation ;//回戳 发送消息给回戳的人，并开一个聊天窗口。
-(void)rejectInvitation ;//过 回复被拒

#pragma mark-需要被推送

//消息管理！

//及时聊天！

//+(void)SNS ;邀请好友

-(void)test ;

-(NSDictionary *)getCurrentUserInfo ;

@end

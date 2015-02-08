//
//  AvosCloudNetNetWorkManager.m
//  Sportplus
//
//  Created by humao on 14-12-25.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "AvosCloudNetNetWorkManager.h"

//typedef enum : NSUInteger {
//    SportPingpang = 1,
//    SportTennis = 1 << 1,
//    SportFootball = 1 << 2,
//    SportRun = 1 << 3 ,
//    SportBuild = 1 << 4 ,
//    SportBasketball = 1 << 5 ,
//    SportBadmintion = 1 << 6 ,
//} SportEnum ;

static AvosCloudNetNetWorkManager *sharedObj = nil ;

@implementation AvosCloudNetNetWorkManager{
    AVObject *currentUserInfo ;
}

+(AvosCloudNetNetWorkManager *)sharedInstace {
    if (!sharedObj){
        sharedObj = [[AvosCloudNetNetWorkManager alloc] init] ;
    }
    return sharedObj ;
}

-(NSDictionary *)getCurrentUserInfo {
    return [self userInfoToDictionary:currentUserInfo] ;
}


-(BOOL)isCurrentUserExists {
    AVUser * currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
        return true ;
    } else {
        //缓存用户对象为空时， 可打开用户注册界面…
        
        return  false ;
    }
}

#pragma mark-登录注册退出
//ok!
-(void)registeWithInfo:(NSDictionary *)Info delegate:(id<AVDataDelegate>)delegate{
    AVUser *user = [AVUser user] ;
    
    user.username = [Info valueForKey:@"userName"] ;
    user.password = [Info valueForKey:@"password"] ;
    
    AVObject *userInfo = [AVObject objectWithClassName:@"userInfo"] ;
    
    [userInfo setObject:user.username forKey:@"name"] ;
    [userInfo setObject:[Info valueForKey:@"sex"] forKey:@"sex"] ;
    
    //set school
    NSString *school = [Info valueForKey:@"school"] ;
    [userInfo setObject:school forKey:@"school"] ;
    
    //set academy
    NSString *academy = [Info valueForKey:@"academy"] ;
    [userInfo setObject:academy forKey:@"academy"] ;
    //set enter school year
    NSNumber *enterScYear = [Info valueForKey:@"enterScYear"] ;
    [userInfo setObject:enterScYear forKey:@"enterScYear"] ;
    [userInfo setObject:[NSNumber numberWithInt:0]forKey:@"reportedCount"] ;
    [userInfo setObject:[NSNumber numberWithInt:0] forKey:@"validatedCount"] ;
    [userInfo setObject:[NSNumber numberWithInt:0] forKey:@"successCount"] ;
    [userInfo setObject:[NSNumber numberWithInt:0] forKey:@"friendCount"] ;
    //default head
    [userInfo setObject:@"default" forKey:@"head"] ;
    {
        //set tag
        NSArray *tags = [Info valueForKey:@"tagList"] ;
        [userInfo addObjectsFromArray:tags forKey:@"tagList"] ;
        //set Pic default
        [userInfo setObject:nil forKey:@"PicList"] ;
        //set sportList
        NSArray *sports = [Info valueForKey:@"sportList"] ;
        [userInfo addObjectsFromArray:sports forKey:@"sportList"] ;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded , NSError *error){
        if (succeeded){
            NSLog(@"注册成功！") ;
            [userInfo setObject:user forKey:@"target"] ;
            [userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"保存成功") ;
                    currentUserInfo = userInfo ;
                    [delegate registeSuccessed:TRUE] ;
                } else {
                    NSLog(@"保存失败") ;
                    currentUserInfo = nil ;
                    [delegate registeSuccessed:FALSE] ;
                }
            }] ;
        } else {
            NSLog(@"失败！") ;
            [delegate registeSuccessed:FALSE] ;
            currentUserInfo = nil ;
        }
    }] ;
    
}

-(void)loginWithUserName:(NSString *)username andPsd:(NSString *)psd{
    [AVUser logInWithUsernameInBackground:username password:psd block:^(AVUser *user, NSError *error) {
        if (user !=nil) {
            //登录成功
            NSLog(@"成功 : %@  %@",user.username,user.password) ;
            [self getSelfInfo] ;
        } else {
            //登录失败
            NSLog(@"登录失败") ;
        }
    }] ;
}
-(void)getSelfInfo {
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"] ;
    [query whereKey:@"target" equalTo:[AVObject objectWithoutDataWithObjectId:[AVUser currentUser].objectId] ];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 1 ) {
                NSLog(@"登录同时获取个人信息成功") ;
                currentUserInfo = [objects objectAtIndex:0] ;
            } else {
                NSLog(@"登录同时获取个人信息失败") ;
            }
        } else {
            NSLog(@"登录同时获取个人信息失败") ;
        }
    }] ;
    
}

//ok!
-(void)logoff:(id)sender{
    [AVUser logOut] ;
    currentUserInfo = nil ;
    UIAlertView *UIAV = [[UIAlertView alloc] initWithTitle:@"成功注销" message:@"成功注销" delegate:sender cancelButtonTitle:@"知道了" otherButtonTitles:nil] ;
    [UIAV show] ;
}

#pragma mark-个人信息
//ok!
-(void)getSelfInfo:(id<AVDataDelegate>)delegate {
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"] ;
    [query whereKey:@"target" equalTo:[AVObject objectWithoutDataWithObjectId:[AVUser currentUser].objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 1 ) {
                NSLog(@"获取个人信息成功") ;
                currentUserInfo = [objects objectAtIndex:0] ;
                [delegate getSelfInfo:[self userInfoToDictionary:[objects objectAtIndex:0]] Successed:TRUE] ;
            } else {
                NSLog(@"获取个人信息失败") ;
                [delegate getSelfInfo:nil Successed:FALSE] ;
            }
        } else {
            NSLog(@"获取个人信息出错") ;
            [delegate getSelfInfo:nil Successed:FALSE] ;
        }
    }];
}

//ok!
-(void)changeNameToName:(NSString *)userName{
    if ([AVUser currentUser] == nil ) {
        NSLog(@"错误请求，请先登录！") ;
        return ;
    }
    
    AVUser *currentUser =[AVUser currentUser] ;
    [currentUser setUsername:userName] ;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            NSLog(@"更名成功:%@",userName) ;
        } else {
            NSLog(@"更名失败:%@",userName) ;
        }
    }] ;
    
    if (currentUserInfo == nil ) {
        AVQuery *query = [AVQuery queryWithClassName:@"userInfo"] ;
        [query whereKey:@"target" equalTo:[AVObject objectWithoutDataWithClassName:@"_User" objectId:currentUser.objectId]] ;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            AVObject *userInfo = [objects objectAtIndex:0] ;
            [userInfo setObject:userName forKey:@"name"] ;
            [userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"更名保存到userInfo成功") ;
                    currentUserInfo = userInfo ;
                } else {
                    NSLog(@"更名保存到userInfo失败") ;
                }
            }] ;
        }] ;
    } else {
        [currentUserInfo setObject:userName forKey:@"name"] ;
    }
}
//ok!
-(void)changePsdToPsd:(NSString *)Psd {
    AVUser *currentUser =[AVUser currentUser] ;
    [currentUser setPassword:Psd] ;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            NSLog(@"更密成功:%@",Psd) ;
        } else {
            NSLog(@"更密失败:%@",Psd) ;
        }
    }] ;
};


#pragma mark-好友管理
-(NSDictionary *)userInfoToDictionary:(AVObject *)userInfo{
    if ( ![[userInfo className]  isEqual: @"userInfo"]) {
        return nil ;
    }
    
    NSMutableDictionary *Info = [[NSMutableDictionary alloc] init] ;
    
    NSString *name = [userInfo valueForKey:@"name"] ;
    NSString *sex = [userInfo valueForKey:@"sex"] ;
    NSString *school = [userInfo valueForKey:@"school"] ;
    NSString *academy = [userInfo valueForKey:@"academy"] ;
    NSString *enterScYear = [userInfo valueForKey:@"enterScYear"] ;
    NSNumber *reportedCount = [userInfo valueForKey:@"reportedCount"] ;
    NSNumber *validatedCount = [userInfo valueForKey:@"validatedCount"] ;
    NSNumber *successCount = [userInfo valueForKey:@"successCount"] ;
    NSNumber *friendCount = [userInfo valueForKey:@"friendCount"] ;
    NSString *head = [userInfo valueForKey:@"head"] ;
    
    NSArray *tagList = [userInfo valueForKey:@"tagList"] ;
    NSArray *PicList = [userInfo valueForKey:@"PicList"] ;
    NSArray *sportList = [userInfo valueForKey:@"sportList"] ;
    
    NSString *target = [[userInfo valueForKey:@"target"] objectId];
    NSString *userInfoId = [userInfo objectId] ;
    
    [Info setValue:name forKey:@"name"] ;
    [Info setValue:sex forKey:@"sex"] ;
    [Info setValue:school forKey:@"school"] ;
    [Info setValue:academy forKey:@"academy"] ;
    [Info setValue:enterScYear forKey:@"enterScYear"] ;
    [Info setValue:reportedCount forKey:@"reportedCount"] ;
    [Info setValue:validatedCount forKey:@"validatedCount"] ;
    [Info setValue:successCount forKey:@"successCount"] ;
    [Info setValue:friendCount forKey:@"friendCount"] ;
    [Info setValue:head forKey:@"head"] ;
    [Info setValue:tagList forKey:@"tagList"] ;
    [Info setValue:PicList forKey:@"PicList"] ;
    [Info setValue:sportList forKey:@"sportList"] ;
    
    [Info setValue:target forKey:@"target"] ;
    [Info setValue:userInfoId forKey:@"userInfoId"] ;
    
    return Info ;
}

//返回一个array里有search的人的userInfo。
-(void)searchUserWithUsername:(NSString *)name delegate:(id<AVDataDelegate>)delegate{
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"] ;
    [query whereKey:@"name" equalTo:name] ;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"搜索成功！") ;
            NSMutableArray *InfoArray = [[NSMutableArray alloc] init] ;
            for (AVObject * obj in objects) {
                [InfoArray addObject:[self userInfoToDictionary:obj]] ;
            }
            [delegate getSearchedUserList:InfoArray Successed:TRUE] ;
        } else {
            NSLog(@"搜索出错！") ;
            [delegate getSearchedUserList:nil Successed:FALSE] ;
        }
    }] ;
}

-(void)addFriend:(NSString *)target delegate:(id<AVDataDelegate>)delegate{
    //建立addFriendRequest;
    //发送推送给target。
    //回调提示发送成功。
}

//同意添加好友
-(void)acceptAddFriend {
    //创建好友关系。
    //删除addFriendRequest;
}

//拒绝添加好友
-(void)rejectAddFriend {
    
}

//解除好友关系 [PeoId]
-(void)removeFriend {
    
}

//获取好友信息
-(void)getFriendsList {
    
}

#pragma mark-约伴管理



#pragma mark-testAVOS

-(void)test{
    // Create the post
    AVObject *myPost = [AVObject objectWithClassName:@"Post"];
    [myPost setObject:@"I'm Smith" forKey:@"title"];
    [myPost setObject:@"Where should we go for lunch?" forKey:@"content"];
    
    // Create the comment
    AVObject *myComment = [AVObject objectWithClassName:@"Comment"];
    [myComment setObject:@"Let's do Sushirrito." forKey:@"content"];
    
    // Add a one-one relation between the Post and Comment
    [myComment setObject:myPost forKey:@"parent"];
    // This will save both myPost and myComment
    [myComment saveInBackground];
}

@end

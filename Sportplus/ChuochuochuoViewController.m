//
//  ChuochuochuoViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChuochuochuoViewController.h"
#import "spCommon.h"
#import "SVProgressHUD.h"
#import "SPInviteService.h"

@interface ChuochuochuoViewController () {
    SPORTSTYPE _sportType ;
    NSMutableArray *_strangers ;
    NSArray *_strangerIds ;
    
    spUser *_currentStrangers ;
    NSInteger _currentStrangerIndex ;
}

@end

@implementation ChuochuochuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _strangers = [[NSMutableArray alloc] init] ;
    _currentStrangerIndex = 0 ;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated] ;
    
    [self getUserInfoAtCurrentIndex] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:TRUE] ;
}

- (IBAction)ChuoBtnClicked:(id)sender {
#warning test!!!!!
    [self tryCreageEngagementToStrangerWithUser:_currentStrangers] ;
}

- (IBAction)guoBtnClicked:(id)sender {
    [self setSelfToNextUser] ;
#warning show AlertView 还剩次数
}

#pragma mark - Other Method

- (void)receiveUsers:(NSArray *)userIds {
    _strangerIds = userIds ;
}

- (void)getUserInfoAtCurrentIndex {
    [self getUserInfoById:[_strangerIds objectAtIndex:_currentStrangerIndex]] ;
}

- (void)getUserInfoById:(NSString *)userId {
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    [SPUserService findUsersByIds:@[userId] callback:^(NSArray *objects, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SVProgressHUD dismiss] ;
        
        if (!error) {
            NSLog(@"objects = %@",objects) ;
            _currentStrangers = [objects lastObject] ;
            [self setSelfToCurrentUser] ;
        } else {
            NSLog(@"error = %@",[error localizedDescription]) ;
        }
    }] ;
}

- (void)setSelfToCurrentUser {
    assert(_currentStrangers) ;
    [self.navigationItem setTitle:[_currentStrangers sP_userName]] ;
    [self.InfoLabel setText:[_currentStrangers toInfoLabelString]] ;
#warning 照片
}

- (void)setSelfToNextUser {
    _currentStrangerIndex ++ ;
    if ( _currentStrangerIndex + 1 <= [_strangerIds count] ) {
        [self getUserInfoAtCurrentIndex] ;
    } else {
        [SPUtils alert:@"已经没有下一个了！"] ;
    }
}

- (void)tryCreageEngagementToStrangerWithUser:(spUser *)stranger {
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    
    {
#warning test代码
        _sportType = SPORTSTYPE_badminton ;
    }
        
    [SPInviteService tryCreageEngagementToStranger:stranger sportType:_sportType WithBlock:^(AVObject *object, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SVProgressHUD dismiss] ;
        
        if (!error) {
            NSLog(@"Engagement = %@",object) ;
        } else {
            [SPUtils alertError:error] ;
            NSLog(@"error = %@",error) ;
        }
    }] ;
    
    #warning show AlertView加仔已经帮你通知了。逻辑是退出还是下一人。
}

@end

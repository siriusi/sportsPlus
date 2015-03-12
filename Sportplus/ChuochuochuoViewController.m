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
    NSArray * _strangers ;
    spUser *_currentStrangers ;
    NSInteger _currentStrangerIndex ;
}

@end

@implementation ChuochuochuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)setSelfToNextUser {
    _currentStrangerIndex ++ ;
    _currentStrangers = [_strangers objectAtIndex:_currentStrangerIndex] ;
    
    NSLog(@"换照片啦！") ;
    NSLog(@"换nav。title啦") ;
    NSLog(@"换info啦") ;
}

- (void)tryCreageEngagementToStrangerWithUser:(spUser *)stranger {
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    
    
    
    {
        //test
        stranger = [spUser objectWithoutDataWithObjectId:@"55007a48e4b00aa930033f72"] ;
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

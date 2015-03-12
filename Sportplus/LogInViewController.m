//
//  LogInViewController.m
//  Sportplus
//
//  Created by Forever.H on 15/3/4.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"
#import "AvosCloudNetNetWorkManager.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    NSLog(@"back!") ;
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)loginBtnClicked:(id)sender {
    NSString *userName = [self.userNameTextField text];
    NSString *password = [self.psdTextField text];
    
    [[AvosCloudNetNetWorkManager sharedInstace] loginWithUserName:userName andPsd:password] ;
    
}

@end

//
//  test1stVC.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "test1stVC.h"
#import <AVOSCloud/AVOSCloud.h>

@interface test1stVC ()

@end

@implementation test1stVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtnClicked:(id)sender {
    [AVUser logInWithUsernameInBackground:@"18817870386" password:@"123698745" block:^(AVUser *user, NSError *error) {
        if (user !=nil) {
            //登录成功
            NSLog(@"成功 : %@  %@",user.username,user.password) ;
            [self toTest2] ;
            
        } else {
            //登录失败
            NSLog(@"登录失败") ;
        }
    }] ;
}

- (IBAction)logoffBtnClicked:(id)sender {
    [AVUser logOut] ;
    UIAlertView *UIAV = [[UIAlertView alloc] initWithTitle:@"成功注销" message:nil delegate:sender cancelButtonTitle:@"知道了" otherButtonTitles:nil] ;
    [UIAV show] ;
}

- (void) toTest2 {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

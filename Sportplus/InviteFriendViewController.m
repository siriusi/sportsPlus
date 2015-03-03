//
//  InviteFriendViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/3.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "InviteFriendViewController.h"

@interface InviteFriendViewController ()

@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController setNavigationBarHidden:YES] ;
    [self.navigationController popViewControllerAnimated:YES] ;
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

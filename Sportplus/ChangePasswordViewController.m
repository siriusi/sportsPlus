//
//  ChangePasswordViewController.m
//  Sportplus
//
//  Created by Forever.H on 15/3/8.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtn:(id)sender {
    NSLog(@"修改密码成功！");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backToPreViewBtn:(id)sender {
    NSLog(@"back!");
    [self.navigationController popViewControllerAnimated:YES];
}
@end

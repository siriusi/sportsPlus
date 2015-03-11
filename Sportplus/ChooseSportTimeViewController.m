//
//  ChooseSportTimeViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChooseSportTimeViewController.h"

@interface ChooseSportTimeViewController ()

@end

@implementation ChooseSportTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    NSLog(@"确定") ;
    
    [self.navigationController popViewControllerAnimated:YES] ;
}


@end

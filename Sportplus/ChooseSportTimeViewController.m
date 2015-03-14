//
//  ChooseSportTimeViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChooseSportTimeViewController.h"
#import "spCommon.h"

@interface ChooseSportTimeViewController ()

@end

@implementation ChooseSportTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    NSDate *date = [self.datePicker date] ;
    [sp_notificationCenter postNotificationName:NOTIFICATION_TIME_CHOOSED object:date] ;
    
    [self.navigationController popViewControllerAnimated:YES] ;
}


@end

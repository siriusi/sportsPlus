//
//  chooseWitchToInviteViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "chooseWitchToInviteViewController.h"

@interface chooseWitchToInviteViewController ()

@end

@implementation chooseWitchToInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.navigationController.navigationBar) ;
    [self.navigationController setNavigationBarHidden:YES] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)toInviteStrangerViewController:(id)sender {
    [self performSegueWithIdentifier:@"chooseToStrangerSegueID" sender:self] ;
}

- (IBAction)toInviteFriendViewController:(id)sender {
    [self performSegueWithIdentifier:@"chooseToFriendSegueID" sender:self] ;
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.navigationController setNavigationBarHidden:NO] ;
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES] ;
}


@end

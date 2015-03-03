//
//  InviteStrangerViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "InviteStrangerViewController.h"
#import "spCommon.h"

#define FRIENDLY_NORMAL_ICON @"FriendlyIconNormal"
#define FRIENDLY_SELECTED_ICON @"FriendlyIconSelected"
#define COMPETITION_NORMAL_ICON @"CompetitionIconNoraml"
#define COMPETITION_SELECTED_ICON @"CompetitionIconSelected"

#define IMAGE(name) [UIImage imageNamed:name]

typedef enum {
    NONE_SELECTED = 0 ,
    COMPETITION_SELECTED = 1 ,
    FRIENDLY_SELECTED = 2 ,
} BtnState;

@interface InviteStrangerViewController () {
    BtnState state ;
}

@end

@implementation InviteStrangerViewController

- (void)setState:(BtnState)st {
    state = st ;
    if (state == NONE_SELECTED) {
        [self.CompetitionButton setImage:IMAGE(COMPETITION_NORMAL_ICON) forState:UIControlStateNormal] ;
        [self.FriendlyButton setImage:IMAGE(FRIENDLY_NORMAL_ICON) forState:UIControlStateNormal] ;
    }
    
    if (state == COMPETITION_SELECTED ) {
        [self.CompetitionButton setImage:IMAGE(COMPETITION_SELECTED_ICON) forState:UIControlStateNormal] ;
        [self.FriendlyButton setImage:IMAGE(FRIENDLY_NORMAL_ICON) forState:UIControlStateNormal] ;
    }
    
    if (state == FRIENDLY_SELECTED) {
        [self.CompetitionButton setImage:IMAGE(COMPETITION_NORMAL_ICON) forState:UIControlStateNormal] ;
        [self.FriendlyButton setImage:IMAGE(FRIENDLY_SELECTED_ICON) forState:UIControlStateNormal] ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setHidden:NO] ;
//
//    CGRect fm = CGRectMake(0, 64, 320, 568) ;
//    [self.view setFrame:fm] ;
//    CGRect fm2 = CGRectMake(0, 20, 320, 44) ;
//    [self.navigationController.navigationBar setFrame:fm2] ;
    
    [self setState:NONE_SELECTED] ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)CompetitionBtnClicked:(id)sender {
    [self setState:COMPETITION_SELECTED] ;
}

- (IBAction)FriendlyBtnClicked:(id)sender {
    [self setState:FRIENDLY_SELECTED] ;
}


- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController setNavigationBarHidden:YES] ;
    [self.navigationController popViewControllerAnimated:YES] ;
}


@end

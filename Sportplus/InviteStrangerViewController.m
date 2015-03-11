//
//  InviteStrangerViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "InviteStrangerViewController.h"
#import "spCommon.h"
#import "ChooseSportItemTableViewCell.h"

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
    [self setState:NONE_SELECTED] ;
    
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ChooseSportItemTBVCellID" ;
    ChooseSportItemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportItemTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;//箭头 ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"createStrangerTochooseSportVCSegueID" sender:self] ;
}

#pragma mark-IBAction

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

- (IBAction)ensureBtnClicked:(id)sender {
    
}


@end

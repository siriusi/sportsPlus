//
//  StrangerInviteManageViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/28.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "StrangerInviteManageViewController.h"
#import "spCommon.h"

#define BtnSelectedColor RGBCOLOR(0, 0, 0)
#define BtnNormalColor RGBCOLOR(234, 234, 234)

typedef enum {
    StrangerNavBtnStateLeftBtnSelected = 0 ,
    StrangerNavBtnStateRightBtnSelected = 1 ,
} StrangerNavBtnState;

@interface StrangerInviteManageViewController () {
    NSArray *_dataSource ;//spEngagement_Stranger
    
    StrangerNavBtnState _BtnState ;
}

@end

@implementation StrangerInviteManageViewController

- (void)setBtnState:(StrangerNavBtnState)state {
    _BtnState = state ;
    if (_BtnState == StrangerNavBtnStateLeftBtnSelected) {
        [self.LeftBtnHignLightLine setHidden:FALSE] ;
        [self.checkSendedInviteBtn setTitleColor:BtnSelectedColor forState:UIControlStateNormal] ;
        
        [self.RightBtnHighLightLine setHidden:TRUE] ;
        [self.checkReceivedInviteBtn setTitleColor:BtnNormalColor forState:UIControlStateNormal] ;
    } else {
        [self.RightBtnHighLightLine setHidden:FALSE] ;
        [self.checkSendedInviteBtn setTitleColor:BtnNormalColor forState:UIControlStateNormal] ;
        
        [self.LeftBtnHignLightLine setHidden:TRUE] ;
        [self.checkReceivedInviteBtn setTitleColor:BtnSelectedColor forState:UIControlStateNormal] ;
    }
    
    [self.tableView reloadData] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    
    [self setBtnState:StrangerNavBtnStateLeftBtnSelected] ;
    
    _dataSource = @[@"1",@"2",@"3"] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"InviteInfoTableViewCellID" ;
    
    InviteInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InviteInfoTableViewCell" owner:self options:nil] lastObject];
    }
    
    /*config cell*/{
        cell.delegate = self ;
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(56, 204, 90) title:@"接受"] ;
        [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(248, 45 , 64) title:@"拒绝"] ;
        cell.leftUtilityButtons = leftUtilityButtons ;
        cell.rightUtilityButtons = rightUtilityButtons ;
        [cell setRightUtilityButtons:rightUtilityButtons WithButtonWidth:70] ;
    }
    
    return cell ;
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    NSLog(@"index = %ld",(long)index) ;
}

#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)checkSendedBtnClicked:(id)sender {
    [self setBtnState:StrangerNavBtnStateLeftBtnSelected] ;
}

- (IBAction)checkReceivedBtnClicked:(id)sender {
    [self setBtnState:StrangerNavBtnStateRightBtnSelected] ;
}

#pragma mark - NetWork Method 

- (void)getData {
    //本地获取和网络获取新的。
}

- (void)accpet {
    //回戳
}

- (void)reject {
    //过
}

- (void)delete {
    //本地删除记录
    
}


@end

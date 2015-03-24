//
//  StrangerInviteManageViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/28.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "StrangerInviteManageViewController.h"
#import "spCommon.h"
#import "SPInviteService.h"

#import "sendMyInviteStrangerInfoViewController.h"

#define BtnSelectedColor RGBCOLOR(0, 0, 0)
#define BtnNormalColor RGBCOLOR(234, 234, 234)

typedef enum {
    StrangerNavBtnStateLeftBtnSelected = 0 ,
    StrangerNavBtnStateRightBtnSelected = 1 ,
} StrangerNavBtnState;

@interface StrangerInviteManageViewController () {
    NSMutableArray *_dataSource ;//spEngagement_Stranger
    
    StrangerNavBtnState _BtnState ;
    
    UIRefreshControl *_refreshControl ;
    
    NSInteger _choosedEngagementId ;
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
    {
        self.tableView.delegate = self ;
        self.tableView.dataSource = self ;
        
        //refresh Control
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init] ;
        [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged] ;
        _refreshControl = refreshControl ;
        [self.tableView addSubview:refreshControl] ;
    }
    [self setBtnState:StrangerNavBtnStateLeftBtnSelected] ;
    
    [self refresh:nil] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"InviteStrangerInfoTableViewCellID" ;
    
    InviteStrangerInfoTableViewcell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InviteStrangerInfoTableViewcell" owner:self options:nil] lastObject];
    }
    
    /*config cell*/{
        cell.delegate = self ;
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(56, 204, 90) title:@"回戳"] ;
        [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(248, 45 , 64) title:@"过"] ;
        cell.leftUtilityButtons = leftUtilityButtons ;
        cell.rightUtilityButtons = rightUtilityButtons ;
        [cell setRightUtilityButtons:rightUtilityButtons WithButtonWidth:70] ;
        
        [cell setTag:indexPath.row] ;
        [cell initWithEngagementStranger:(spEngagement_Stranger *)[_dataSource objectAtIndex:indexPath.row]] ;
    }
    
    return cell ;
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
    if (index == 0) {
        //回戳 建立聊天室
        [self acceptEngagementAtIndex:[cell tag]] ;
    } else {
        //过 删除
        [self rejectEngagementAtIndex:[cell tag]] ;
    }
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

- (void)acceptEngagementAtIndex:(NSInteger)index {
    //回戳
    static NSString *segueId = @"backchuoToSendMyInviteInfoVCSegueId" ;
    _choosedEngagementId = index ;
    [self performSegueWithIdentifier:segueId sender:self] ;
}

- (void)rejectEngagementAtIndex:(NSInteger)index {
    //过
    spEngagement_Stranger *rejectedEngagement = [_dataSource objectAtIndex:index] ;
    [rejectedEngagement setStatus:EngagementStatusRejected] ;
    
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    [rejectedEngagement saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SVProgressHUD dismiss] ;
        if (succeeded) {
            NSLog(@"成功拒绝") ;
            [_dataSource removeObjectAtIndex:index] ;
            [self.tableView reloadData] ;
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
}

- (void)delete {
    //本地删除记录
    [SPUtils alert:@"还么有！"] ;
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    BOOL networkOnly = ( refreshControl != nil ) ;
    NSLog(@"开始刷新邀约") ;
    [SPUtils showNetworkIndicator];
    
    [SPInviteService findEngagementOfStrangerIsNetWorkOnly:networkOnly ToUser:[spUser currentUser] WithBlock:^(NSArray *objects, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SPUtils stopRefreshControl:_refreshControl] ;
        if (!error) {
            _dataSource = [objects mutableCopy];
            [self.tableView reloadData] ;
        } else {
            [SPUtils alertError:error] ;
        }
        
    }] ;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //耦合_choosedEngagementId
    if ( [segue.identifier isEqualToString:@"backchuoToSendMyInviteInfoVCSegueId"]  ) {
        ((sendMyInviteStrangerInfoViewController *)segue.destinationViewController).currentEngagement = [_dataSource objectAtIndex:_choosedEngagementId] ;
    }
}


@end

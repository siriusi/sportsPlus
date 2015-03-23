//
//  sendMyInviteStrangerInfoViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/15.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "sendMyInviteStrangerInfoViewController.h"
#import "ChoosePlaceTableViewCell.h"
#import "spMsg.h"
#import "SPSessionManager.h"

@interface sendMyInviteStrangerInfoViewController () {
//    AVObject *_choosedStadium ;
    
}

@end

@implementation sendMyInviteStrangerInfoViewController

- (void)registeNotification {
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_STADIUM_CHOOSED object:nil] ;
    [sp_notificationCenter addObserver:self selector:@selector(phraseStadium:) name:NOTIFICATION_STADIUM_CHOOSED object:nil] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registeNotification] ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_STADIUM_CHOOSED object:nil] ;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"ChoosePlaceTableViewCellID" ;
    ChoosePlaceTableViewCell *cell ;
    
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellId] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePlaceTableViewCell" owner:self options:nil] lastObject];
    }
    
    return cell ;
}

#pragma mark - UITableVIewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning bug!!数据无法使用
    static NSString *segueId = @"MySportInviteInfoVC2PlaceSegueID" ;
    [self performSegueWithIdentifier:segueId sender:self] ;
}

#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    //设置Engagement
    //发送msg过去
    //建立聊天室并发送。
//    _currentEngagement
    {
        NSDate *date = [self.datePicker date] ;
        [_currentEngagement setWhen:date] ;
        
#warning Stadium为空 ;
        [_currentEngagement setStadium:nil] ;
        
        EngagementStatus Status = [_currentEngagement status] ;
        
        if (Status == EngagementStatusCreatedByCreaterUser) {
            //接受
            [_currentEngagement setStatus:EngagementStatusReceivedUserHasInputInfo] ;
        } else
            if (Status == EngagementStatusReceivedUserHasInputInfo) {
                //修改
                [_currentEngagement setStatus:EngagementStatusCreaterUserHasChangedInfo] ;
            } else
                if (Status == EngagementStatusCreaterUserHasChangedInfo) {
                    //再次修改
                    [_currentEngagement setStatus:EngagementStatusReceivedUserHasInputInfo] ;
                }
    }
    
#warning 通知所有VC修改currentEngagement
    [SPUtils showNetworkIndicator] ;
    [_currentEngagement saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        
        if (!error) {
            //send Msg ;
#warning ！！！！！！！！！！！！！send Msg ;
            [[SPSessionManager sharedInstance] sendMessageWithObjectId:nil content:[_currentEngagement objectId] type:CDMsgTypeWithEngagement toPeerId:[_currentEngagement getOtherId] group:nil] ;
            [self.navigationController popViewControllerAnimated:YES] ;
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
    
}

#pragma mark - Notification 

- (void)phraseStadium:(NSNotification *)sender {
#warning bug!!数据无法对应
//    [self.tableView reloadData] ;
    
}

@end

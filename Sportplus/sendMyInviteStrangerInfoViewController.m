//
//  sendMyInviteStrangerInfoViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/15.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "sendMyInviteStrangerInfoViewController.h"
#import "ChoosePlaceTableViewCell.h"

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
    //建立聊天室并发送。
    
    
}

#pragma mark - Notification 

- (void)phraseStadium:(NSNotification *)sender {
#warning bug!!数据无法对应
//    [self.tableView reloadData] ;
}

@end

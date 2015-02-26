//
//  spNotificationCenterViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/25.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spNotificationCenterViewController.h"
#import "spNotificationCenterTableViewCell.h"

#define NOTIFICATION_CELL_NUM 4

@interface spNotificationCenterViewController () {
    NSArray *TitleArray ;
    NSArray *SegueIDs ;
}

@end

@implementation spNotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    TitleArray = @[@"好友约伴",@"陌生人约伴",@"好友申请",@"即时聊天"] ;
    SegueIDs = @[@"MsgCenterToFriendInviteVc",
                 @"MsgCenterToStrangerInviteVc",
                 @"MsgCenterToAddRequestListVc",
                 @"MsgCenterToChatListVc"] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return NOTIFICATION_CELL_NUM ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"spNotificationCenterTableViewCellID";
    
    spNotificationCenterTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (!cell) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"spNotificationCenterTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (cell) {
        [cell.Title setText:[TitleArray objectAtIndex:indexPath.row]] ;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    }
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row ;
    NSString *SegueID = [SegueIDs objectAtIndex:index] ;
    [self performSegueWithIdentifier:SegueID sender:self] ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ChatRoomListViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChatRoomListViewController.h"
#import "spCommon.h"
#import "spMessageTableViewController.h"

@interface ChatRoomListViewController () {
    NSArray *_dataSource ;
}

@end

@implementation ChatRoomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    _dataSource = @[@"1",@"2",@"3"] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ChatRoomListTableViewCellID" ;
    ChatRoomListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatRoomListTableViewCell" owner:self options:nil] lastObject];
    }
    
    /*config cell*/{
        cell.delegate = self ;
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(247, 45 , 64) title:@"解散"] ;
        cell.leftUtilityButtons = leftUtilityButtons ;
        [cell setRightUtilityButtons:rightUtilityButtons WithButtonWidth:65] ;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row) ;
    static NSString *segueID = @"chatRoomList2chatRoom" ;
    
    [self performSegueWithIdentifier:segueID sender:self] ;
    
    
    
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index) ;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ( [segue.identifier isEqualToString: @"chatRoomList2chatRoom"] ) {
        spMessageTableViewController *Vc = (spMessageTableViewController *)segue.destinationViewController ;
        [Vc getMessage] ;
    }
    
}

@end

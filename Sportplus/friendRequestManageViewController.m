//
//  friendRequestManageViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "friendRequestManageViewController.h"
#import "friendRequestTableViewCell.h"

@interface friendRequestManageViewController () {
    NSArray *dataSource ;
}

@end

@implementation friendRequestManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    dataSource = @[@"233",@"244",@"255"] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return [dataSource count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FruebdRequestTableViewCellID" ;
    
    friendRequestTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"friendRequestTableViewCell" owner:self options:nil] lastObject];
    }
    
    [cell.nameLabel setText:@"张睿啊"] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    if (indexPath.row == 1) {
        [cell.jobLabel setText:@"工程师"] ;
        cell.MycellState = cellStateAccept ;
        [cell.acceptFriendRequestButton setTitle:@"已同意" forState:UIControlStateDisabled] ;
        cell.acceptFriendRequestButton.enabled = FALSE ;
    }
    
    return cell ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

@end

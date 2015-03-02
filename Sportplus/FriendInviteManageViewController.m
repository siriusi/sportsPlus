//
//  FriendInviteManageViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "FriendInviteManageViewController.h"
#import "spCommon.h"

#define BtnSelectedColor RGBCOLOR(0, 0, 0)
#define BtnNormalColor RGBCOLOR(234, 234, 234)


@interface FriendInviteManageViewController () {
    NSArray *dataSource ;
}

@end

@implementation FriendInviteManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3 ;
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
        [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(127, 127, 127) title:@"卧槽"] ;
        [leftUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(0, 0, 0) title:@"testLeft"] ;
        cell.leftUtilityButtons = leftUtilityButtons ;
        cell.rightUtilityButtons = rightUtilityButtons ;
    }
    
    return cell ;
}

#pragma mark - SWTableViewCellDelegate

#pragma mark - IBAction
- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

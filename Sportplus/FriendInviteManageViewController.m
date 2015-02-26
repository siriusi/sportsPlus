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
    return 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil ;
}


@end

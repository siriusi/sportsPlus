//
//  BlackListViewController.m
//  Sportplus
//
//  Created by Forever.H on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "BlackListViewController.h"
#import "SettingTableViewCell.h"
@interface BlackListViewController ()

@end

@implementation BlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.blakListTableView setDataSource:self];
    [self.blakListTableView setDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *settingCellIdentifier = @"accountCellIdentifier";
    SettingTableViewCell *cell = [self.blakListTableView dequeueReusableCellWithIdentifier:settingCellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:self options:nil] lastObject];
    }

    [cell.btn setTitle:@"移除" forState:UIControlStateNormal];
    cell.img.image = [UIImage imageNamed:@"head"];
    cell.nameLable.hidden = NO;
    [cell.btn addTarget:self action:@selector(removePeople:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)removePeople:(UIButton *)sender{
    SettingTableViewCell *cell = (SettingTableViewCell *)[[sender superview] superview];
    NSIndexPath *path = [self.blakListTableView indexPathForCell:cell];
    NSLog(@"click btn is %ld",(long)path.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



- (IBAction)backToPreViewBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

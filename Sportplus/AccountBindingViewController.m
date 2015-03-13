//
//  AccountBindingViewController.m
//  Sportplus
//
//  Created by Forever.H on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "AccountBindingViewController.h"
#import "SettingTableViewCell.h"
@interface AccountBindingViewController ()

@end

@implementation AccountBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.accountTableView setDelegate:self];
    [self.accountTableView setDataSource:self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *settingCellIdentifier = @"accountCellIdentifier";
    SettingTableViewCell *cell = [self.accountTableView dequeueReusableCellWithIdentifier:settingCellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;

}

- (void)bindingBtn:(UIButton *)sender{
    SettingTableViewCell *cell = (SettingTableViewCell *)[[sender superview] superview];
    NSIndexPath *path = [self.accountTableView indexPathForCell:cell];
    NSLog(@"click btn is %ld",(long)path.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



- (IBAction)backToPreViewBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

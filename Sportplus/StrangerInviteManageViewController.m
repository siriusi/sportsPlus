//
//  StrangerInviteManageViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/28.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "StrangerInviteManageViewController.h"
#import "spCommon.h"

#define BtnSelectedColor RGBCOLOR(0, 0, 0)
#define BtnNormalColor RGBCOLOR(234, 234, 234)

@interface StrangerInviteManageViewController () {
    NSArray *_dataSource ;
}

@end

@implementation StrangerInviteManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    
    _dataSource = @[@"1",@"2",@"3"] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource count] ;
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


- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
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

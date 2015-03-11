//
//  ChooseSportSpaceViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChooseSportSpaceViewController.h"

@interface ChooseSportSpaceViewController ()

@end

@implementation ChooseSportSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAction

- (IBAction)systemIncludeBtnClicked:(id)sender {
}

- (IBAction)userDefineBtnClicked:(id)sender {
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    NSLog(@"确定") ;
    [self.navigationController popViewControllerAnimated:YES] ;
}

@end

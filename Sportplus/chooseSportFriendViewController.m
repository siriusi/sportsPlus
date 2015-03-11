//
//  chooseSportFriendViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "chooseSportFriendViewController.h"
#import "chooseFriendTableViewCell.h"

@interface chooseSportFriendViewController ()

@end

@implementation chooseSportFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)ensureBtnClicked:(id)sender {
    NSLog(@"确定") ;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"chooseFriendTableViewCellID" ;
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID] ;
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"chooseFriendTableViewCell" owner:self options:nil] lastObject];
    }
    
    return cell ;
}

@end

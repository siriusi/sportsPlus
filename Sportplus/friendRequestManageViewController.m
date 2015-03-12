//
//  friendRequestManageViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "friendRequestManageViewController.h"
#import "friendRequestTableViewCell.h"

#import "spCommon.h"
#import "SPAddRequestService.h"
#import "SPCloudSevice.h"

@interface friendRequestManageViewController () {
    NSMutableArray *_dataSourceOfFriendRequest ;
    UIRefreshControl *_refreshControl ;
}

@end

@implementation friendRequestManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    UIRefreshControl* refreshControl=[[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(getAddRequest:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl] ;
    _refreshControl = refreshControl ;
    
    [self getAddRequest:nil] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return _dataSourceOfFriendRequest != nil ? [_dataSourceOfFriendRequest count] : 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FruebdRequestTableViewCellID" ;
    
    friendRequestTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"friendRequestTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    {
        addFriendRequest *addRequest = [_dataSourceOfFriendRequest objectAtIndex:indexPath.row] ;
        
        [cell.nameLabel setText:@"test"] ;
        //btn
        [cell.acceptFriendRequestButton setTag:indexPath.row] ;
        [cell.acceptFriendRequestButton addTarget:self action:@selector(acceptBtnClicked:) forControlEvents:UIControlEventTouchUpInside] ;
        
        if (addRequest.status == kAddRequestStatusWait) {
            //Wait
            [cell.acceptFriendRequestButton setTitle:@"接受" forState:UIControlStateNormal] ;
            cell.acceptFriendRequestButton.enabled =TRUE ;
        } else {
            //Done
            [cell.acceptFriendRequestButton setTitle:@"已处理" forState:UIControlStateDisabled] ;
            cell.acceptFriendRequestButton.enabled = FALSE ;
        }
    }
    
//    if (indexPath.row == 1) {
//        [cell.jobLabel setText:@"工程师"] ;
//        cell.MycellState = cellStateAccept ;
//        [cell.acceptFriendRequestButton setTitle:@"已同意" forState:UIControlStateDisabled] ;
//        cell.acceptFriendRequestButton.enabled = FALSE ;
//    }
    
    return cell ;
}

#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (void)acceptBtnClicked:(UIButton *)sender {
    addFriendRequest *addRequest = [_dataSourceOfFriendRequest objectAtIndex:[sender tag]] ;
    
    [SPUtils showNetworkIndicator] ;
    
    [SPCloudSevice agreeAddRequestWithId:[addRequest objectId] callback:^(id object, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        if(error){
            [SPUtils alert:[error localizedDescription]];
        }else{
            [SPUtils alert:@"添加成功"];
            [self getAddRequest:sender] ;
            [[NSNotificationCenter defaultCenter] postNotificationName:SP_FRIEND_UPDATE object:nil];
        }
    }] ;
    
}

#pragma mark - NetWork Method

- (void)getAddRequestCount {
    [SPAddRequestService countAddRequestsWithBlock:^(NSInteger number, NSError *error) {
        NSLog(@"number = %ld",(long)number) ;
    }] ;
}

- (void)getAddRequest:(id)sender {
    BOOL onlyNetwork ;
    if (sender == nil) {
        onlyNetwork = NO ;
    } else {
        onlyNetwork = YES ;
    }
    
    [SPUtils showNetworkIndicator] ;
    [SPAddRequestService findAddRequestsOnlyByNetwork:TRUE withCallback:^(NSArray *objects, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [_refreshControl endRefreshing] ;
        if(error.code==kAVErrorObjectNotFound){
        }else{
            [SPUtils filterError:error callback:^{
                _dataSourceOfFriendRequest=[NSMutableArray arrayWithArray:objects];
                [self.tableView reloadData];
            }];
        }
    }] ;
}

@end

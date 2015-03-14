//
//  AddFriendsViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/21.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "searchFriendTableViewCell.h"

#import "spCommon.h"
#import "spAVModels.h"
#import "SPCloudSevice.h"

@interface AddFriendsViewController () {
    NSMutableArray *_dataSourceOfSearchedUser ;
}

@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchFriendTableView setDelegate:self];
    [self.searchFriendTableView setDataSource:self];

    _dataSourceOfSearchedUser = [[NSMutableArray alloc] init] ;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
#warning 并不是这样！
//    [self doSearch] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FriendCellIdentifier = @"searchFriendCellIdentifier";
    
    searchFriendTableViewCell *cell = [self.searchFriendTableView dequeueReusableCellWithIdentifier:FriendCellIdentifier];
    if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"searchFriendTableViewCell" owner:self options:nil] lastObject];
        }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    {
        spUser *searchedUser = (spUser *)[_dataSourceOfSearchedUser objectAtIndex:indexPath.row] ;
        
        NSLog(@"data = %@",searchedUser) ;
        
        [cell.name setText:searchedUser.sP_userName] ;
        [cell.year setText:searchedUser.sP_enterScYear.stringValue ] ;
        
        [cell.btn setTag:indexPath.row] ;
        [cell.btn addTarget:self action:@selector(addFriendBtnClicked:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceOfSearchedUser != nil ? [_dataSourceOfSearchedUser count] : 0 ;

}

- (void)doSearchWithName:(NSString *)name {
    [SPUserService findUsersByPartname:name withBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            _dataSourceOfSearchedUser = [[NSMutableArray alloc] initWithArray:objects] ;
            [self.searchFriendTableView reloadData] ;
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
}

#pragma mark - IBAction

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addFriendBtnClicked:(UIButton *)btn {
    [SPUtils showNetworkIndicator] ;
    spUser *toUser = [_dataSourceOfSearchedUser objectAtIndex:[btn tag]] ;
    
    [SPCloudSevice tryCreateAddRequestWithToUser:toUser callback:^(id object, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        if (error.code == 3840) {
            [SPUtils alert:@"云代码问题！"] ;
            return ;
        }
        NSString *Info ;
        if (error == nil ) {
            Info = @"请求成功" ;
        } else {
            Info = [error localizedDescription] ;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:Info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
        [alert show] ;
    }] ;
}

@end

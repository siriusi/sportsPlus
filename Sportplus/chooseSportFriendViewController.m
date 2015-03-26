//
//  chooseSportFriendViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "chooseSportFriendViewController.h"
#import "chooseFriendTableViewCell.h"

#import "spCommon.h"
#import "SPCacheService.h"

@interface chooseSportFriendViewController () {
    NSMutableArray *_choosedState ;
    NSMutableArray *_dataSourceOfFriendList ;//朋友列表
    NSMutableArray *_dataSourceOfDisplayFriendList ;//要显示的朋友列表 ;
    NSMutableArray *_choosedStateOfDisplayFriendList ;//要显示的选中状态 ;
    
    UIRefreshControl *_refreshControl ;
}

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation chooseSportFriendViewController

#pragma mark - Life Cycle

- (void)refresh:(UIRefreshControl *)refreshControl {
    BOOL networkOnly ;
    if (refreshControl == nil) networkOnly = NO ;
        else networkOnly = YES ;
    NSLog(@"开始刷新朋友列表") ;
    
    [SPUtils showNetworkIndicator] ;
    [SPUserService findFriendsIsNetworkOnly:networkOnly callback:^(NSArray *objects, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SPUtils stopRefreshControl:refreshControl] ;
        
        CDBlock callback = ^ {
            _dataSourceOfFriendList = [objects mutableCopy] ;
            [SPCacheService registerUsers:_dataSourceOfFriendList] ;
            [SPCacheService setFriends:_dataSourceOfFriendList] ;
            [self.tableView reloadData] ;
        } ;
        
        if (error && (error.code == kAVErrorCacheMiss || error.code == 1)) {
            objects = [NSMutableArray array] ;
            callback() ;
        } else {
            [SPUtils filterError:error callback:callback] ;
        }
        
    }] ;
    
    
}

- (void)initTableView {
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init] ;
        [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged] ;
        
        _refreshControl = refreshControl ;
        [self.tableView addSubview:_refreshControl] ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView] ;
    
    self.searchTextField.returnKeyType = UIReturnKeySearch ;
    self.searchTextField.clearsOnBeginEditing = YES ;
    
    [self refresh:nil] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTextField resignFirstResponder] ;
    [self searchFriendWithName:textField.text] ;
    return YES ;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchTextField resignFirstResponder];
    [self searchFriendWithName:self.searchTextField.text] ;
}

#pragma mark - IBAction

- (void)searchFriendWithName:(NSString *)name {
    NSLog(@"search name = %@",name) ;
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    NSLog(@"确定") ;
    [self.navigationController popViewControllerAnimated:YES] ;
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

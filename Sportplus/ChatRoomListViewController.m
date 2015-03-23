//
//  ChatRoomListViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChatRoomListViewController.h"
#import "spCommon.h"
#import "spMessageTableViewController.h"

#import "spUser.h"
#import "spChatroom.h"
#import "spChatGroup.h"

#import "SPUserService.h"
#import "SVProgressHUD.h"

#import "SPSessionManager.h"
#import "SPDataBaseService.h"

@interface ChatRoomListViewController () {
    spUser *_testUser ;
    
    SPSessionManager *sessionManager ;
    UIRefreshControl *_refreshControl ;
    
}

@property (nonatomic) NSMutableArray *dataSourceOfChatRooms ;

@end

@implementation ChatRoomListViewController

- (void)registeNotification {
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_MESSAGE_UPDATED object:nil] ;
    [sp_notificationCenter addObserver:self selector:@selector(refresh) name:NOTIFICATION_MESSAGE_UPDATED object:nil] ;
}

- (void)dealloc {
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_MESSAGE_UPDATED object:nil] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        //tableview init
        self.tableView.dataSource = self ;
        self.tableView.delegate = self ;
        
        _refreshControl = [[UIRefreshControl alloc] init] ;
        [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged] ;
        [self.tableView addSubview:_refreshControl] ;
    }
    _dataSourceOfChatRooms = [[NSMutableArray alloc] init] ;
    
    sessionManager = [SPSessionManager sharedInstance] ;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self refresh:_refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Notification

- (void)refresh {
    [self refresh:nil] ;
}

#pragma mark - IBAction

- (void)refresh:(UIRefreshControl *)refreshView {
    [SPUtils showNetworkIndicator] ;
    
    [SPDataBaseService findConversationsWithCallback:^(NSArray *objects, NSError *error) {
        //objects 是 chatRoom数组
        if ( refreshView != nil ) {
            [SPUtils stopRefreshControl:refreshView] ;
        }
        [SPUtils hideNetworkIndicator] ;
        [SPUtils filterError:error callback:^{
            _dataSourceOfChatRooms = [objects mutableCopy] ;
            [self.tableView reloadData] ;
            
            int totalUnreadCount=0;
            for(spChatroom* room in _dataSourceOfChatRooms){
                totalUnreadCount+=room.unreadCount;
            }
            
            if(totalUnreadCount>0){
                self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",totalUnreadCount];
            }else{
                self.tabBarItem.badgeValue=nil;
            }
        }] ;
    }] ;
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSourceOfChatRooms count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ChatRoomListTableViewCellID" ;
    ChatRoomListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatRoomListTableViewCell" owner:self options:nil] lastObject];
    }
    
    /*config cell*/{
        cell.delegate = self ;
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(247, 45 , 64) title:@"解散"] ;
        cell.leftUtilityButtons = leftUtilityButtons ;
        [cell setRightUtilityButtons:rightUtilityButtons WithButtonWidth:65] ;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row) ;
    static NSString *segueID = @"chatRoomList2chatRoom" ;
    
    spChatroom *chatRoom = [_dataSourceOfChatRooms objectAtIndex:indexPath.row] ;
    _testUser = (spUser *)chatRoom.chatUser ;

    if ( _testUser ) {
        [self performSegueWithIdentifier:segueID sender:self] ;
        return ;
    };
    
//    [SPUtils showNetworkIndicator] ;
//    [SPUserService findUsersByIds:@[@"5500766be4b00aa930032fd0"] callback:^(NSArray *objects, NSError *error) {
//        [SPUtils hideNetworkIndicator] ;
//        
//        _testUser = [objects lastObject] ;
//        [self performSegueWithIdentifier:segueID sender:self] ;
//    }] ;
    
//    [self performSegueWithIdentifier:segueID sender:self] ;
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index) ;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ( [segue.identifier isEqualToString: @"chatRoomList2chatRoom"] ) {
        spMessageTableViewController *Vc = (spMessageTableViewController *)segue.destinationViewController ;
        Vc.chatUser = _testUser ;
    }
}


@end

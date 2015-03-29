//
//  InviteFriendViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/3.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "spCommon.h"

#import "ChooseSportItemTableViewCell.h"
#import "ChoosePlaceTableViewCell.h"
#import "ChooseSportTimeTableViewCell.h"
#import "ChooseSportFriendTableViewCell.h"

#import "SPInviteService.h"

@interface InviteFriendViewController () {
    
    NSString *_choosedSportName ;
    SPORTSTYPE _chooseSportType ;
    NSArray *_choosedFriendList ;
    
    NSDate *_choosedDate ;
}

@end

//
//typedef enum {
//    SPORTSTYPE_pingpong = 1 ,
//    SPORTSTYPE_tennise ,
//    SPORTSTYPE_soccer ,
//    SPORTSTYPE_run ,
//    SPORTSTYPE_build ,
//    SPORTSTYPE_basketball ,
//    SPORTSTYPE_badminton
//} SPORTSTYPE ;

@implementation InviteFriendViewController

- (void)registeNotificationCenter {
    NSLog(@"注册观察者") ;
    
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_SPORTS_CHOOSED object:nil] ;
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_STADIUM_CHOOSED object:nil] ;
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_TIME_CHOOSED object:nil] ;
    [sp_notificationCenter removeObserver:self name:NOTIFICATION_FRIENDS_CHOOSED object:nil] ;
    
    [sp_notificationCenter addObserver:self selector:@selector(phraseData:) name:NOTIFICATION_SPORTS_CHOOSED object:nil] ;
    [sp_notificationCenter addObserver:self selector:@selector(phraseData:) name:NOTIFICATION_STADIUM_CHOOSED object:nil] ;
    [sp_notificationCenter addObserver:self selector:@selector(phraseDateData:) name:NOTIFICATION_TIME_CHOOSED object:nil] ;
    [sp_notificationCenter addObserver:self selector:@selector(phraseFriendsData:) name:NOTIFICATION_FRIENDS_CHOOSED object:nil] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    _chooseSportType = 0 ;
    _choosedSportName = @"" ;
    
    _choosedDate = nil ;
    
    [self registeNotificationCenter] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    NSLog(@"注销 <%@> 观察者",SP_INVITE_UPDATE) ;
    [sp_notificationCenter removeObserver:self name:SP_INVITE_UPDATE object:nil] ;
}

#pragma mark - NSNotification

- (void)phraseData:(NSNotification *)sender {
    
    NSLog(@"data = %@",[sender object]) ;
    _chooseSportType = (SPORTSTYPE)[(NSNumber *)[((NSArray *)[sender object]) firstObject] integerValue] ;
    
    [self.tableView reloadData] ;
    
}

- (void)phraseDateData:(NSNotification *)sender {
    NSLog(@"date = %@",[sender object]) ;
    _choosedDate = [sender object] ;
    [self.tableView reloadData] ;
}

- (void)phraseFriendsData:(NSNotification *)sender {
    NSLog(@"user = %@",[sender object]) ;
    _choosedFriendList = [sender object] ;
    
    [self.tableView reloadData] ;
}

#pragma mark-UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID1 = @"ChooseSportItemTBVCellID" ;
    static NSString *cellID2 = @"ChoosePlaceTableViewCellID" ;
    static NSString *cellID3 = @"ChooseSportTimeTableViewCellID" ;
    static NSString *cellID4 = @"ChooseSportFriendTableViewCellID" ;
    
    NSInteger section = indexPath.section ;
    
    UITableViewCell *cell ;
    
    if ( section == 0 ) {
        //sport
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellID1] ;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportItemTableViewCell" owner:self options:nil] lastObject];
        }
        
        [((ChooseSportItemTableViewCell *)cell) initWithSportType:_chooseSportType] ;
        
    } else
    if ( section == 1 ) {
        //stadium
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellID2] ;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePlaceTableViewCell" owner:self options:nil] lastObject];
        }
        
    }else
    if ( section == 2 ) {
        //time
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellID3] ;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportTimeTableViewCell" owner:self options:nil] lastObject];
        }
        [((ChooseSportTimeTableViewCell *)cell) initWithDate:_choosedDate] ;
        
    }else {
        //friends
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellID4] ;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportFriendTableViewCell" owner:self options:nil] lastObject];
        }
        
        [(ChooseSportFriendTableViewCell *)cell initWithUserArray:_choosedFriendList] ;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    
    return cell ;
}

#pragma mark-UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35 ;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"选择项目";
    }
    
    if (section == 1) {
        return @"选择场所";
    }
    
    if (section == 2) {
        return @"选择时间";
    }
    
    return @"选择好友" ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *segueID1 = @"FriendVC2SportSegueID" ;
    static NSString *segueID2 = @"FriendVC2PlaceSegueID" ;
    static NSString *segueID3 = @"FriendVC2TimeSegueID" ;
    static NSString *segueID4 = @"FriendVC2FriendSegueID" ;
    
    NSArray *segueIDs = @[segueID1,segueID2,segueID3,segueID4] ;
    
    
    [self performSegueWithIdentifier:[segueIDs objectAtIndex:indexPath.section] sender:self] ;
}

#pragma mark-IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController setNavigationBarHidden:YES] ;
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    NSLog(@"确定") ;
}

@end
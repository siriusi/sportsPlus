//
//  InviteStrangerViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "InviteStrangerViewController.h"
#import "spCommon.h"
#import "ChooseSportItemTableViewCell.h"

#import "SPInviteService.h"
#import "SVProgressHUD.h"

#define FRIENDLY_NORMAL_ICON @"FriendlyIconNormal"
#define FRIENDLY_SELECTED_ICON @"FriendlyIconSelected"
#define COMPETITION_NORMAL_ICON @"CompetitionIconNoraml"
#define COMPETITION_SELECTED_ICON @"CompetitionIconSelected"

#define IMAGE(name) [UIImage imageNamed:name]

typedef enum {
    NONE_SELECTED = 0 , //没有选择
    COMPETITION_SELECTED = 1 , //实力型
    FRIENDLY_SELECTED = 2 , //交友型
} BtnState;

@interface InviteStrangerViewController () {
    BtnState state ;
    
    NSArray *_typeToSportName ;
    NSString *_choosedSportName ;
    SPORTSTYPE _chooseSportType ;
}

@end

@implementation InviteStrangerViewController

- (void)setState:(BtnState)st {
    state = st ;
    if (state == NONE_SELECTED) {
        [self.CompetitionButton setImage:IMAGE(COMPETITION_NORMAL_ICON) forState:UIControlStateNormal] ;
        [self.FriendlyButton setImage:IMAGE(FRIENDLY_NORMAL_ICON) forState:UIControlStateNormal] ;
    }
    
    if (state == COMPETITION_SELECTED ) {
        [self.CompetitionButton setImage:IMAGE(COMPETITION_SELECTED_ICON) forState:UIControlStateNormal] ;
        [self.FriendlyButton setImage:IMAGE(FRIENDLY_NORMAL_ICON) forState:UIControlStateNormal] ;
    }
    
    if (state == FRIENDLY_SELECTED) {
        [self.CompetitionButton setImage:IMAGE(COMPETITION_NORMAL_ICON) forState:UIControlStateNormal] ;
        [self.FriendlyButton setImage:IMAGE(FRIENDLY_SELECTED_ICON) forState:UIControlStateNormal] ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setState:NONE_SELECTED] ;
    
    [self registeNotificationCenter] ;
    
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    _typeToSportName = @[@"",@"乒乓球",@"网球",@"足球",@"跑步",@"健身",@"篮球",@"羽毛球"] ;
    
    _chooseSportType = -1 ;
    _choosedSportName = @"" ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - NSNotification

- (void)registeNotificationCenter {
    NSLog(@"注册 <%@> 观察者",SP_INVITE_UPDATE) ;
    
    [sp_notificationCenter removeObserver:self name:SP_INVITE_UPDATE object:nil] ;
    [sp_notificationCenter addObserver:self selector:@selector(phraseData:) name:SP_INVITE_UPDATE object:nil] ;
}

- (void)phraseData:(NSNotification *)sender {
    NSLog(@"data = %@",[sender object]) ;
    
    NSInteger index = [(NSNumber *)[((NSArray *)[sender object]) firstObject] integerValue]  ;
    _chooseSportType = (SPORTSTYPE)index;
    _choosedSportName = [_typeToSportName objectAtIndex:index] ;
    [self.tableView reloadData] ;
}

#pragma mark-UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ChooseSportItemTBVCellID" ;
    ChooseSportItemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportItemTableViewCell" owner:self options:nil] lastObject];
    }
    
    [((ChooseSportItemTableViewCell *)cell).SportsNameLabel setText:_choosedSportName] ;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;//箭头 ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"createStrangerTochooseSportVCSegueID" sender:self] ;
}

#pragma mark-IBAction

- (IBAction)CompetitionBtnClicked:(id)sender {
    [self setState:COMPETITION_SELECTED] ;
}

- (IBAction)FriendlyBtnClicked:(id)sender {
    [self setState:FRIENDLY_SELECTED] ;
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController setNavigationBarHidden:YES] ;
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    //getStranger ;
    [self tryGetStrangerFromService] ;
}

#pragma mark - Network Method 

- (void)tryGetStrangerFromService{
    static NSString *segueId = @"createStrangerTo233SegueID" ;
    
    spUser *user = [spUser currentUser] ;
    
    NSString *fromId = [user objectId] ;
    NSString *sex = [user sP_sex] ;
    EngagementType type = state == FRIENDLY_SELECTED ? EngagementTypeFriendly: EngagementTypeStrength ;
    SPORTSTYPE sportType = _chooseSportType ;
    NSInteger count = 5 ;
    
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    [SPInviteService getStrangersWithfromId:fromId sex:sex engagementType:type sportType:sportType count:count WithBlock:^(NSArray *objects, NSError *error) {
        [SVProgressHUD dismiss] ;
        [SPUtils hideNetworkIndicator] ;
        if (error) {
            NSLog(@"error = %@",[error localizedDescription]) ;
            [SPUtils alertError:error] ;
        } else {
            NSLog(@"objects = %@",objects) ;
            [self performSegueWithIdentifier:segueId sender:self] ;
        }
    }] ;
#warning test
    [self performSegueWithIdentifier:segueId sender:self] ;
    
}


@end

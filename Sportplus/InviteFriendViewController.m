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
#import "chooseFriendTableViewCell.h"

@interface InviteFriendViewController ()

@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportItemTableViewCell" owner:self options:nil] lastObject];
    
    } else
    if ( section == 1 ) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePlaceTableViewCell" owner:self options:nil] lastObject];
            
    }else
    if ( section == 2 ) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportTimeTableViewCell" owner:self options:nil] lastObject];
        
    }else {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSportFriendTableViewCell" owner:self options:nil] lastObject];
        
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
    NSInteger section = indexPath.section ;
    
    static NSString *segueID1 = @"FriendVC2SportSegueID" ;
    static NSString *segueID2 = @"FriendVC2PlaceSegueID" ;
    static NSString *segueID3 = @"FriendVC2TimeSegueID" ;
    static NSString *segueID4 = @"FriendVC2FriendSegueID" ;
    
    NSArray *segueIDs = @[segueID1,segueID2,segueID3,segueID4] ;
    
    
    [self performSegueWithIdentifier:[segueIDs objectAtIndex:indexPath.section] sender:self] ;
//    if ( section == 0 ) {
//        [self performSegueWithIdentifier:segueID1 sender:self] ;
//    } else
//    if ( section == 1) {
//    
//    } else
//    if ( section == 2 ) {
//    } else {
//        
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark-IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController setNavigationBarHidden:YES] ;
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    NSLog(@"确定") ;
}

@end

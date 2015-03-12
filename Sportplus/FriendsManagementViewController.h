//
//  FriendsManagementViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/20.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsManagementViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFriendsButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UICollectionView *sportsCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;

@property (nonatomic) NSMutableArray *sportsArray;
@property (nonatomic) NSMutableArray *clickArray;
@property (nonatomic) NSMutableArray *sportsArrayWhite;

@property (nonatomic) NSIndexPath *oldCellRow;

- (NSMutableArray *)dataSourceOfFriend ;
- (void)setdataSourceOfFriend:(NSMutableArray *)data ;

@end

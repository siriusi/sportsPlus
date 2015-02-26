//
//  FriendInviteManageViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendInviteManageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *checkSendedInviteBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkReceivedInviteBtn;
@property (weak, nonatomic) IBOutlet UIView *LeftBtnHignLightLine;
@property (weak, nonatomic) IBOutlet UIView *RightBtnHighLightLine;


@end

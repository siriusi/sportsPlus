//
//  StrangerInviteManageViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/28.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteInfoTableViewCell.h"

@interface StrangerInviteManageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *checkSendedInviteBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkReceivedInviteBtn;
@property (weak, nonatomic) IBOutlet UIView *LeftBtnHignLightLine;
@property (weak, nonatomic) IBOutlet UIView *RightBtnHighLightLine;



@end

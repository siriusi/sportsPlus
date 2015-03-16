//
//  sendMyInviteStrangerInfoViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/15.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "spCommon.h"

@interface sendMyInviteStrangerInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic) spEngagement_Stranger *currentEngagement ;

@end

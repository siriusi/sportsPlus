//
//  spNotificationCenterViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/25.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface spNotificationCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

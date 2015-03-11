//
//  spMessageTableViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "XHMessageTableViewController.h"
#import "InviteInfoTableViewCell.h"

@interface spMessageTableViewController : XHMessageTableViewController<XHMessageTableViewControllerDataSource,XHMessageTableViewControllerDelegate,SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void)getMessage ;

@end

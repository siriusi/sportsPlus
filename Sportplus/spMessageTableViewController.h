//
//  spMessageTableViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "XHMessageTableViewController.h"
#import "InviteInfoTableViewCell.h"

#import "spMsg.h"
#import "spAVModels.h"

#define ONE_PAGE_SIZE 20

@interface spMessageTableViewController : XHMessageTableViewController<XHMessageTableViewControllerDataSource,XHMessageTableViewControllerDelegate,SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) spEngagement_Stranger *currentEngageMent ;
@property (nonatomic, strong) spUser *chatUser;
@property (nonatomic) CDMsgRoomType type;
@property (nonatomic,strong) spChatGroup* chatGroup;

@property (nonatomic, strong) AVGroup *group;

@end

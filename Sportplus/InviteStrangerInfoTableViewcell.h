//
//  InviteStrangerInfoTableViewcell.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/15.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <SWTableViewCell/SWTableViewCell.h>

#import "spEngagement_Stranger.h"

@interface InviteStrangerInfoTableViewcell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sportItem;
@property (weak, nonatomic) IBOutlet UILabel *academyLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *userInfoLabel;

- (void)initWithEngagementStranger:(spEngagement_Stranger *)engagement ;

@end

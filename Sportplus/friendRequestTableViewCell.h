//
//  friendRequestTableViewCell.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    cellStateWait = 0 ,
    cellStateAccept ,
} cellState;

@interface friendRequestTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *academyAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptFriendRequestButton;

@property cellState MycellState;

@end

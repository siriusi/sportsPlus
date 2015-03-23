//
//  ChooseSportItemTableViewCell.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/8.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "spCommon.h"

@interface ChooseSportItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *SportsIMGView;
@property (weak, nonatomic) IBOutlet UILabel *SportsNameLabel;

- (void)initWithSportType:(SPORTSTYPE)type ;

@end

//
//  ChooseSportItemTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/8.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChooseSportItemTableViewCell.h"
#import "SPsportTypeUtils.h"

@implementation ChooseSportItemTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)initWithSportType:(SPORTSTYPE)type {
    [self.SportsNameLabel setText:[SPsportTypeUtils getSPortNameBySportType:type]] ;
    [self.SportsIMGView setImage:[SPsportTypeUtils getSportImgAtFriendCellWithSportType:type]] ;
}

@end

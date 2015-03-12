//
//  spNotificationCenterTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/25.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spNotificationCenterTableViewCell.h"

@implementation spNotificationCenterTableViewCell

#pragma mark - Init methods

- (void)configureSelf
{
    // Initialization code
//    __badge = [[TDBadgeView alloc] initWithFrame:CGRectZero];
//    self.badge.parent = self;
    
//    [self.contentView addSubview:self.badge];
//    [self.badge setNeedsDisplay];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super initWithCoder:decoder]))
    {
        [self configureSelf];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        [self configureSelf];
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

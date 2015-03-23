//
//  systemInfoTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/24.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "systemInfoTableViewCell.h"

@implementation systemInfoTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - Init Method

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup] ;
    }
    return self;
}

- (instancetype)initWithInfo:(NSString *)info reuserIdentifier:(NSString *)cellIdentifier{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (self) {
        //code ;
        LKBadgeView *InfoLabel = [[LKBadgeView alloc] initWithFrame:CGRectMake(0.0f, 5.0f, 280, 20.0f)] ;
        InfoLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin ;
        InfoLabel.badgeColor = [UIColor colorWithWhite:0.000 alpha:0.380] ;
        InfoLabel.textColor = [UIColor whiteColor] ;
        InfoLabel.font = [UIFont systemFontOfSize:13.0f] ;
        InfoLabel.center = CGPointMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) / 2.0, InfoLabel.center.y) ;
        
        [self.contentView addSubview:InfoLabel] ;
        [self.contentView bringSubviewToFront:InfoLabel] ;
        _systemInfoLabel = InfoLabel ;
    }

    return self ;
}

- (void)configureCellWithInfo:(NSString *)info {
    _systemInfoLabel.text = info ;
}

+ (CGFloat)calculateCellHeightWithInfo:(NSString *)info {
    CGFloat systemHeight = 20.0f + ( 5.0f * 2 );
    return systemHeight ;
}

@end

//
//  friendRequestTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "friendRequestTableViewCell.h"

@implementation friendRequestTableViewCell

- (void)awakeFromNib {
    self.MycellState = cellStateWait ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)acceptBtnClicked:(id)sender {
    NSLog(@"acceptBtnClicked") ;
}

@end

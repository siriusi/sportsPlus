//
//  chooseFriendTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "chooseFriendTableViewCell.h"

#define ImageNormal [UIImage imageNamed:@"chooseFriendBtnNormal"]
#define ImageSelected [UIImage imageNamed:@"chooseFriendBtnSelected"]

typedef enum {
    NORMAL = 0 ,
    SELECTED ,
} MyBtnState;

@implementation chooseFriendTableViewCell {
    MyBtnState state ;
}

- (void)awakeFromNib {
    state = NORMAL ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnClicked:(id)sender {
    if (state == NORMAL) {
        state = SELECTED ;
        [self.selectedBtn setImage:ImageSelected forState:UIControlStateNormal] ;
    } else {
        state = NORMAL ;
        [self.selectedBtn setImage:ImageNormal forState:UIControlStateNormal] ;
    }
}
@end

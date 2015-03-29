//
//  chooseFriendTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "chooseFriendTableViewCell.h"

#import "SPUserService.h"

#define ImageNormal [UIImage imageNamed:@"chooseFriendBtnNormal"]
#define ImageSelected [UIImage imageNamed:@"chooseFriendBtnSelected"]

typedef enum {
    NORMAL = 0 ,
    SELECTED ,
} MyBtnState;

@implementation chooseFriendTableViewCell {
    MyBtnState _state ;
}

- (void)awakeFromNib {
    _state = NORMAL ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setState:(MyBtnState)state {
    _state = state ;
    
    if (_state == SELECTED) {
        [self.selectedBtn setImage:ImageSelected forState:UIControlStateNormal] ;
    } else {
        [self.selectedBtn setImage:ImageNormal forState:UIControlStateNormal] ;
    }
}

- (IBAction)btnClicked:(id)sender {
    if (_state == NORMAL) {
        [self setState:SELECTED] ;
    } else {
        [self setState:NORMAL] ;
    }
}

- (void)initWithSpUser:(spUser *)user andState:(BOOL)selected {
    [self initWithSpUser:user] ;
    if (selected) {
        [self setState:SELECTED] ;
    } else {
        [self setState:NORMAL] ;
    }
}

- (void)initWithSpUser:(spUser *)user {
    //name
    self.nameLabel.text = [user sP_userName] ;
    //academy + enterYear
    NSString *academy = [user sP_academy] ;
    NSString *enterYear = [[[user sP_enterScYear] stringValue] stringByAppendingString:@"级"] ;
    
    self.academyLabel.text = [academy stringByAppendingString:enterYear];
    //avatar Img 
    [SPUserService displayAvatarOfUser:user avatarView:self.avatarImageView] ;
    
}

@end

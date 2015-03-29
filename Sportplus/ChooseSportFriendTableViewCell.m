//
//  ChooseSportFriendTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChooseSportFriendTableViewCell.h"

#import "spUser.h"

@implementation ChooseSportFriendTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)initWithUserArray:(NSArray *)userArray {
    NSMutableString *nameString = [NSMutableString string];
    
    for (spUser *user in userArray) {
        [nameString appendString:[user sP_userName]] ;
    }
    
    self.friendNameLabel.text = nameString ;
    
}

@end

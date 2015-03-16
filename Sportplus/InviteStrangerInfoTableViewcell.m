//
//  InviteStrangerInfoTableViewcell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/15.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "InviteStrangerInfoTableViewcell.h"

#import "spEngagement_Stranger.h"
#import "spUser.h"

@implementation InviteStrangerInfoTableViewcell

- (void)configSelf {
}

- (void)awakeFromNib {
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder] ;
    if (self) {
        [self configSelf] ;
    }
    return self ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)initWithEngagementStranger:(spEngagement_Stranger *)engagement {
    spUser *user = [engagement fromId] ;
    
    self.nameLabel.text = [user sP_userName] ;
//    [engagement sportType]
    self.academyLabel.text = [user sP_academy] ;
    self.schoolLabel.text = [user sP_school] ;
    self.userInfoLabel.text = [user toInfoLabelStringOfEnterSchoolJobAndSex] ;
    
}

@end

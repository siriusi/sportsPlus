//
//  ChatRoomListTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChatRoomListTableViewCell.h"

//#define createTimeString(time) [NSString stringWithFormat:@"今天 12:30建立"] ;

@implementation ChatRoomListTableViewCell

#pragma mark -init method

- (void)configSelf {
    NSLog(@"2.configSelf") ;
}

- (void)awakeFromNib {
    NSLog(@"3.awakeFromNib") ;
    [self.nameLabel setText:@"张睿"] ;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"1.init with coder") ;
    self = [super initWithCoder:aDecoder] ;
    if (self) {
        [self configSelf] ;
    }
    return self ;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    NSLog(@"init with style") ;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if ( self ) {
        [self configSelf] ;
    }
    return self ;
}

#pragma mark - other Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

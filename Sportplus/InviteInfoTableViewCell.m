//
//  InviteInfoTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/27.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "InviteInfoTableViewCell.h"

@implementation InviteInfoTableViewCell

#pragma mark -init method

- (void)configSelf {
}

- (void)awakeFromNib {
//    [self.nameLabel setText:@"张睿"] ;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

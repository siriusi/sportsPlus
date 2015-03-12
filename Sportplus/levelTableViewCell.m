//
//  levelTableViewCell.m
//  Sportplus
//
//  Created by Forever.H on 14/12/7.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "levelTableViewCell.h"

@implementation levelTableViewCell

- (void)awakeFromNib {
    [self.level1 addTarget:self action:@selector(levelOne:) forControlEvents:UIControlEventTouchUpInside];
    [self.level2 addTarget:self action:@selector(levelTwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.level3 addTarget:self action:@selector(levelThree:) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)levelOne:(UIButton *)sender{
    [self.level1 setImage:[UIImage imageNamed:@"levelOneSelected"] forState:UIControlStateNormal];
    [self.level2 setImage:[UIImage imageNamed:@"levelTwo"] forState:UIControlStateNormal];
    [self.level3 setImage:[UIImage imageNamed:@"levelThree"] forState:UIControlStateNormal];
    self.level = 1;    
}

-(void)levelTwo:(UIButton *)sender{
    [self.level1 setImage:[UIImage imageNamed:@"levelOne"] forState:UIControlStateNormal];
    [self.level2 setImage:[UIImage imageNamed:@"levelTwoSelected"] forState:UIControlStateNormal];
    [self.level3 setImage:[UIImage imageNamed:@"levelThree"] forState:UIControlStateNormal];
    self.level = 2;
}

-(void)levelThree:(UIButton *)sender{
    [self.level1 setImage:[UIImage imageNamed:@"levelOne"] forState:UIControlStateNormal];
    [self.level2 setImage:[UIImage imageNamed:@"levelTwo"] forState:UIControlStateNormal];
    [self.level3 setImage:[UIImage imageNamed:@"levelThreeSelected"] forState:UIControlStateNormal];
    self.level = 3;
}

@end

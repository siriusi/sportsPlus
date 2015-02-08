//
//  levelTableViewCell.h
//  Sportplus
//
//  Created by Forever.H on 14/12/7.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface levelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sportImg;
@property (weak, nonatomic) IBOutlet UIButton *level1;
@property (weak, nonatomic) IBOutlet UIButton *level2;
@property (weak, nonatomic) IBOutlet UIButton *level3;
@property (nonatomic) int level;

@end

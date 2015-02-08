//
//  TagTableViewCell.h
//  Sportplus
//
//  Created by Forever.H on 14/12/7.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mengMZ;
@property (weak, nonatomic) IBOutlet UIButton *yuJ;
@property (weak, nonatomic) IBOutlet UIButton *nvHZ;
@property (weak, nonatomic) IBOutlet UIButton *gaoFS;
@property (weak, nonatomic) IBOutlet UIButton *nuanN;
@property (weak, nonatomic) IBOutlet UIButton *zhengT;
@property (weak, nonatomic) IBOutlet UIButton *jiaoYK;
@property (weak, nonatomic) IBOutlet UIButton *yunDZ;
@property (weak, nonatomic) IBOutlet UIButton *daSK;



@property (nonatomic) NSMutableArray *tagArray;
@end

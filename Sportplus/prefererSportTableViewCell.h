//
//  prefererSportTableViewCell.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/10.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface prefererSportTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sportIconBGDImgView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImgView;


@property (weak, nonatomic) IBOutlet UIButton *lv1Btn;
@property (weak, nonatomic) IBOutlet UIButton *lv2Btn;
@property (weak, nonatomic) IBOutlet UIButton *lv3Btn;

- (void)initWithsportLevle:(NSInteger)lv sportType:(NSInteger)type ;

@end

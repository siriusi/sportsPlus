//
//  prefererSportTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/10.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "prefererSportTableViewCell.h"

#import "SPsportTypeUtils.h"

@implementation prefererSportTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)initWithsportLevle:(NSInteger)lv sportType:(SPORTSTYPE)type {
    
    [self.sportIconImgView setImage:[SPsportTypeUtils getSportImgAtMainPageWithSportType:type Selected:FALSE]] ;
    
    
    NSArray *btnArray = @[_lv1Btn,_lv2Btn,_lv3Btn] ;
    
    for (NSInteger i = 0; i < [btnArray count]; i++) {
        [btnArray[i] setImage:[SPsportTypeUtils getSportLvImageWithSportlevel:(i + 1) Selected:NO] forState:UIControlStateNormal] ;
    }
    
    [btnArray[lv - 1] setImage:[SPsportTypeUtils getSportLvImageWithSportlevel:lv Selected:TRUE] forState:UIControlStateNormal] ;
    
}

@end

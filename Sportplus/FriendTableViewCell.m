//
//  FriendTableViewCell.m
//  Sportplus
//
//  Created by Forever.H on 14/12/20.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "spCommon.h"

#import "SPsportTypeUtils.h"

#warning 未测试修改
//
//@interface getSportImgUtils : NSObject
//
//+ (UIImage *)getImageWithSportType:(SPORTSTYPE)type ;
//
//@end
//
//@implementation getSportImgUtils
//
//+ (UIImage *)getImageWithSportType:(SPORTSTYPE)type {
//    NSArray *sportImgNameList = @[@"",@"乒乓球",@"网球",@"足球",@"跑步",@"健身",@"篮球",@"羽毛球"] ;
//    return [UIImage imageNamed:sportImgNameList[type]] ;
//}
//
//@end


@implementation FriendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSportImgsWithSportsTypeArray:(NSArray *)sportsTypeArray {
    NSArray *imgViews = @[_img1,_img2,_img3,_img4,_img5,_img6,_img7] ;
    
    for(NSInteger i=0;i<sportsTypeArray.count;i++){
        
        UIImage *img = [SPsportTypeUtils getSportImgAtFriendCellWithSportType:(SPORTSTYPE)[sportsTypeArray[i] integerValue]] ;
        [((UIImageView *)imgViews[i]) setImage:img];
        [((UIImageView *)imgViews[i]) setHidden:NO];
        
        //type --> name --> imageName ;
    }
    
    for(NSInteger i=[sportsTypeArray count];i<imgViews.count;i++){
        [((UIImageView *)imgViews[i]) setHidden:YES];
    }
}

@end

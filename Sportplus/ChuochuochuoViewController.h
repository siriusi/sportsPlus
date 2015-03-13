//
//  ChuochuochuoViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChuochuochuoViewController : UIViewController

#warning 滑动换图片不会。。
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;
@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;

- (void)receiveUsers:(NSArray *)userIds ;

@end

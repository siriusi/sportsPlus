//
//  MainTabBarController.h
//  Sportplus
//
//  Created by humao on 14-12-20.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController<UITabBarDelegate> {
}

- (id)initWithTabBarBackgroundImage:(UIImage *)barBackgroundImage unSelectedImageArray:(NSMutableArray *)unImageArray selectedImageArray:(NSMutableArray *)imageArray;

//隐藏某个tabBarItem的图片
-(void)hiddeItemImageView:(int)index;

//显示某个tabBarItem的图片
-(void)showItemImageView:(int)index;

@end

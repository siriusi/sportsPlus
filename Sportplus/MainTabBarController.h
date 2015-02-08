//
//  MainTabBarController.h
//  Sportplus
//
//  Created by humao on 14-12-20.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController {
    NSMutableArray *_buttons ;
    NSInteger _currentSelectedIndex ;
    UIImageView *slideBg ;
}

@property (nonatomic , assign) NSInteger currentSelectedIndex ;
@property (nonatomic , retain) NSMutableArray *buttons ;

- (void)hideRealTabBar ;
- (void)customTabBar ;
- (void)selectedTab:(UIButton *)button ;

@end

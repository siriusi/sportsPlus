//
//  MainTabBarController.m
//  Sportplus
//
//  Created by humao on 14-12-20.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    slideBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTabBarBackground"]] ;
    [self hideRealTabBar] ;
    [self customTabBar] ;
}

- (void)hideRealTabBar{
    for (UIView *view in self.view.subviews){
        if ([view isKindOfClass:[UITabBar class]]) {
            view.hidden = YES ;
            break ;
        }
    }
}

- (void)customTabBar{
#warning 图片
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] ;
#warning 注意适配其他的屏幕。
    imgView.frame = CGRectMake(0, 425, imgView.image.size.width, imgView.image.size.height) ;
    [self.view addSubview:imgView] ;
    slideBg.frame = CGRectMake(-30,self.tabBar.frame.origin.y, slideBg.image.size.width, slideBg.image.size.height) ;
    
    //创建button
    NSInteger viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count ;
    self.buttons = [NSMutableArray arrayWithCapacity:viewCount] ;
    double _width = 320 / viewCount ;
    double _height = self.tabBar.frame.size.height ;
    for (int i = 0 ; i < viewCount ; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        btn.frame = CGRectMake(i*_width, self.tabBar.frame.origin.y, _width, _height) ;
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag = i ;
        [self.buttons addObject:btn] ;
        [self.view addSubview:btn] ;
        btn = nil ;
    }
    [self.view addSubview:slideBg] ;
#warning 图片
    UIImageView *imgFront = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] ;
    imgFront.frame = imgView.frame ;
    [self.view addSubview:imgFront] ;
    imgFront = nil ;
    imgView = nil ;
    [self selectedTab:[self.buttons objectAtIndex:0]] ;
}

- (void)selectedTab:(UIButton *)button{
    if (self.currentSelectedIndex == button.tag){
    }
    self.currentSelectedIndex = button.tag ;
    self.selectedIndex = self.currentSelectedIndex ;
    [self performSelectorInBackground:@selector(slideTabBg:) withObject:button] ;
}

- (void)slideTabBg:(UIButton *)btn{
    [UIView beginAnimations:nil context:nil] ;
    [UIView setAnimationDuration:0.20] ;
    [UIView setAnimationDelegate:self] ;
    slideBg.frame = CGRectMake(btn.frame.origin.x -30, btn.frame.origin.y, slideBg.image.size.width , slideBg.image.size.height) ;
    [UIView commitAnimations] ;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

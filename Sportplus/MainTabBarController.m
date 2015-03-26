//
//  MainTabBarController.m
//  Sportplus
//
//  Created by humao on 14-12-20.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "MainTabBarController.h"

#define TabBarBackgroundImageViewTag 11111

@interface MainTabBarController () {
    UIImage *_tabBarBackgroundImage ;//整个tabBar的背景
    NSMutableArray *_unSelectedImageArray ;//非选中效果的tabBarItem数组
    NSMutableArray *_selectedImageArray ;//选中效果的tabBarItem数组
    NSMutableArray *_itemBgImageViewArray ;//item背景UIImageView数组
    NSInteger _lastSelectedIndex ;//上一次选中的tabBarItem的index
    NSInteger _hiddenIndex ;
    
}

@property (nonatomic ,retain) UIImage *tabBarBackgroundImage ;
@property (nonatomic ,retain) NSMutableArray *unSelectedImageArray ;
@property (nonatomic ,retain) NSMutableArray *selectedImageArray ;
@property (nonatomic ,retain) NSMutableArray *itemBgImageViewArray ;

@property (nonatomic ,assign) NSInteger lastSelectedIndex ;
@property (nonatomic ,assign) NSInteger hiddenIndex ;

@end

@implementation MainTabBarController


- (void)dealloc{
    self.tabBarBackgroundImage = nil ;
    self.unSelectedImageArray = nil ;
    self.selectedImageArray = nil ;
    self.itemBgImageViewArray = nil ;
}

- (id)initWithTabBarBackgroundImage:(UIImage *)barBackgroundImage unSelectedImageArray:(NSMutableArray *)unImageArray selectedImageArray:(NSMutableArray *)imageArray{
    self = [super init] ;
    
    if (self) {
        self.tabBarBackgroundImage = barBackgroundImage ;
        self.unSelectedImageArray = unImageArray ;
        self.selectedImageArray = imageArray ;
    }
    
    return self ;
}

- (id)init {
    self = [super init] ;
    
    if (self) {
        
    }
    
    return self ;
}

#pragma mark - itemIndex methods

- (void)setLastSelectedIndex:(int)lastSelectedIndex {
    if (_lastSelectedIndex != lastSelectedIndex) {
        //将上次的选中效果取消
        UIImageView *lastSelectedImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:_lastSelectedIndex];;
        lastSelectedImageView.image = [_unSelectedImageArray objectAtIndex:_lastSelectedIndex];
        
        _lastSelectedIndex = lastSelectedIndex;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    //将上次的选中效果取消
    self.lastSelectedIndex = selectedIndex;
    //将本次的选中效果显示
    UIImageView *selectedImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:selectedIndex];
    selectedImageView.image = [_selectedImageArray objectAtIndex:selectedIndex];
    
}

//隐藏某个tabBarItem的图片
- (void)hiddeItemImageView:(int)index {
    if (_hiddenIndex != index) {
        _hiddenIndex = index;
        
        UIImageView *hiddenImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:_hiddenIndex];
        hiddenImageView.hidden = YES;
    }
}

//显示某个tabBarItem的图片
- (void)showItemImageView:(int)index {
    if (_hiddenIndex == index) {
        UIImageView *hiddenImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:_hiddenIndex];
        hiddenImageView.hidden = NO;
        
        _hiddenIndex = -1;
    }
}


#pragma mark - view life cycle

- (void)loadView {
    [super loadView] ;
#warning image
    self.tabBarBackgroundImage = [UIImage imageNamed:@""] ;
    
    NSMutableArray *aunSelectedImageArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"mainPageNormal"],
                                             [UIImage imageNamed:@"InviteNormal"],
                                             [UIImage imageNamed:@"friendManagerNormal"],
                                             [UIImage imageNamed:@"messageManagerNormal"], nil];
    self.unSelectedImageArray = aunSelectedImageArray ;
    aunSelectedImageArray = nil ;
    
    NSMutableArray *aselectedImageArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"mainPageSelected"],
                                           [UIImage imageNamed:@"InviteSelected"],
                                           [UIImage imageNamed:@"friendManagerSelected"],
                                           [UIImage imageNamed:@"messageManagerSelected"],  nil];
    self.selectedImageArray = aselectedImageArray;
    aselectedImageArray = nil ;
    
    self.itemBgImageViewArray = [NSMutableArray array];
    _lastSelectedIndex = 0;
    _hiddenIndex = -1;

}

#define ItemWidth 80
#define ItemHeight 49
#define SideMarginX 0
#define SideMarginY 0
#define Spacing 0

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *tabBarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    
    tabBarBackgroundImageView.tag = TabBarBackgroundImageViewTag;
    tabBarBackgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    tabBarBackgroundImageView.image = _tabBarBackgroundImage;
    [self.tabBar insertSubview:tabBarBackgroundImageView atIndex:0];
    tabBarBackgroundImageView = nil ;
    for (int i = 0; i < 4; i++) {
        UIImageView *itemBg  = [[UIImageView alloc] initWithFrame:CGRectMake(SideMarginX +ItemWidth * i + Spacing * i, SideMarginY, ItemWidth, ItemHeight)];
        itemBg.contentMode = UIViewContentModeScaleAspectFit;
        itemBg.image = [_unSelectedImageArray objectAtIndex:i];
        [self.tabBar insertSubview:itemBg atIndex:1];
        [_itemBgImageViewArray addObject:itemBg];
        itemBg = nil ;
    }
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.selectedIndex = [tabBar.items indexOfObject:item];
}

@end

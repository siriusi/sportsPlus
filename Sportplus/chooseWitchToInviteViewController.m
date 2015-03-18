//
//  chooseWitchToInviteViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "chooseWitchToInviteViewController.h"

typedef enum {
    GestureEndedAtFieldInviteFriend = -1 ,
    GestureEndedAtFieldNone = 0 ,
    GestureEndedAtFieldInviteStranger = 1 ,
}GestureEndedAtField ;

@interface chooseWitchToInviteViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarCycleImgView;

@end

@implementation chooseWitchToInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES] ;
    [super viewWillAppear:animated] ;
    
    [self resetAvatarImgView] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)resetAvatarImgView {
    CGRect rect = CGRectMake(122, 224, 77,77) ;
    [self.avatarImgView setFrame:rect] ;
    [self.avatarCycleImgView setHidden:FALSE] ;
}

- (IBAction)toInviteStrangerViewController:(id)sender {
    [self performSegueWithIdentifier:@"chooseToStrangerSegueID" sender:self] ;
}

- (IBAction)toInviteFriendViewController:(id)sender {
    [self performSegueWithIdentifier:@"chooseToFriendSegueID" sender:self] ;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.navigationController setNavigationBarHidden:NO] ;
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES] ;
}

#pragma mark - UIGesture 

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *view = [gestureRecognizer view]; // 这个view是手势所属的view，也就是增加手势的那个view
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"======UIGestureRecognizerStateBegan");
            [self.avatarCycleImgView setHidden:TRUE] ;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            NSLog(@"======UIGestureRecognizerStateChanged");
            
            /*
             让view跟着手指移动
             
             1.获取每次系统捕获到的手指移动的偏移量translation
             2.根据偏移量translation算出当前view应该出现的位置
             3.设置view的新frame
             4.将translation重置为0（十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！）
             */
            
            CGPoint translation = [gestureRecognizer translationInView:self.view];
            //            view.center = CGPointMake(gestureRecognizer.view.center.x + translation.x, gestureRecognizer.view.center.y + translation.y);
            view.center = CGPointMake(gestureRecognizer.view.center.x, gestureRecognizer.view.center.y + translation.y) ;
            [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];//  注意一旦你完成上述的移动，将translation重置为0十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"======UIGestureRecognizerStateCancelled");
            break;
        }
        case UIGestureRecognizerStateFailed:{
            NSLog(@"======UIGestureRecognizerStateFailed");
            break;
        }
        case UIGestureRecognizerStatePossible:{
            NSLog(@"======UIGestureRecognizerStatePossible");
            break;
        }
        case UIGestureRecognizerStateEnded:{ // UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded
            
            /*
             当手势结束后，view的减速缓冲效果
             
             模拟减速写的一个很简单的方法。它遵循如下策略：
             计算速度向量的长度（i.e. magnitude）
             如果长度小于200，则减少基本速度，否则增加它。
             基于速度和滑动因子计算终点
             确定终点在视图边界内
             让视图使用动画到达最终的静止点
             使用“Ease out“动画参数，使运动速度随着时间降低
             */
            
            NSLog(@"======UIGestureRecognizerStateEnded || UIGestureRecognizerStateRecognized");
            
            CGPoint velocity = [gestureRecognizer velocityInView:self.view];// 分别得出x，y轴方向的速度向量长度（velocity代表按照当前速度，每秒可移动的像素个数，分xy轴两个方向）
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));// 根据直角三角形的算法算出综合速度向量长度
            
            // 如果长度小于200，则减少基本速度，否则增加它。
            CGFloat slideMult = magnitude / 200;
            
            NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
            float slideFactor = 0.1 * slideMult; // Increase for more of a slide
            
            // 基于速度和滑动因子计算终点
            CGPoint finalPoint = CGPointMake(view.center.x + (velocity.x * slideFactor),
                                             view.center.y + (velocity.y * slideFactor));
            
            // 确定终点在视图边界内
//            finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
            finalPoint.x = self.view.center.x ;
            finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
            
            
            void (^myBlock)(BOOL) = ^(BOOL finished) {
                GestureEndedAtField EndedAtField = [self gestureEndAtField:finalPoint] ;
                
                if ( EndedAtField == GestureEndedAtFieldInviteFriend ) {
                    [self performSegueWithIdentifier:@"chooseToFriendSegueID" sender:self] ;
                } else
                    if ( EndedAtField == GestureEndedAtFieldInviteStranger ) {
                        [self performSegueWithIdentifier:@"chooseToStrangerSegueID" sender:self] ;
                    } else {
                        NSLog(@"返回") ;
                        
                        [self resetAvatarImgView] ;
                    }
                
            } ;
            
            [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                view.center = finalPoint;
            } completion:myBlock];
            
            
            break;
        }
        default:{
            NSLog(@"======Unknow gestureRecognizer");
            break;
        }
    }
}

- (GestureEndedAtField)gestureEndAtField:(CGPoint)center {
    CGPoint friend1 = self.InviteFriendBtn.frame.origin ;
    CGPoint friend2 = CGPointMake(friend1.x + self.InviteFriendBtn.frame.size.width, friend1.y + self.InviteFriendBtn.frame.size.height) ;
    if ( friend1.x <= center.x && center.x <= friend2.x ) {
        if (friend1.y <=center.y && center.y <= friend2.y) {
            return GestureEndedAtFieldInviteFriend ;
        }
    }

    CGPoint stranger1 = self.InviteStrangerBtn.frame.origin ;
    CGPoint stranger2 = CGPointMake(stranger1.x + self.InviteStrangerBtn.frame.size.width, stranger1.y + self.InviteStrangerBtn.frame.size.height) ;
    
    if ( stranger1.x <= center.x && center.x <= stranger2.x ) {
        if (stranger1.y <=center.y && center.y <= stranger2.y) {
            return GestureEndedAtFieldInviteStranger ;
        }
    }
    
    return GestureEndedAtFieldNone ;
}

- (void)toInviteFriend {
    [self performSegueWithIdentifier:@"chooseToStrangerSegueID" sender:self] ;
}

- (void)toInviteStranger {
    [self performSegueWithIdentifier:@"chooseToFriendSegueID" sender:self] ;
}

@end

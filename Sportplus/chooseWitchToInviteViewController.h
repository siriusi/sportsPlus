//
//  chooseWitchToInviteViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chooseWitchToInviteViewController : UIViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *InviteFriendBtn;
@property (weak, nonatomic) IBOutlet UIButton *InviteStrangerBtn;


@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;

@end

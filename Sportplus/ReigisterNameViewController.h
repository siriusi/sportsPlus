//
//  ReigisterNameViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisteData.h"
#import "RigisterDetailViewController.h"
@interface ReigisterNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet UIButton *pButton;
@property (weak, nonatomic) IBOutlet UIButton *tButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *rButton;
@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *sButton;
@property (weak, nonatomic) IBOutlet UIButton *basketButton;

- (IBAction)nextStep:(id)sender;

@property(nonatomic) NSMutableArray *sportsArray;
@property(nonatomic) BOOL gender;
@property(nonatomic) BOOL pingpongSelected;
@property(nonatomic) BOOL tenniseSelected;
@property(nonatomic) BOOL buildSelected;
@property(nonatomic) BOOL badmintonSelected;
@property(nonatomic) BOOL basketballSelected;
@property(nonatomic) BOOL runSelected;
@property(nonatomic) BOOL soccerSelected;

@property(nonatomic) NSMutableDictionary *sportsContent;

@property(nonatomic) RegisteData *regist;
@end

//
//  RegistFinshViewController.h
//  Sportplus
//
//  Created by Forever.H on 15/1/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisteData.h"
#import "AvosCloudNetNetWorkManager.h"
#import "SVProgressHUD.h"

@interface RegistFinshViewController : UIViewController<AVDataDelegate>
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UITextField *teleTxt;
@property (weak, nonatomic) IBOutlet UITextField *numTxt;
@property (weak, nonatomic) IBOutlet UITextField *passTxt;
@property (nonatomic) BOOL stopRun;
@property (nonatomic) int jumpTime;
@property (nonatomic) int timePass;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishRegist;
@property (nonatomic) NSTimer *timer;
@end

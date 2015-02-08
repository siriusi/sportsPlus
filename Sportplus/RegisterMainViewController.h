//
//  RegisterMainViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisteData.h"

@interface RegisterMainViewController : UIViewController
- (IBAction)rigister:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *professionName;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property(nonatomic) NSString *chooseSchoolName;
@property(nonatomic) NSString *chooseProfessionName;
@property(nonatomic) NSString *chooseTime;
@end

//
//  ChangePasswordViewController.h
//  Sportplus
//
//  Created by Forever.H on 15/3/8.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
- (IBAction)submitBtn:(id)sender;
- (IBAction)backToPreViewBtn:(id)sender;

@end

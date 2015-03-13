//
//  AccountBindingViewController.h
//  Sportplus
//
//  Created by Forever.H on 15/3/13.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountBindingViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
- (IBAction)backToPreViewBtn:(id)sender;

@end

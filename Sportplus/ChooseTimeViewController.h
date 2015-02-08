//
//  ChooseTimeViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterMainViewController.h"
@interface ChooseTimeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *timeTableView;
@property ( nonatomic) NSMutableArray *timeList;
@property ( nonatomic) NSString *time;
@end

//
//  ChooseSchoolViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterMainViewController.h"
@interface ChooseSchoolViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *schoolTableView;
@property ( nonatomic) NSMutableArray *schoolList;
@property ( nonatomic) NSString *school;
@end

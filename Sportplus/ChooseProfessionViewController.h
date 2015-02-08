//
//  ChooseProfessionViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterMainViewController.h"
@interface ChooseProfessionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *professionTableView;
@property ( nonatomic) NSMutableArray *professionList;
@end

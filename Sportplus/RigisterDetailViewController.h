//
//  RigisterDetailViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/7.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "levelTableViewCell.h"
#import "TagTableViewCell.h"
#import "RegisteData.h"

@interface RigisterDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *titleArray;
    NSMutableArray *sportsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL sectionTwo;
@property (nonatomic) NSMutableDictionary *sportsListCell;
@property (nonatomic) NSMutableArray *tagsList;
- (IBAction)nextStep:(id)sender;

@property (nonatomic) BOOL mengSelected;
@property (nonatomic) BOOL yuSelected;
@property (nonatomic) BOOL nvSelected;
@property (nonatomic) BOOL gaoSelected;
@property (nonatomic) BOOL nuanSelected;
@property (nonatomic) BOOL zhengSelected;
@property (nonatomic) BOOL jiaoSelected;
@property (nonatomic) BOOL yunSelected;
@property (nonatomic) BOOL daSelected;

@end

//
//  ChooseSportSpaceViewController.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSportSpaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *systemIncludeBtn;
@property (weak, nonatomic) IBOutlet UIButton *userDefineBtn;
@property (weak, nonatomic) IBOutlet UIView *leftHorizontalLine;
@property (weak, nonatomic) IBOutlet UIView *rightHorizontalLine;

- (IBAction)systemIncludeBtnClicked:(id)sender;
- (IBAction)userDefineBtnClicked:(id)sender;


@end

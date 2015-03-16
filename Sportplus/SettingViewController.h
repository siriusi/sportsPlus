//
//  SettingViewController.h
//  Sportplus
//
//  Created by Forever.H on 14/12/21.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>{
    NSMutableArray *titleArray;
    NSMutableArray *cellTitle;
}
@property (weak, nonatomic) IBOutlet UITableView *settingTable;
@property (nonatomic) UIActionSheet *actionSheet;
@end

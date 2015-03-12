//
//  ChangeNameViewController.m
//  Sportplus
//
//  Created by Forever.H on 15/3/8.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChangeNameViewController.h"

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.translucent=YES;
//    
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(back)
//         forControlEvents:UIControlEventTouchUpInside];
//    backButton.frame = CGRectMake(0, 0, 9, 18);
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    [self.navigationItem setLeftBarButtonItem:backItem];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)submit:(id)sender {
    NSLog(@"修改姓名成功！");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backToPreViewBtn:(id)sender {
    NSLog(@"back!");
    [self.navigationController popViewControllerAnimated:YES];
}
@end

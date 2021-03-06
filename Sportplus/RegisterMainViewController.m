//
//  RegisterMainViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "RegisterMainViewController.h"
#import "AppDelegate.h"

@interface RegisterMainViewController ()

@end

@implementation RegisterMainViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent=YES;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

-(void)viewDidAppear:(BOOL)animated{
    if(self.chooseSchoolName!=nil)
    {
        self.schoolName.text = self.chooseSchoolName;
    }
    if(self.chooseProfessionName!=nil)
    {
        self.professionName.text = self.chooseProfessionName;
    }
    if(self.chooseTime!=nil)
    {
        self.time.text = self.chooseTime;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (void)back{
    NSLog(@"back!");
}

-(void) sportsAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)rigister:(id)sender {
    UIImage *backButtonImage = [UIImage imageNamed:@"cancel"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    RegisteData *regiData = [RegisteData shareInstance];
    [regiData.info setValue:self.chooseSchoolName forKey:@"school"];
    
    [regiData.info setObject:_choosedCampus forKey:@"campus"] ;
    
    [regiData.info setValue:self.chooseProfessionName forKey:@"academy"];
    [regiData.info setValue:[NSNumber numberWithInt:[self.chooseTime intValue]] forKey:@"enterScYear"];
    
    if(self.chooseSchoolName==nil||self.chooseTime==nil||self.chooseProfessionName==nil)
    {
        [self sportsAlertView];
    }
    else{
        [self performSegueWithIdentifier:@"RegistName" sender:self];
    }
}
@end

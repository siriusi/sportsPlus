//
//  RegistFinshViewController.m
//  Sportplus
//
//  Created by Forever.H on 15/1/2.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "RegistFinshViewController.h"

@interface RegistFinshViewController ()

@end

@implementation RegistFinshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    // Do any additional setup after loading the view.
    self.jumpTime = 0;
    self.timePass = 0;
    self.stopRun = NO;
    self.testLabel.hidden = YES;
    self.testLabel.text = @"1/60秒";
    [self.timeBtn addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishRegist addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    NSLog(@"back!");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)run:(UIButton *)sender{
    self.timeBtn.hidden=YES;
    self.testLabel.hidden = NO;
    self.stopRun = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    
    
}

-(void)progressChange{
    if(self.stopRun == NO)
    {
        self.jumpTime++;
        if(self.jumpTime==50)
        {
            self.timePass++;
            self.jumpTime = 0;
            NSLog(@"time is %d",self.timePass);
            self.testLabel.text = [NSString stringWithFormat:@"%d/60秒",self.timePass+1];
        }
    }
    
    if(self.timePass == 59)
    {
        self.stopRun = YES;
        self.timeBtn.hidden=NO;
        self.testLabel.hidden = YES;
        self.testLabel.text = @"1/60秒";
        self.jumpTime = 0;
        self.timePass = 0;
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void) sportsAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void) registAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"注册失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void) finish:(UIButton *)sender{
    if(self.passTxt.text==nil)
    {
        [self sportsAlertView];
    }
    else{
        RegisteData *regist = [RegisteData shareInstance];
        [regist.info setValue:self.passTxt.text forKey:@"password"];
        [regist.info setValue:self.teleTxt.text forKey:@"userName"];
        NSLog(@"regist info is %@",regist.info);
        //AvosCloudNetNetWorkManager *manager = [AvosCloudNetNetWorkManager sharedInstace];
        //[manager registeWithInfo:regist.info delegate:self];
        
        //[SVProgressHUD show];
        
                
        [self performSegueWithIdentifier:@"GotoMainPage" sender:self];
    }
    
    
}

-(void)registeSuccessed:(BOOL) successed{
    if(successed == true)
    {
        [SVProgressHUD dismiss];
        [self performSegueWithIdentifier:@"GotoMainPage" sender:self];
    }
    else{
        [SVProgressHUD dismiss];
        [self registAlertView];
        
    }
}
@end

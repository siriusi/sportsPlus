//
//  ReigisterNameViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "ReigisterNameViewController.h"

@interface ReigisterNameViewController ()

@end

@implementation ReigisterNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent=YES;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.regist = [RegisteData shareInstance];
    NSLog(@"%@",self.regist.info);
    
    [self dataInit];
    
    [self.maleButton addTarget:self action:@selector(male:) forControlEvents:UIControlEventTouchUpInside];
    [self.femaleButton addTarget:self action:@selector(female:) forControlEvents:UIControlEventTouchUpInside];
    [self.pButton addTarget:self action:@selector(pingpong:) forControlEvents:UIControlEventTouchUpInside];
    [self.bButton addTarget:self action:@selector(build:) forControlEvents:UIControlEventTouchUpInside];
    [self.tButton addTarget:self action:@selector(tennise:) forControlEvents:UIControlEventTouchUpInside];
    [self.rButton addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside];
    [self.badButton addTarget:self action:@selector(badminton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sButton addTarget:self action:@selector(soccer:) forControlEvents:UIControlEventTouchUpInside];
    [self.basketButton addTarget:self action:@selector(basketball:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    NSLog(@"cancel");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) dataInit{
    self.sportsContent = [[NSMutableDictionary alloc]init];
    self.pingpongSelected = NO;
    self.tenniseSelected = NO;
    self.buildSelected = NO;
    self.runSelected = NO;
    self.badmintonSelected = NO;
    self.basketballSelected = NO;
    self.soccerSelected = NO;
    
    [self.maleButton setImage:[UIImage imageNamed:@"male"] forState:UIControlStateNormal];
    [self.femaleButton setImage:[UIImage imageNamed:@"female"] forState:UIControlStateNormal];
    [self.pButton setImage:[UIImage imageNamed:@"pingpong"] forState:UIControlStateNormal];
    [self.bButton setImage:[UIImage imageNamed:@"build"] forState:UIControlStateNormal];
    [self.tButton setImage:[UIImage imageNamed:@"tennise"] forState:UIControlStateNormal];
    [self.rButton setImage:[UIImage imageNamed:@"run"] forState:UIControlStateNormal];
    [self.badButton setImage:[UIImage imageNamed:@"badminton"] forState:UIControlStateNormal];
    [self.sButton setImage:[UIImage imageNamed:@"soccer"] forState:UIControlStateNormal];
    [self.basketButton setImage:[UIImage imageNamed:@"basketball"] forState:UIControlStateNormal];
    
}

-(void)male:(UIButton *)sender{
    [self.maleButton setImage:[UIImage imageNamed:@"maleSelected"] forState:UIControlStateNormal];
    [self.femaleButton setImage:[UIImage imageNamed:@"female"] forState:UIControlStateNormal];
    self.gender = YES;
}

-(void)female:(UIButton *)sender{
    [self.femaleButton setImage:[UIImage imageNamed:@"femaleSelected"] forState:UIControlStateNormal];
    [self.maleButton setImage:[UIImage imageNamed:@"male"] forState:UIControlStateNormal];
    self.gender = NO;
}

-(void) sportsAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"运动项至少选择一个" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)pingpong:(UIButton *)sender{
    if(self.pingpongSelected==NO)
    {
        self.pingpongSelected=YES;
        [self.pButton setImage:[UIImage imageNamed:@"pingpongChoose"] forState:UIControlStateNormal];
        [self.sportsContent setValue:@0 forKey:@"乒乓球"];
    }
    else
    {
        self.pingpongSelected=NO;
        [self.pButton setImage:[UIImage imageNamed:@"pingpong"] forState:UIControlStateNormal];
        [self.sportsContent removeObjectForKey:@"乒乓球"];
    }
}

-(void)run:(UIButton *)sender{
    if(self.runSelected==NO)
    {
        self.runSelected=YES;
        [self.rButton setImage:[UIImage imageNamed:@"runChoose"] forState:UIControlStateNormal];
        [self.sportsContent setValue:@0 forKey:@"跑步"];
        
    }
    else
    {
        self.runSelected=NO;
        [self.rButton setImage:[UIImage imageNamed:@"run"] forState:UIControlStateNormal];
        [self.sportsContent removeObjectForKey:@"跑步"];
    }
}

-(void)build:(UIButton *)sender{
    if(self.buildSelected==NO)
    {
        self.buildSelected=YES;
        [self.bButton setImage:[UIImage imageNamed:@"buildChoose"] forState:UIControlStateNormal];
        [self.sportsContent setValue:@0 forKey:@"健身"];
        
    }
    else
    {
        self.buildSelected=NO;
        [self.bButton setImage:[UIImage imageNamed:@"build"] forState:UIControlStateNormal];
        [self.sportsContent removeObjectForKey:@"健身"];
    }
}

-(void)tennise:(UIButton *)sender{
    if(self.tenniseSelected==NO)
    {
        
        self.tenniseSelected=YES;
        [self.tButton setImage:[UIImage imageNamed:@"tenniseChoose"] forState:UIControlStateNormal];
        [self.sportsContent setValue:@0 forKey:@"网球"];
        
    }
    else
    {
        self.tenniseSelected=NO;
        [self.tButton setImage:[UIImage imageNamed:@"tennise"] forState:UIControlStateNormal];
        [self.sportsContent removeObjectForKey:@"网球"];
    }
}

-(void)badminton:(UIButton *)sender{
    if(self.badmintonSelected==NO)
    {
        self.badmintonSelected=YES;
        [self.badButton setImage:[UIImage imageNamed:@"badmintonChoose"] forState:UIControlStateNormal];
        [self.sportsContent setValue:@0 forKey:@"羽毛球"];
       
    }
    else
    {
        self.badmintonSelected=NO;
        [self.badButton setImage:[UIImage imageNamed:@"badminton"] forState:UIControlStateNormal];
        [self.sportsContent removeObjectForKey:@"羽毛球"];
    }
}

-(void)soccer:(UIButton *)sender{
    if(self.soccerSelected==NO)
    {
        self.soccerSelected=YES;
        [self.sButton setImage:[UIImage imageNamed:@"soccerChoose"] forState:UIControlStateNormal];
        [self.sportsContent setValue:@0 forKey:@"足球"];
        
    }
    else
    {
        self.soccerSelected=NO;
        [self.sButton setImage:[UIImage imageNamed:@"soccer"] forState:UIControlStateNormal];
        [self.sportsContent removeObjectForKey:@"足球"];
    }
}

-(void)basketball:(UIButton *)sender{
    if(self.basketballSelected==NO)
    {
        self.basketballSelected=YES;
        [self.basketButton setImage:[UIImage imageNamed:@"basketballChoose"] forState:UIControlStateNormal];
        [self.sportsContent setValue:@0 forKey:@"篮球"];
       
    }
    else
    {
        self.basketballSelected=NO;
        [self.basketButton setImage:[UIImage imageNamed:@"basketball"] forState:UIControlStateNormal];
        [self.sportsContent removeObjectForKey:@"篮球"];
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.realName resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.realName resignFirstResponder];
    return YES;
}

- (IBAction)nextStep:(id)sender {
    if(self.sportsContent.count<1)
    {
        [self sportsAlertView];
    }
    else{
        RegisteData *registData = [RegisteData shareInstance];
        [registData.info setValue:self.realName.text forKey:@"sp_userName"];
        [registData.info setValue:[self dictionaryToFormatArray:self.sportsContent] forKey:@"sportList"];
        NSString *sex = [[NSString alloc]init];
        if(self.gender == YES)
        {
            sex = @"男";
        }
        else{
            sex = @"女";
        }
        [registData.info setValue:sex forKey:@"sex"];
        NSLog(@"%@",registData.info);
        [self performSegueWithIdentifier:@"RegistDetail" sender:self];
    }
}

- (NSArray *)dictionaryToFormatArray:(NSDictionary *)dic {
    NSMutableArray *array = [[NSMutableArray alloc] init] ;
    
    for (id obj in dic) {
        [array addObject:obj] ;
    }
    
    return array ;
}

@end

//
//  TestViewController.m
//  Sportplus
//
//  Created by humao on 14-12-26.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "TestViewController.h"


@interface TestViewController (){
    AvosCloudNetNetWorkManager *manager ;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [AvosCloudNetNetWorkManager sharedInstace] ;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registeSuccessed:(BOOL)successed{
    [manager getCurrentUserInfo] ;
}

- (IBAction)test:(UIButton *)sender {
    NSMutableDictionary *ttt = [[NSMutableDictionary alloc] init] ;
    
    [ttt setValue:@"张睿5" forKey:@"userName"] ;
    [ttt setValue:@"123456" forKey:@"password"] ;
    [ttt setValue:@"男" forKey:@"sex"] ;
    [ttt setValue:@"同济大学" forKey:@"school"] ;
    [ttt setValue:@"软件学院" forKey:@"academy"] ;
    [ttt setValue:[NSNumber numberWithInt:2012] forKey:@"enterScYear"] ;
    [ttt setValue:@0 forKey:@"reportedCount"] ;
    [ttt setValue:@0 forKey:@"validatedCount"] ;
    [ttt setValue:@0 forKey:@"successCount"] ;
    [ttt setValue:@0 forKey:@"friendCount"] ;
    
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    [tags addObject:@"萌妹子"] ;
    [tags addObject:@"御姐"] ;
    [tags addObject:@"正太"] ;
    [ttt setValue:tags forKey:@"tagList"] ;
    
    NSMutableArray *sports = [[NSMutableArray alloc] init];
    [sports addObject:@{ @"乒乓球" : @1 } ] ;
    [sports addObject:@{ @"网球"  : @2 } ] ;
    [ttt setValue:sports forKey:@"sportList"] ;
    
    [manager registeWithInfo:ttt delegate:self] ;
    
}

- (IBAction)testLoginUser01:(UIButton *)sender {
    [manager loginWithUserName:@"张睿5" andPsd:@"123456"] ;
}

- (IBAction)testLoginUser02:(UIButton *)sender {
    [manager loginWithUserName:@"张瑞" andPsd:@"12345"] ;
}

- (IBAction)testLogoff:(UIButton *)sender {
    [manager logoff:self] ;
}

- (IBAction)changNameTest:(UIButton *)sender {
    [manager changeNameToName:@"张瑞"] ;
}

- (IBAction)changPsdTest:(UIButton *)sender {
    [manager changePsdToPsd:@"12345"] ;
}

-(void)getSelfInfo:(NSDictionary *)userInfo Successed:(BOOL)successed{
    NSLog(@"%@",[userInfo description]) ;
}

- (IBAction)getSelfInfo:(UIButton *)sender {
    [manager getSelfInfo:self] ;
}

-(void)getSearchedUserList:(NSArray *)userList Successed:(BOOL)successed{
    if (!successed) return ;
    NSLog(@"userList : %@",userList ) ;
    NSLog(@"Successed : %@",successed?@"TRUE" :@"FALSE" ) ;
}

- (IBAction)searchZr:(UIButton *)sender {
    [manager searchUserWithUsername:@"张瑞" delegate:self] ;
}

- (IBAction)testAddFriends:(UIButton *)sender {

}


@end

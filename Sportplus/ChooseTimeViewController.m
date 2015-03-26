//
//  ChooseTimeViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "ChooseTimeViewController.h"

#import "spCommon.h"
#import "spAVModels.h"
#import "SPCloudSevice.h"
#import "SVProgressHUD.h"

@interface ChooseTimeViewController (){
    NSMutableArray *_dataSourceOfSearchedTime ;
}

@end

@implementation ChooseTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent=YES;
    self.timeTableView.delegate=self;
    self.timeTableView.dataSource=self;
    self.searchBar.delegate = self;
    _dataSourceOfSearchedTime = [[NSMutableArray alloc] init] ;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.timeList = [[NSMutableArray alloc]init];
    for(int i=0;i<10;i++)
    {
        NSString *timeName = [NSString stringWithFormat:@"%d",i + 2000 ];
        [self.timeList addObject:timeName];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    NSLog(@"back!");
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *timeCellIdentifier = @"schoolCellIdentifier";
    UITableViewCell *cell = [self.timeTableView dequeueReusableCellWithIdentifier:timeCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:timeCellIdentifier];
    }
    cell.textLabel.text = self.timeList[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeList.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath is %ld",(long)indexPath.row);
    RegisterMainViewController *regi = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    regi.chooseTime = self.timeList[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchBar resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    self.searchBar.clearsOnBeginEditing = YES;
    [self searchStart];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}

-(void)searchStart{
    NSLog(@"search start!!");
    [self doSearchWithName:self.searchBar.text];
    
    
}

- (void)doSearchWithName:(NSString *)name {
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    //到这里会报错！
    [SPUserService findUsersByPartname:name withBlock:^(NSArray *objects, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SVProgressHUD dismiss] ;
        
        if (error == nil) {
            _dataSourceOfSearchedTime = [[NSMutableArray alloc] initWithArray:objects] ;
            [self.timeTableView reloadData] ;
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

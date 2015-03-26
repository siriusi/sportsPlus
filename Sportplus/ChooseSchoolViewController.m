//
//  ChooseSchoolViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/6.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "ChooseSchoolViewController.h"

#import "spCommon.h"
#import "spAVModels.h"
#import "SPCloudSevice.h"
#import "SVProgressHUD.h"
#import "SPCampusService.h"

@interface ChooseSchoolViewController (){
    NSMutableArray *_dataSourceOfSearchedSchool ;
}

@end

@implementation ChooseSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent=YES;
    self.schoolTableView.delegate=self;
    self.schoolTableView.dataSource = self;
    self.schoolTableView.hidden = YES;
    self.searchBar.delegate = self;
    
    _dataSourceOfSearchedSchool = [[NSMutableArray alloc] init] ;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.schoolList = [[NSMutableArray alloc]init];
    for(int i=0;i<10;i++)
    {
        NSString *schoolName = [NSString stringWithFormat:@"学校%d",i];
        [self.schoolList addObject:schoolName];
    }
    
    self.searchBar.returnKeyType = UIReturnKeySearch ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    NSLog(@"back!");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.schoolList.count;
    return [_dataSourceOfSearchedSchool count] ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *schoolCellIdentifier = @"schoolCellIdentifier";
    UITableViewCell *cell = [self.schoolTableView dequeueReusableCellWithIdentifier:schoolCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:schoolCellIdentifier];
    }
    cell.textLabel.text = [((spCampus *)[_dataSourceOfSearchedSchool objectAtIndex:indexPath.row]) schoolFullName] ;
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath is %ld",(long)indexPath.row);
    RegisterMainViewController *regi = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    regi.choosedCampus = [_dataSourceOfSearchedSchool objectAtIndex:indexPath.row] ;
    regi.chooseSchoolName = [((spCampus *)[_dataSourceOfSearchedSchool objectAtIndex:indexPath.row]) schoolFullName] ;
    
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
    self.schoolTableView.hidden = NO;
}

- (void)doSearchWithName:(NSString *)name {
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    [SPCampusService findCampusByPartname:name withBlock:^(NSArray *objects, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SVProgressHUD dismiss] ;
        if (!error) {
            _dataSourceOfSearchedSchool = [objects mutableCopy] ;
            NSLog(@"data = %@",_dataSourceOfSearchedSchool) ;
            [self.schoolTableView reloadData] ;
            
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
}

@end

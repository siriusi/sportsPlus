//
//  SettingViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/21.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "SettingViewController.h"
#import "accountTableViewCell.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.settingTable setDelegate:self];
    [self.settingTable setDataSource:self];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"  个人账户",@"  隐私",@"  通知", nil];
    cellTitle = [[NSMutableArray alloc] initWithObjects:@"头像设置",@"姓名设置",@"密码设置",@"账号绑定",@"黑名单",@"好友验证",@"声音",@"震动",@"通知显示详情", nil];
    // Do any additional setup after loading the view.
}

-(void)back{
    NSLog(@"back!");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionTitle = [[UILabel alloc]init];
    sectionTitle.frame = CGRectMake(0, 5, 200, 24);
    sectionTitle.font = [UIFont boldSystemFontOfSize:12];
    sectionTitle.numberOfLines = 0;
    switch (section) {
        case 0:
            sectionTitle.text = [titleArray objectAtIndex:section];
            break;
        case 1:
            sectionTitle.text =  [titleArray objectAtIndex:section];
            break;
        case 2:
            sectionTitle.text =  [titleArray objectAtIndex:section];
            break;
        default:
            break;
    }
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 24)];
    [sectionView setBackgroundColor:[UIColor lightGrayColor]];
    [sectionView addSubview:sectionTitle];
    return sectionView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [titleArray count];//返回标题数组中元素的个数来确定分区的个数
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return  5;
            break;
        case 1:
            return  1;
            break;
        case 2:
            return  3;
            break;
        default:
            return 0;
            break;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    static NSString *levelCellIdentifier = @"accountCellIdentifier";
    accountTableViewCell *cell = [self.settingTable dequeueReusableCellWithIdentifier:levelCellIdentifier];
    if (cell == nil) {
            //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"accountTableViewCell" owner:self options:nil] lastObject];
    }
    if(section==0)
    {
        cell.lable.text = cellTitle[indexPath.row];
        switch (indexPath.row) {
            case 0:
                cell.img.hidden=NO;
                cell.gotoButton.hidden=NO;
                cell.switchButton.hidden=YES;
                break;
            default:
                cell.img.hidden=YES;
                cell.gotoButton.hidden=NO;
                cell.switchButton.hidden=YES;
                break;
        }
    }
    if(section==1)
    {
        cell.lable.text = cellTitle[5];
        cell.img.hidden=YES;
        cell.gotoButton.hidden=YES;
        cell.switchButton.hidden=NO;
    }
    if(section==2)
    {
        cell.lable.text = cellTitle[6+indexPath.row];
        cell.img.hidden=YES;
        cell.gotoButton.hidden=YES;
        cell.switchButton.hidden=NO;
    }
        return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
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

//
//  FriendsManagementViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/20.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "FriendsManagementViewController.h"
#import "FriendTableViewCell.h"
#import "SportsCollectionViewCell.h"

@interface FriendsManagementViewController ()

@end

@implementation FriendsManagementViewController

- (void)viewDidLoad {
    
    UIImage *backButtonImage = [UIImage imageNamed:@"back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    
    [super viewDidLoad];
    [self.friendsTableView setDelegate:self];
    [self.friendsTableView setDataSource:self];
    UIRefreshControl *UIRC = [[UIRefreshControl alloc] init] ;

    
    [self.sportsCollectionView setDataSource:self];
    [self.sportsCollectionView setDelegate:self];
    
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImage *add = [UIImage imageNamed:@"addFriends"];
    addImg.image =add;
    [self.addFriendsButton setImage:add];
    [self.addFriendsButton setWidth:20];
    
    
    titleArrary = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C", nil];
    // Do any additional setup after loading the view.
    
    [self.sportsCollectionView registerClass:[SportsCollectionViewCell class] forCellWithReuseIdentifier:@"SportsCollectionCell"];
    [self.allBtn addTarget:self action:@selector(all) forControlEvents:UIControlEventTouchUpInside];
    
    self.sportsArray = [[NSMutableArray alloc] initWithObjects:@"篮球灰",@"足球灰",@"跑步灰",@"网球灰",@"羽毛球灰",@"乒乓球灰",@"健身灰", nil];
    self.sportsArrayWhite = [[NSMutableArray alloc] initWithObjects:@"篮球白",@"足球白",@"跑步白",@"网球白",@"羽毛球白",@"乒乓球白",@"健身白", nil];
    self.clickArray = [[NSMutableArray alloc] init];
    NSString *click = @"NO";
    for(int i=0;i<7;i++)
    {
        [self.clickArray addObject:click];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionTitle = [[UILabel alloc]init];
    sectionTitle.frame = CGRectMake(20, 2, 200, 22);
    sectionTitle.numberOfLines = 0;
    sectionTitle.textColor = [UIColor whiteColor];
    sectionTitle.font = [UIFont fontWithName:@"Menlo-Bold" size:12];
    switch (section) {
        case 0:
            sectionTitle.text = [titleArrary objectAtIndex:section];
            break;
        case 1:
            sectionTitle.text =  [titleArrary objectAtIndex:section];
            break;
        case 2:
            sectionTitle.text =  [titleArrary objectAtIndex:section];
            break;
        default:
            break;
    }
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    UIImage *sectionImg = [UIImage imageNamed:@"sectionBackground"];
    UIImageView *sectionBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
    sectionBackground.image=sectionImg;
    [sectionView addSubview:sectionBackground];
    [sectionView addSubview:sectionTitle];
    
    return sectionView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [titleArrary count];//返回标题数组中元素的个数来确定分区的个数
    
}

- (void)refresh {
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  3;
            
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
    static NSString *FriendCellIdentifier = @"FriendCellIdentifier";
    FriendTableViewCell *cell = [self.friendsTableView dequeueReusableCellWithIdentifier:FriendCellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendTableViewCell" owner:self options:nil] lastObject];
    }
    [cell.head addTarget:self action:@selector(jumpToUserPage:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}


//jump函数实现点击头像跳转
-(void)jumpToUserPage:(UIButton*)selector{
    NSLog(@"点击头像实现跳转，跳转函数自己写");
}



/*CollectionView*/
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //itemd的个数
    return 7;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SportsCollectionViewCell * cell = [self.sportsCollectionView dequeueReusableCellWithReuseIdentifier:@"SportsCollectionCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
            {
                cell.sportImg.image = [UIImage imageNamed:self.sportsArray[0]];
            }
            else{
                cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[0]];
            }
            break;
        case 1:
            if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
            {
                cell.sportImg.image = [UIImage imageNamed:self.sportsArray[1]];
            }
            else{
                cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[1]];
            }
            break;
        case 2:
            if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
            {
                cell.sportImg.image = [UIImage imageNamed:self.sportsArray[2]];
            }
            else{
                cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[2]];
            }
            break;
        case 3:
            if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
            {
                cell.sportImg.image = [UIImage imageNamed:self.sportsArray[3]];
            }
            else{
                cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[3]];
            }
            break;
        case 4:
            if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
            {
                cell.sportImg.image = [UIImage imageNamed:self.sportsArray[4]];
            }
            else{
                cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[4]];
            }
            break;
        case 5:
            if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
            {
                cell.sportImg.image = [UIImage imageNamed:self.sportsArray[5]];
            }
            else{
                cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[5]];
            }
            break;
        case 6:
            if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
            {
                cell.sportImg.image = [UIImage imageNamed:self.sportsArray[6]];
            }
            else{
                cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[6]];
            }
            break;
        default:
            break;
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:255/255.0 green:214/255.0 blue:0/255.0 alpha:1];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click %ld",(long)indexPath.row);
    SportsCollectionViewCell *cell = (SportsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *click = @"YES";
    NSString *unClick = @"NO";
    NSLog(@"old row is %ld",(long)self.oldCellRow.row);
    NSLog(@"old row is %@",self.oldCellRow);
    if([self.clickArray[indexPath.row] isEqualToString:@"NO"])
    {
        [self.clickArray replaceObjectAtIndex:indexPath.row withObject:click];
        cell.sportImg.image = [UIImage imageNamed:self.sportsArrayWhite[indexPath.row]];
        //cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:214/255.0 blue:0/255.0 alpha:1];
        if(self.oldCellRow)
        {
            SportsCollectionViewCell *oldCell = (SportsCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.oldCellRow];
            oldCell.sportImg.image = [UIImage imageNamed:self.sportsArray[self.oldCellRow.row]];
            //cell.backgroundColor = [UIColor whiteColor];
            [self.clickArray replaceObjectAtIndex:self.oldCellRow.row withObject:unClick];
            
        }
        self.oldCellRow = indexPath;
        NSLog(@"old row is %@",self.oldCellRow);
    }
    [self.allBtn setImage:[UIImage imageNamed:@"allButton"] forState:UIControlStateNormal];
    
    
}

-(void) all{
    NSLog(@"all");
    [self.allBtn setImage:[UIImage imageNamed:@"allButtonClicked"] forState:UIControlStateNormal];
    NSString *click = @"NO";
    for(int i=0;i<7;i++)
    {
        [self.clickArray replaceObjectAtIndex:i withObject:click];
    }
    [self.sportsCollectionView reloadData];
    
}
@end

//
//  RigisterDetailViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/7.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "RigisterDetailViewController.h"
#import "spCommon.h"


@interface RigisterDetailViewController ()

@end

@implementation RigisterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    titleArray = [[NSMutableArray alloc] initWithObjects:@"水平/菜鸟 进阶 高手",@"个性标签/最多三个标签", nil];
    sportsArray = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated{
    self.sectionTwo=NO;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 9, 18);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    RegisteData *regist = [RegisteData shareInstance];
#warning array is not a dictionary ;
    self.sportsListCell = [regist.info objectForKey:@"sportList"];
    self.tagsList = [[NSMutableArray alloc]init];
    
    self.sportListArray = [regist.info objectForKey:@"sportList"] ;
    self.tempSportListArray = [[NSMutableArray alloc] init] ;
    for (NSInteger i = 0 ; i < [self.sportListArray count]; i++) {
        [self.tempSportListArray addObject:@0] ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)back{
    NSLog(@"cancel");
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionTitle = [[UILabel alloc]init];
    sectionTitle.frame = CGRectMake(10, 5, 200, 22);
    sectionTitle.numberOfLines = 0;
    sectionTitle.textColor = [UIColor colorWithRed:172.0/255 green:172.0/255 blue:172.0/255 alpha:1.0f];
    sectionTitle.font = [UIFont italicSystemFontOfSize:12];
    switch (section) {
        case 0:
            sectionTitle.text = [titleArray objectAtIndex:section];
            break;
        case 1:
            sectionTitle.text =  [titleArray objectAtIndex:section];
            break;
        default:
            break;
    }
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:233.0/255 green:233.0/255 blue:234.0/255 alpha:1.0f]];
    [sectionView addSubview:sectionTitle];
    return sectionView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [titleArray count];//返回标题数组中元素的个数来确定分区的个数
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  self.sportListArray.count;
            
            break;
            
        case 1:
            
            return  1;
            
            break;
            
        default:
            
            return 0;  
            
            break;  
            
    }  
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    if(section==0)
    {
        static NSString *levelCellIdentifier = @"levelCellIdentifier";
        levelTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:levelCellIdentifier];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"levelTableViewCell" owner:self options:nil] lastObject];
        }
        self.sectionTwo = NO;
        
//        NSString *value = [self.sportListArray objectAtIndex:indexPath.row] ;
//        NSString *value = [NSString stringWithFormat:@"%@",[self.sportsListCell allValues][indexPath.row ]];
        
//        if([value isEqualToString:@"1"])
//        {
//            [cell.level1 setImage:[UIImage imageNamed:@"levelOneSelected"] forState:UIControlStateNormal];
//        }
//        if([value isEqualToString:@"2"])
//        {
//            [cell.level2 setImage:[UIImage imageNamed:@"levelTwoSelected"] forState:UIControlStateNormal];
//        }
//        if([value isEqualToString:@"3"])
//        {
//            [cell.level3 setImage:[UIImage imageNamed:@"levelThreeSelected"] forState:UIControlStateNormal];
//        }
        
        
        cell.sportImg.image = [UIImage imageNamed:[self.sportListArray objectAtIndex:indexPath.row]] ;
//        cell.sportImg.image = [UIImage imageNamed:[self.sportsListCell allKeys][indexPath.row]];
        [cell.level1 addTarget:self action:@selector(levelOne:) forControlEvents:UIControlEventTouchUpInside];
        [cell.level2 addTarget:self action:@selector(levelTwo:) forControlEvents:UIControlEventTouchUpInside];
        [cell.level3 addTarget:self action:@selector(levelThree:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        static NSString *tagCellIdentifier = @"tagCellIdentifier";
        TagTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tagCellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TagTableViewCell" owner:self options:nil] lastObject];
        }
        self.sectionTwo = YES;
        cell.tagArray = self.tagsList;
        NSLog(@"%@",self.tagsList);
        for(int i=0; i<self.tagsList.count; i++)
        {
            if([self.tagsList[i] isEqualToString:@"萌妹子"])
            {
                [cell.mengMZ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"御姐"])
            {
                [cell.yuJ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"女汉子"])
            {
                [cell.nvHZ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"高富帅"])
            {
                [cell.gaoFS setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"暖男"])
            {
                [cell.nuanN setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"正太"])
            {
                [cell.zhengT setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"交友控"])
            {
                [cell.jiaoYK setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"运动渣"])
            {
                [cell.yunDZ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
            if([self.tagsList[i] isEqualToString:@"大叔控"])
            {
                [cell.daSK setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            }
        }
        
        [cell.mengMZ addTarget:self action:@selector(meng:) forControlEvents:UIControlEventTouchUpInside];
        [cell.yuJ addTarget:self action:@selector(yu:) forControlEvents:UIControlEventTouchUpInside];
        [cell.nvHZ addTarget:self action:@selector(nv:) forControlEvents:UIControlEventTouchUpInside];
        [cell.gaoFS addTarget:self action:@selector(gao:) forControlEvents:UIControlEventTouchUpInside];
        [cell.nuanN addTarget:self action:@selector(nuan:) forControlEvents:UIControlEventTouchUpInside];
        [cell.zhengT addTarget:self action:@selector(zheng:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jiaoYK addTarget:self action:@selector(jiao:) forControlEvents:UIControlEventTouchUpInside];
        [cell.yunDZ addTarget:self action:@selector(yun:) forControlEvents:UIControlEventTouchUpInside];
        [cell.daSK addTarget:self action:@selector(da:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return  nil;
}

- (NSNumber *)getSportTypeBySportName:(NSString *)name {
    NSArray *array = @[@"",@"乒乓球",@"网球",@"足球",@"跑步",@"健身",@"篮球",@"羽毛球"] ;
    
    for (NSInteger i = 1; i <= [array count]; i++) {
        if ([[array objectAtIndex:i] isEqualToString:name]) {
            return [NSNumber numberWithInteger:i] ;
        }
    }
    
    return @0 ;
}

- (NSDictionary *)getDictionaryBySportsName:(NSString *)name level:(NSInteger)lv {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init] ;
    
    [dic setObject:[NSNumber numberWithInteger:lv] forKey:@"sportLevel"] ;
    [dic setObject:[self getSportTypeBySportName:name] forKey:@"sportType"] ;
    
    return dic ;
}

-(void)levelOne:(UIButton *)sender{
    
    levelTableViewCell *cell = (levelTableViewCell *)[[sender superview] superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
//    NSString *name =[self.sportsListCell allKeys][path.row];
    NSString *name = [self.sportListArray objectAtIndex:path.row] ;
    
    
    [self.tempSportListArray replaceObjectAtIndex:path.row withObject:[self getDictionaryBySportsName:name level:1]];
//    [self.sportsListCell setObject:@1 forKey:name];
}

-(void)levelTwo:(UIButton *)sender{
    levelTableViewCell *cell = (levelTableViewCell *)[[sender superview] superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
//    NSString *name =[self.sportsListCell allKeys][path.row];
//    [self.sportsListCell setObject:@2 forKey:name];
    NSString *name = [self.sportListArray objectAtIndex:path.row] ;
    
    [self.tempSportListArray replaceObjectAtIndex:path.row withObject:[self getDictionaryBySportsName:name level:1]];
    
}

-(void)levelThree:(UIButton *)sender{
    levelTableViewCell *cell = (levelTableViewCell *)[[sender superview] superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
//    NSString *name =[self.sportsListCell allKeys][path.row];
//    [self.sportsListCell setObject:@3 forKey:name];
    NSString *name = [self.sportListArray objectAtIndex:path.row] ;
    
    [self.tempSportListArray replaceObjectAtIndex:path.row withObject:[self getDictionaryBySportsName:name level:1]];
}

-(void) tagsAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"最多三个标签" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


-(void)meng:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    NSLog(@"%@",self.tagsList);
    
    if(self.mengSelected==NO){
        if(self.tagsList.count<3)
        {
            self.mengSelected = YES;
            [cell.mengMZ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"萌妹子"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.mengSelected = NO;
        [cell.mengMZ setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"萌妹子"];
    }
}

-(void)yu:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.yuSelected==NO){
        if(self.tagsList.count<3)
        {
            self.yuSelected = YES;
            [cell.yuJ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"御姐"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.yuSelected = NO;
        [cell.yuJ setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"御姐"];
    }
    NSLog(@"%@",self.tagsList);
}

-(void)nv:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.nvSelected==NO){
        if(self.tagsList.count<3)
        {
            self.nvSelected = YES;
            [cell.nvHZ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"女汉子"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.nvSelected = NO;
        [cell.nvHZ setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"女汉子"];
    }
    NSLog(@"%@",self.tagsList);
}

-(void)gao:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.gaoSelected==NO){
        if(self.tagsList.count<3)
        {
            self.gaoSelected = YES;
            [cell.gaoFS setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"高富帅"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.gaoSelected = NO;
        [cell.gaoFS setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"高富帅"];
    }
    NSLog(@"%@",self.tagsList);
}

-(void)nuan:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.nuanSelected==NO){
        if(self.tagsList.count<3)
        {
            self.nuanSelected = YES;
            [cell.nuanN setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"暖男"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.nuanSelected = NO;
        [cell.nuanN setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"暖男"];
    }
    NSLog(@"%@",self.tagsList);
}

-(void)zheng:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.zhengSelected==NO){
        if(self.tagsList.count<3)
        {
            self.zhengSelected = YES;
            [cell.zhengT setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"正太"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.zhengSelected = NO;
        [cell.zhengT setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"正太"];
    }
    NSLog(@"%@",self.tagsList);
}

-(void)jiao:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.jiaoSelected==NO){
        if(self.tagsList.count<3)
        {
            self.jiaoSelected = YES;
            [cell.jiaoYK setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"交友控"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.jiaoSelected = NO;
        [cell.jiaoYK setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"交友控"];
    }
    NSLog(@"%@",self.tagsList);
}

-(void)yun:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.yunSelected==NO){
        if(self.tagsList.count<3)
        {
            self.yunSelected = YES;
            [cell.yunDZ setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"运动渣"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.yunSelected = NO;
        [cell.yunDZ setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"运动渣"];
    }
    NSLog(@"%@",self.tagsList);
}

-(void)da:(UIButton *)sender{
    TagTableViewCell *cell = (TagTableViewCell *)[[sender superview] superview];
    if(self.daSelected==NO){
        if(self.tagsList.count<3)
        {
            self.daSelected = YES;
            [cell.daSK setBackgroundImage:[UIImage imageNamed:@"yellowCube"] forState:UIControlStateNormal];
            [self.tagsList addObject:@"大叔控"];
        }
        else{
            [self tagsAlertView];
        }
    }
    else{
        self.daSelected = NO;
        [cell.daSK setBackgroundImage:[UIImage imageNamed:@"grayCube"] forState:UIControlStateNormal];
        [self.tagsList removeObject:@"大叔控"];
    }
    NSLog(@"%@",self.tagsList);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionTwo==NO){
        return 80.0;
    }
    else{
        return 160;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) sportsAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)nextStep:(id)sender {
    UIImage *backButtonImage = [UIImage imageNamed:@"back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    BOOL jump=YES;
    
    RegisteData *regist = [RegisteData shareInstance];
    
    for(int i=0;i<[self.tempSportListArray count];i++)
    {
        
        if ([NSStringFromClass([[self.tempSportListArray objectAtIndex:i] class]) isEqualToString:@"NSNumber"]) {
            [self sportsAlertView] ;
            jump = NO ;
            break ;
        }
    }
    if(jump == YES)
    {
//        [regist.info setValue:self.sportsListCell forKey:@"sportList"];
        [regist.info setValue:self.tempSportListArray forKey:@"sportList"] ;
        [regist.info setValue:self.tagsList forKey:@"tagList"];
        NSLog(@"all infomation are %@",regist.info);
        [self performSegueWithIdentifier:@"RegistFinish" sender:self];
    }
}


@end


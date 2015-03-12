//
//  myHomePageViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/4.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "myHomePageViewController.h"
#import "spCommon.h"
#import "AppDelegate.h"

#import "ZR_photoLibraryCollectionViewCell.h"
#import "prefererSportSpaceTableViewCell.h"
#import "prefererSportTableViewCell.h"

#define segueID @"homePageToSetting"
#define MainPageNavStateAtPhotoLibraryOnFrame CGRectMake(2, 289, 315, 231)
#define MainPageNavStateAtPhotoLibraryHiddenFrame CGRectMake(322, 289, 315, 231)

#define MainPageNavStateAtPrefereSportOnFrame CGRectMake(0, 289, 320, 231)
#define MainPageNavStateAtPrefereSportHiddenFrame CGRectMake(320, 289, 320, 231)

//#define MainPageNavStateAtSelfInfoOnFrame CGRectMake(0, 289, 320, 231)
//#define MainPageNavStateAtSelfInfoHiddenFrame CGRectMake(320, 289, 320, 231)

#define BtnSelectedColor RGBCOLOR(0, 0, 0)
#define BtnNormalColor RGBCOLOR(234, 234, 234)

typedef enum {
    MainPageNavStateAtPrefereSport = 0 ,
    MainPageNavStateAtSelfInfo ,
    MainPageNavStateAtPhotoLibrary ,
} MainPageNavState;

@interface myHomePageViewController () {
    MainPageNavState _NavState ;
    
    NSArray *_dataSourceOfPrefereSport ;
}

@end

@implementation myHomePageViewController

#pragma mark - LifeCycle

- (void)initUIWithCurrentUserInfo {
    spUser *user = [spUser currentUser] ;
    
    [self.nameLabel setText:[user sP_userName] ];
    [self.validateCountLabel setText:[[user sP_validateCount] stringValue]] ;
    [self.friendCountLabel setText:[[user sP_friendCount] stringValue]] ;
    [self.successCountLabel setText:[[user sP_successCount] stringValue]] ;
    
    _dataSourceOfPrefereSport = [user sP_sportList] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIWithCurrentUserInfo] ;
    
    [self.navigationController setNavigationBarHidden:YES] ;
    
    self.collectionView.dataSource = self ;
    self.collectionView.delegate = self ;
    [self.collectionView registerClass:[ZR_photoLibraryCollectionViewCell class] forCellWithReuseIdentifier:@"photoLibraryCellID"] ;
    
    _NavState = MainPageNavStateAtPrefereSport ;
    
    
    self.prefererTableView.dataSource = self ;
    self.prefererTableView.delegate = self ;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self.navigationController setNavigationBarHidden:YES animated:NO] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 5 ? 1 : 3  ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"photoLibraryCellID" ;
    
    ZR_photoLibraryCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath] ;
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZR_photoLibraryCollectionViewCell" owner:self options:nil] lastObject];
    }
    
    if ( indexPath.section == 1 ) {
//        [cell.photoImageView setImage:[UIImage imageNamed:@"cameraIcon"]] ;
    }
    
    
    return cell ;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [_dataSourceOfPrefereSport count] ;
    return ( count * 2 - 1 ) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID1 = @"prefererSportTableViewCellID" ;
    static NSString *cellID2 = @"spaceCellID" ;
    
    NSInteger row = indexPath.row ;
    
    UITableViewCell *cell ;
    
    if ( row % 2 == 0 ) {
        cell = [self.prefererTableView dequeueReusableCellWithIdentifier:cellID1] ;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"prefererSportTableViewCell" owner:self options:nil] lastObject];
        }
        
        {
            NSInteger index = row / 2 ;
            
            NSDictionary *dic = [_dataSourceOfPrefereSport objectAtIndex:index] ;
            NSInteger sportLevel = [[dic objectForKey:@"sportLevle"] integerValue] ;
            NSInteger sportType = [[dic objectForKey:@"sportType"] integerValue];
            
        }
        
    } else {
        cell = [self.prefererTableView dequeueReusableCellWithIdentifier:cellID2] ;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"prefererSportSpaceTableViewCell" owner:self options:nil] lastObject];
        }
        
    }
    
    return cell ;
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    {
        UIButton *moreSportsBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [moreSportsBtn setFrame:CGRectMake(260, 17, 22, 5)] ;
        [moreSportsBtn setImage:[UIImage imageNamed:@"BtnMoreNormal"] forState:UIControlStateNormal] ;
        [moreSportsBtn addTarget:self action:@selector(toEditSportVC) forControlEvents:UIControlEventTouchUpInside] ;
        
        [footerView addSubview:moreSportsBtn] ;
    }
    
    return footerView ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        return 44 ;
    } else {
        return 25 ;
    }
}

#pragma mark - IBAction

- (void)toEditSportVC{
    [self performSegueWithIdentifier:@"mainPageToChooseSport" sender:self] ;
}

- (IBAction)navBtnClicked:(UIButton *)sender {

#warning 之后重写.
    if ( sender.tag == 1000 ) {
        
        [self.v1 setHidden:FALSE] ;
        [self.v2 setHidden:TRUE] ;
        [self.v3 setHidden:TRUE] ;
        
        _NavState = MainPageNavStateAtPrefereSport ;
        
        [self.prefererTableView setFrame:MainPageNavStateAtPrefereSportOnFrame] ;
        [self.collectionView setFrame:MainPageNavStateAtPhotoLibraryHiddenFrame] ;
        
    } else
    if ( sender.tag == 1001 ) {
        [self.v1 setHidden:TRUE] ;
        [self.v2 setHidden:FALSE] ;
        [self.v3 setHidden:TRUE] ;
        
        _NavState = MainPageNavStateAtSelfInfo ;
        
    } else
    if ( sender.tag == 1002 ) {
        [self.v1 setHidden:TRUE] ;
        [self.v2 setHidden:TRUE] ;
        [self.v3 setHidden:FALSE] ;
        
        _NavState = MainPageNavStateAtPhotoLibrary ;
        
        [self.prefererTableView setFrame:MainPageNavStateAtPrefereSportHiddenFrame] ;
        [self.collectionView setFrame:MainPageNavStateAtPhotoLibraryOnFrame] ;
        
    }

    [self.prefereSportBtn setTitleColor:BtnNormalColor forState:UIControlStateNormal] ;
    [self.selfInfoBtn setTitleColor:BtnNormalColor forState:UIControlStateNormal]  ;
    [self.selfPhotoLibraryBtn setTitleColor:BtnNormalColor forState:UIControlStateNormal] ;
    
    [sender setTitleColor:BtnSelectedColor forState:UIControlStateNormal];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:NO] ;
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES] ;
}

@end

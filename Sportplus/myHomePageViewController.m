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

#import <MobileCoreServices/MobileCoreServices.h>

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
    
    UIActionSheet *_actionSheet ;
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

- (NSInteger)getPhotoNumber {
    spUser *curUser = [spUser currentUser] ;
    NSArray *photoLists = [curUser sP_photoIdList] ;
    NSInteger numberOfPhoto = 0 ;
    if (photoLists != nil) {
        numberOfPhoto = [photoLists count] ;
    }
    return numberOfPhoto ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
#warning 性能优化
    NSInteger numberOfPhoto = [self getPhotoNumber] ;
    NSInteger numberOfItem = numberOfPhoto + 1 ;
    NSInteger numberOfSection = ( numberOfItem + 2 )/ 3 ;//16 17 18 是一样的个数
    
    if (numberOfSection - 1 ==  section) {
        return numberOfItem % 3 ;
    } else {
        return 3 ;//每行3个
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
#warning 性能优化
    NSInteger numberOfPhoto = [self getPhotoNumber] ;
    NSInteger numberOfItem = numberOfPhoto + 1 ;
    
    NSInteger numberOfSection = ( numberOfItem + 2 )/ 3 ;//16 17 18 是一样的个数
    
    return numberOfSection ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"photoLibraryCellID" ;
    
    ZR_photoLibraryCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath] ;
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZR_photoLibraryCollectionViewCell" owner:self options:nil] lastObject];
    }
    
    if ([self isLastCollectionIndexPath:indexPath]) {
        //是最后一个
        [cell.photoImageView setImage:[UIImage imageNamed:@"cameraIcon"]] ;
        return cell ;
    } else {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"test.png"];
        
        UIImage *cellImage = [UIImage imageWithContentsOfFile:imageFilePath] ;
        [cell.photoImageView setImage:cellImage] ;
    }
    //不是最后一个就加载图片
//    [cell.photoImageView setImage:[UIImage imageNamed:@""]] ;
    
    return cell ;
}

#pragma mark - UICollectionViewDelegate

- (BOOL) isLastCollectionIndexPath:(NSIndexPath *)indexPath {
    NSInteger numberOfItem = [self getPhotoNumber] + 1 ;
    NSInteger numberOfItemAtIndexPath = indexPath.section * 3 + indexPath.row + 1;
    
    if (numberOfItemAtIndexPath == numberOfItem) {
        return TRUE ;
    } else {
        return FALSE ;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isLastCollectionIndexPath:indexPath]) {
        [self showgetPhotoActionSheet] ;
    } else {
        [self showDeletePhotoActionSheet] ;
    }
}

#pragma mark - UIActionSheetDelegate

- (void)showgetPhotoActionSheet {
    _actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册中选择", nil] ;
    _actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque ;
    [_actionSheet showInView:self.view] ;
    [_actionSheet setTag:1001] ;
}

- (void)showDeletePhotoActionSheet {
    _actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除照片", nil] ;
    _actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque ;
    [_actionSheet showInView:self.view] ;
    [_actionSheet setTag:1002] ;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger tag = actionSheet.tag ;
    if (tag == 1001) {
        //getPhoto
        switch (buttonIndex) {
            case 0:{
                [SPUtils pickImageFromCameraAtController:self] ;
                break;
            }
            case 1:{
                [SPUtils pickImageFromPhotoLibraryAtController:self] ;
                break ;
            }
            default:
                break;
        }
    } else {
        switch (buttonIndex) {
            case 0:{
                NSLog(@"删除照片") ;
#warning 还没写
                [self deleteImage] ;
                break;
            }
            default:
                break;
        }
        NSLog(@"buttonIndex = %d",buttonIndex) ;
    }
}

#pragma mark - UIImagePickerDelegate 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    [picker dismissViewControllerAnimated:YES completion:nil] ;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil] ;
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

#pragma mark - other Method

//image是用户选中的图片，step1：上传 step2：回调判断刷新collectionView step3：图片保存到本地。
- (void)saveImage:(UIImage *)image {
    //step 3 ;
    void (^saveImageAtCurrentVcAndRefreshBlock) (UIImage *) = ^(UIImage *savedImage) {
        NSLog(@"开始本地保存") ;
        NSFileManager *fileManger = [NSFileManager defaultManager] ;
        NSError *error ;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) ;
        
        NSString *documentsDirectory = [paths objectAtIndex:0] ;
        NSString *imageFilePath = [documentsDirectory stringByAppendingString:@"test.png"] ;
        NSLog(@"imageFile->>%@",imageFilePath) ;
        
        if ([fileManger fileExistsAtPath:imageFilePath]) {
            [fileManger removeItemAtPath:imageFilePath error:&error] ;
        }
        //缩略图
        UIImage *smallImage = [self thumbnailWithImageWithoutScale:savedImage size:CGSizeMake(104, 104)] ;
        [UIImagePNGRepresentation(smallImage) writeToFile:imageFilePath atomically:YES] ;
        
        NSLog(@"本地保存缩略图完毕") ;
        [self.collectionView reloadData] ;

    } ;
    
    //step 2 ;
    void (^addFileRelationForCurrentUserBlock) (AVFile * , UIImage *) = ^(AVFile *SavedAVFile , UIImage *savedImage) {
        NSLog(@"开始关联AvUser") ;
        spUser *curuser = [spUser currentUser] ;
        NSMutableArray *photoList = [NSMutableArray arrayWithArray:[curuser sP_photoIdList]] ;
        [photoList addObject:SavedAVFile] ;
        [curuser setSP_photoIdList:photoList] ;
        [curuser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"关联保存成功") ;
                saveImageAtCurrentVcAndRefreshBlock(savedImage) ;
            } else {
                NSLog(@"关联保存失败") ;
                [SPUtils alertError:error] ;
            }
        }] ;
    } ;
    
    //step 1 ;
    NSData *imgData = UIImagePNGRepresentation(image) ;
    AVFile *imageFile = [AVFile fileWithName:@"test.png" data:imgData] ;
    [SPUtils showNetworkIndicator] ;
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        if (succeeded) {
            NSLog(@"上传成功") ;
            addFileRelationForCurrentUserBlock(imageFile,image) ;
            
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
    
}

- (void)deleteImage {
    NSLog(@"删除图片") ;
#warning 删除图片
//    NSFileManager *fileManger = [NSFileManager defaultManager] ;
//    NSError *error ;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) ;
//    
//    NSString *documentsDirectory = [paths objectAtIndex:0] ;
//    NSString *imageFilePath = [documentsDirectory stringByAppendingString:@"test.png"] ;
//    NSLog(@"imageFile->>%@",imageFilePath) ;
//    
//    if ([fileManger fileExistsAtPath:imageFilePath]) {
//        [fileManger removeItemAtPath:imageFilePath error:&error] ;
//    }
//
//    
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end

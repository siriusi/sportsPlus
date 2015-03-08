//
//  SettingViewController.m
//  Sportplus
//
//  Created by Forever.H on 14/12/21.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "SettingViewController.h"
#import "accountTableViewCell.h"

#import "spCommon.h"

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
    
    self.hidesBottomBarWhenPushed = YES;
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"  个人账户",@"  隐私",@"  通知", nil];
    cellTitle = [[NSMutableArray alloc] initWithObjects:@"头像设置",@"姓名设置",@"密码设置",@"账号绑定",@"黑名单",@"好友验证",@"声音",@"震动",@"通知显示详情", nil];
    
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
    sectionTitle.frame = CGRectMake(10, 5, 200, 24);
    sectionTitle.font = [UIFont boldSystemFontOfSize:12];
    sectionTitle.textColor = [UIColor colorWithRed:172.0/255 green:172.0/255 blue:172.0/255 alpha:1.0f];
    
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
            {
                cell.img.hidden=NO;
                cell.gotoButton.hidden=NO;
                cell.switchButton.hidden=YES;
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
                NSLog(@"imageFile->>%@",imageFilePath);
                UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];
                
                cell.img.image = selfPhoto;
                [cell.img.layer setCornerRadius:CGRectGetHeight([cell.img bounds]) / 2];
                cell.img.layer.masksToBounds = YES;
            }
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
    return 41;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self showSheet];
    }
    else if(indexPath.section == 0 && indexPath.row == 1) {
        NSLog(@"jump to name") ;
        ChangeNameViewController *nameView = [[ChangeNameViewController alloc] initWithNibName:@"ChangeNameViewController" bundle:nil];
        [self.navigationController pushViewController:nameView animated:true];
    }
    else if(indexPath.section == 0 && indexPath.row == 2) {
        NSLog(@"fuck") ;
    }
}

-(void) showSheet{
    self.actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"从手机相册中选择",nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [self.actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1:
        {
            //[SPUtils pickImageFromPhotoLibraryAtController:self] ;
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
        default:
            break;
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark － UIImagePickerControllerDelegate

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    NSLog(@"已经选择") ;
//    [picker dismissViewControllerAnimated:YES completion:^{
//        UIActivityIndicatorView* indicator=[SPUtils showIndicatorAtView:self.view];
//        UIImage* image=info[UIImagePickerControllerEditedImage];
//        UIImage* rounded=[SPUtils roundImage:image toSize:CGSizeMake(200, 200) radius:20];
//
////        [CDUserService saveAvatar:rounded callback:^(BOOL succeeded, NSError *error) {
////            [indicator stopAnimating];
////            [CDUtils filterError:error callback:^{
////                self.avatarView.image=rounded;
////            }];
////        }];
//    }];
//}
//
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    NSLog(@"取消") ;
//}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
    //self.img.image = selfPhoto;
    [self.settingTable reloadData];
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

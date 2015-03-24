//
//  SPUserService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPUserService.h"
#import "SPUtils.h"

static UIImage* defaultAvatar;

@implementation SPUserService

+(void)findFriendsIsNetworkOnly:(BOOL)networkOnly callback:(AVArrayResultBlock)block{
    AVUser *user=[AVUser currentUser];
    AVRelation *relation=[user relationforKey:@"friends"];
    //    //设置缓存有效期
    //    query.maxCacheAge = 4 * 3600;
    AVQuery *q=[relation query];
    [SPUtils setPolicyOfAVQuery:q isNetwokOnly:networkOnly] ;
    if([q hasCachedResult]){
        NSLog(@"has cached results");
    }else{
        NSLog(@"don't have cache");
    }
    [q findObjectsInBackgroundWithBlock:block];
}

+(void)findFriendsWithCallback:(AVArrayResultBlock)callback{
    AVUser* user=[AVUser currentUser];
    AVQuery* q=[AVRelation reverseQuery:@"_User" relationKey:@"friends" childObject:user];
    [q findObjectsInBackgroundWithBlock:callback];
}

+(NSString*)getPeerIdOfUser:(AVUser*)user{
    return user.objectId;
}

// should exclude friends
+(void)findUsersByPartname:(NSString *)partName withBlock:(AVArrayResultBlock)block{
    AVQuery *q=[AVUser query];
    [q setCachePolicy:kAVCachePolicyNetworkElseCache];
    [q whereKey:@"sP_userName" containsString:partName];
    AVUser *curUser=[AVUser currentUser];
    [q whereKey:@"objectId" notEqualTo:curUser.objectId];
    [q orderByDescending:@"updatedAt"];
    [q findObjectsInBackgroundWithBlock:block];
}

+(void)findUsersByIds:(NSArray*)userIds callback:(AVArrayResultBlock)callback{
    if([userIds count]>0){
        AVQuery *q=[AVUser query];
        [q setCachePolicy:kAVCachePolicyNetworkElseCache];
        [q whereKey:@"objectId" containedIn:userIds];
        [q findObjectsInBackgroundWithBlock:callback];
    }else{
        callback([[NSArray alloc] init],nil);
    }
}

#pragma mark - 头像相关

+(void)displayAvatarOfUser:(AVUser*)user avatarView:(UIImageView*)avatarView{
    UIImage* placeHolder=[UIImage imageNamed:@"head"];
    [avatarView setImage:placeHolder];
    AVFile* avatar=[user objectForKey:@"avatar"];
    if(avatar){
        [avatar getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(error==nil){
                UIImage* image=[UIImage imageWithData:data];
                [avatarView setImage:image];
            }else{
                [SPUtils alertError:error] ;
            }
        }];
    }
}

//获取头像外部借口
+(UIImage*)getAvatarOfUser:(AVUser*)user{
    if(defaultAvatar==nil){
#warning !!!!!!添加默认User_avatar ;
        defaultAvatar=[UIImage imageNamed:@"head"];
    }
    
    UIImage* localAvatar = [SPUserService getAvatarOfUserAtLocal:user] ;
    if ([user objectForKey:@"avatar"] == nil) {
        return defaultAvatar ;
    }
    //不为空
    if (localAvatar != nil) {
        return localAvatar ;
    } else return [SPUserService getAvatarOfUserFromServer:user] ;
}

//服务端获取头像
+(UIImage *)getAvatarOfUserFromServer:(AVUser *)user {
    UIImage* image=defaultAvatar;
    
    AVFile* avatarFile=[user objectForKey:@"avatar"];
    if(avatarFile==nil){
        [SPUtils alert:@"avatar of user is nil"] ;
        
    }else{
        NSError* error;
        NSData* data=[avatarFile getData:&error];
        if(error==nil){
            image=[UIImage imageWithData:data];
            //保存图片到本地。
            [SPUserService saveAvatarAtLocal:image forUser:user] ;
        }else{
            [SPUtils alertError:error];
        }
    }
    return image ;
}

//本地获取头像
+(UIImage *)getAvatarOfUserAtLocal:(AVUser *)user {
    UIImage *avatar ;
    
    NSString *imageFilePath = [SPUserService getUserAvatarFilePathByUser:user] ;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:imageFilePath]) {
        avatar = [UIImage imageWithContentsOfFile:imageFilePath] ;
    }
    return avatar == nil ? nil : avatar ;
}

//上传头像
+(void)saveAvatar:(UIImage*)image callback:(AVBooleanResultBlock)callback{
    NSData* data=UIImagePNGRepresentation(image);
    AVFile* file=[AVFile fileWithData:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [SPUserService saveAvatarAtLocal:image] ;
        if(error){
            callback(succeeded,error);
        }else{
            AVUser* user=[AVUser currentUser];
            [user setObject:file forKey:@"avatar"];
            [user setFetchWhenSave:YES];
            [user saveInBackgroundWithBlock:callback];
        }
    }];
}

//保存当前用户的头像
+(void)saveAvatarAtLocal:(UIImage *)image {
    [SPUserService saveAvatarAtLocal:image forUser:[spUser currentUser]] ;
}

//为user保存头像
+(void)saveAvatarAtLocal:(UIImage *)image forUser:(AVUser *)user{
    NSString *imageFilePath = [SPUserService getUserAvatarFilePathByUser:user] ;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if ([fileManager fileExistsAtPath:imageFilePath]) {
        [fileManager removeItemAtPath:imageFilePath error:&error] ;
    }
    //保存图片
    [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFilePath atomically:YES] ;
}

//生成文件名
+(NSString *)getUserAvatarFileNameByUser:(AVUser *)user {
    NSString *avatarFileName = [[user objectId] stringByAppendingString:@".jpg"] ;
    return avatarFileName ;
}

//生成路径名
+(NSString *)getUserAvatarFilePathByUser:(AVUser *)user {
    NSString *avatarFileName = [SPUserService getUserAvatarFileNameByUser:user] ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:avatarFileName];
    return imageFilePath ;
}

+(void)displayCycleAvatarOfUser:(AVUser *)user avatarView:(UIImageView *)avatarView {
    [SPUserService displayAvatarOfUser:user avatarView:avatarView] ;
    [avatarView.layer setCornerRadius:CGRectGetHeight([avatarView bounds]) / 2.0f] ;
    avatarView.layer.masksToBounds = YES ;
}

@end

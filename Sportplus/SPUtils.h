//
//  SPUtils.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/2/20.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AVOSCloud/AVOSCloud.h>
#import "spCommon.h"
#import <Reachability.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef void (^CDBlock)();
typedef void (^Int64Block)(int64_t num);

@interface SPUtils : NSObject

+(void)alert:(NSString*)msg;
+(NSString*)md5OfString:(NSString*)s;
+(void)alertError:(NSError*)error;

+(UIActivityIndicatorView*)showIndicatorAtView:(UIView*)hookView;

+(void)showNetworkIndicator;

+(void)hideNetworkIndicator;

+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)newSize;

+(UIImage *)roundImage:(UIImage *) image toSize:(CGSize)size radius: (float) radius;

+(void)pickImageFromPhotoLibraryAtController:(UIViewController*)controller;

+(void)filterError:(NSError*)error callback:(CDBlock)callback;
+(void)logError:(NSError*)error callback:(CDBlock)callbak;

+(void)hideNetworkIndicatorAndAlertError:(NSError*)error;

#pragma mark - collection utils
+(NSMutableArray*)setToArray:(NSMutableSet*)set;
+(NSArray*)reverseArray:(NSArray*)originArray;

#pragma mark - view utils
+(void)setCellMarginsZero:(UITableViewCell*)cell;
+(void)setTableViewMarginsZero:(UITableView*)view;
+(void)stopRefreshControl:(UIRefreshControl*)refreshControl;

#pragma mark - AVUtils

+(void)setPolicyOfAVQuery:(AVQuery*)query isNetwokOnly:(BOOL)onlyNetwork;

+(NSString*)uuid;

#pragma mark - async
+(void)runInGlobalQueue:(void (^)())queue;

+(void)runInMainQueue:(void (^)())queue;

+(void)runAfterSecs:(float)secs block:(void (^)())block;


+(void)postNotification:(NSString*)name;
+(void)notifyGroupUpdate;

+ (int)getDurationOfAudioPath:(NSString *)path ;

+ (void)downloadWithUrl:(NSString *)url toPath:(NSString *)path;

+ (BOOL)connected;

@end

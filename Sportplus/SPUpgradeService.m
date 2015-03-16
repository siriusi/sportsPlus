//
//  SPUpgradeService.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/16.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPUpgradeService.h"

#import <AFNetworking/AFNetworking.h>
#define SP_VERSION @"version"

@implementation SPUpgradeService

+(NSString*)currentVersion{
    NSString *versionStr = @"V1.01" ;
//    NSString* versionStr=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return versionStr;
}

+(void)upgradeWithBlock:(SPUpgradeBlock)callback{
    NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
    NSString* version=[defaults objectForKey:SP_VERSION];
    NSString* curVersion=[SPUpgradeService currentVersion];
    BOOL upgrade=[version compare:curVersion options:NSNumericSearch]==NSOrderedAscending;
    callback(upgrade,version,curVersion);
    [defaults setObject:curVersion forKey:SP_VERSION];
}

+(void)findNewVersionWithBlock:(AVBooleanResultBlock)block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"" ;
//    NSString* url=@"http://fir.im/api/v2/app/version/54735a3a50954b4a19005430?token=4X9h0nA3fuWynm5bmTFOZrjmeic27wBLGO12egYB";
    
    [manager GET:url parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dict=(NSDictionary*)responseObject;
        NSString* version=dict[@"versionShort"];
        //version=@"1.2.1";
        NSString* curVersion=[[self class] currentVersion];
        BOOL remoteNew=[curVersion compare:version options:NSNumericSearch]==NSOrderedAscending;
        block(remoteNew,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO,error);
    }];
}

@end

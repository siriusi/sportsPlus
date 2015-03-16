//
//  SPUpgradeService.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/16.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVOSCloud/AVOSCloud.h>

typedef void (^SPUpgradeBlock)(BOOL upgrade,NSString* oldVersion,NSString* newVersion);

@interface SPUpgradeService : NSObject

+(NSString*)currentVersion;

+(void)upgradeWithBlock:(SPUpgradeBlock)callback ;

+(void)findNewVersionWithBlock:(AVBooleanResultBlock)block;

@end

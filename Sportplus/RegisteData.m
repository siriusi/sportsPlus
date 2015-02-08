//
//  RegisteData.m
//  Sportplus
//
//  Created by humao on 14-12-31.
//  Copyright (c) 2014年 JiaZai. All rights reserved.
//

#import "RegisteData.h"

static RegisteData *shareObj = nil ;

@implementation RegisteData{
   // NSDictionary * _info ;
}

+(RegisteData *)shareInstance{
    if (!shareObj) {
        shareObj = [[RegisteData alloc] init] ;
    }
    return shareObj ;
}

//-(NSDictionary *)info {
//    return _info ;
//}

-(instancetype)init{
    self = [super init] ;
    
    if ( self ) {
        self.info = [[NSMutableDictionary alloc] init] ;
    }
    
    return self ;
}

@end

//
//  ChineseString.m
//  Sportplus
//
//  Created by Forever.H on 15/3/15.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChineseString.h"
#import "pinyin.h"

@implementation ChineseString

@synthesize string = _string;
@synthesize pinYin = _pinYin;

- (id)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (void)initChinseseStringWithSPUser:(spUser *)user {
    if (self) {
        self.myUser = user ;
        self.string = [user sP_userName] ;
        [self initPinYinByString] ;
    }
}

- (void)initPinYinByString{
    if (self.string == nil) {
        self.string = @"" ;
    }
    
    if(![self.string isEqualToString:@""]){
        //join the pinYin
        NSString *pinYinResult = [NSString string];
        for(int j = 0;j < self.string.length; j++) {
            NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                             pinyinFirstLetter([self.string characterAtIndex:j])]uppercaseString];
            
            pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
        }
        self.pinYin = pinYinResult;
    } else {
        self.pinYin = @"";
    }
}


@end

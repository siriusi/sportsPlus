//
//  spEmotionUtilis.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/14.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spEmotionUtilis.h"
#import <MessageDisplayKit/XHEmotionManager.h>
#import "Emoji.h"

@implementation spEmotionUtilis

+(NSArray*)getEmotionCodes{
    NSArray* emotionCodes=@[@"\\u1f60a",@"\\u1f60c",@"\\u1f60d",@"\\u1f60f",@"\\u1f61a",@"\\u1f61b",@"\\u1f61c",@"\\u1f61e"
                            ,@"\\u1f62a",@"\\u1f601",@"\\u1f602",@"\\u1f603",@"\\u1f604",@"\\u1f609",@"\\u1f612",@"\\u1f613"
                            ,@"\\u1f614",@"\\u1f616",@"\\u1f618",@"\\u1f620",@"\\u1f621",@"\\u1f622",@"\\u1f621",@"\\u1f622"
                            ,@"\\u1f623",@"\\u1f625",@"\\u1f628",@"\\u1f630",@"\\u1f631",@"\\u1f632",@"\\u1f633",@"\\u1f637"
                            ,@"\\u1f44d",@"\\u1f44e",@"\\u1f44f"];
    return emotionCodes;
}

+(NSArray*)getEmotionManagers{
    NSString* emotionChars=@"😄😃😊☺️😍😘😚😗😜😝😛😳😁😌😒😞😣😢😂😭😪😥😰😅😓😩😫😨😱😠😡😤😖😆😋😷😎😴😵😲😏😬😐";
    NSArray* emotionCodes=[spEmotionUtilis getEmotionCodes];
    NSMutableArray *emotionManagers = [NSMutableArray array];
    for (NSInteger i = 0; i < 1; i ++) {
        XHEmotionManager *emotionManager = [[XHEmotionManager alloc] init];
        emotionManager.emotionName = @"";
        NSMutableArray *emotions = [NSMutableArray array];
        for (NSInteger j = 0; j < [emotionCodes count]; j ++) {
            XHEmotion* xhEmotion=[[XHEmotion alloc] init];
            NSString* emotionCode=[emotionCodes objectAtIndex:j];
            xhEmotion.emotionConverPhoto = [UIImage imageNamed:[emotionCode substringFromIndex:1]] ;
            xhEmotion.emotionPath=emotionCode;
            [emotions addObject:xhEmotion];
        }
        emotionManager.emotions = emotions;
        [emotionManagers addObject:emotionManager];
    }
    return emotionManagers;
}

+(NSString*)convertWithText:(NSString*)text toEmoji:(BOOL)toEmoji{
    NSMutableString* emojiText=[[NSMutableString alloc] initWithString:text];
    NSArray* emotionCodes=[spEmotionUtilis getEmotionCodes];
    for(NSString* emotionCode in emotionCodes){
        NSRange range;
        range.location=0;
        range.length=emojiText.length;
        NSScanner* scanner=[NSScanner scannerWithString:emotionCode];
        unsigned result=0;
        [scanner setScanLocation:2];
        [scanner scanHexInt:&result];
        NSString* emoji=[Emoji emojiWithCode:result];
        if(toEmoji){
            [emojiText replaceOccurrencesOfString:emotionCode withString:emoji options:NSLiteralSearch range:range];
        }else{
            [emojiText replaceOccurrencesOfString:emoji withString:emotionCode options:NSLiteralSearch range:range];
        }
    }
    return emojiText;
}

@end

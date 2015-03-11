//
//  ZR_photoLibraryCollectionViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/10.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ZR_photoLibraryCollectionViewCell.h"

@implementation ZR_photoLibraryCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    NSLog(@"awak from nib") ;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ZR_photoLibraryCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end

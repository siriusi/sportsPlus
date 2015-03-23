//
//  systemInfoTableViewCell.h
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/24.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageDisplayKit/LKBadgeView.h>
#import <MessageDisplayKit/XHBaseTableViewCell.h>

@interface systemInfoTableViewCell : XHBaseTableViewCell

/**
 *  系统消息Label
 */
@property (nonatomic, weak, readonly) LKBadgeView *systemInfoLabel;

- (instancetype)initWithInfo:(NSString *)info reuserIdentifier:(NSString *)cellIdentifier;

- (void)configureCellWithInfo:(NSString *)info ;

+ (CGFloat)calculateCellHeightWithInfo:(NSString *)info ;

@end

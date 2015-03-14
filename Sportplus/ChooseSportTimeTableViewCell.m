//
//  ChooseSportTimeTableViewCell.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChooseSportTimeTableViewCell.h"

@implementation ChooseSportTimeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithDate:(NSDate *)date {
    if ( date == nil ) {
        return ;
    }
    
    NSString *monthAndDayString ;
    NSString *hourAndMonthString ;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:date];
//    long weekNumber = [comps weekday]; //获取星期对应的长整形字符串
    long day=[comps day];//获取日期对应的长整形字符串
//    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    long hour=[comps hour];//获取小时对应的长整形字符串
    long minute=[comps minute];//获取月对应的长整形字符串
//    long second=[comps second];//获取秒对应的长整形字符串
    
    monthAndDayString = [NSString stringWithFormat:@"%ld月%ld日",month,day] ;
    
    if ( minute < 10 ) {
        hourAndMonthString = [NSString stringWithFormat:@"%ld:0%ld",hour,minute] ;
    } else {
        hourAndMonthString = [NSString stringWithFormat:@"%ld:%ld",hour,minute] ;
    }

    
    [self.monthAndDayLabel setText:monthAndDayString] ;
    [self.hourAndMonthLabel setText:hourAndMonthString] ;
}

@end

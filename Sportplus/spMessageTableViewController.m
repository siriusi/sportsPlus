//
//  spMessageTableViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "spMessageTableViewController.h"
#import "spCommon.h"
#import <MessageDisplayKit/XHMessage.h>

@interface spMessageTableViewController () {
    NSString *_VcMessage ;
}

@end

@implementation spMessageTableViewController

- (void)viewDidLoad{
    [super viewDidLoad] ;
    
    self.delegate = self ;
    self.dataSource = self ;
    
    [self.tableView setTag:0] ;
    [self.messageTableView setTag:1] ;
    
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    
//    [self.messages addObject:@"1"] ;
    
//    if (_VcMessage) {
//        [self.navigationItem setTitle:_VcMessage] ;
//    } else {
//        [self.navigationItem setTitle:@"233"] ;
//    }
    
    {
        CGRect rect = self.messageTableView.frame ;
        CGRect newRect = CGRectMake(rect.origin.x, rect.origin.y + 90 , rect.size.width, rect.size.height - 90 ) ;
        [self.messageTableView setFrame:newRect] ;
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSInteger tag = tableView.tag ;
    
    if (tag == 1) {
        //xhmessageTableView
        return [super tableView:tableView numberOfRowsInSection:section] ;
    } else {
        //mytableview
        return 1 ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1 ) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath] ;
    } else {
        
        static NSString *cellID = @"InviteInfoTableViewCellID" ;
        
        InviteInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID] ;
    
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InviteInfoTableViewCell" owner:self options:nil] lastObject];
        }
    
        /*config cell*/{
            cell.delegate = self ;
        
            NSMutableArray *leftUtilityButtons = [NSMutableArray new];
            NSMutableArray *rightUtilityButtons = [NSMutableArray new];
            [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(127, 127, 127) title:@"卧槽"] ;
            [leftUtilityButtons         sw_addUtilityButtonWithColor:RGBCOLOR(0, 0, 0) title:@"testLeft"] ;
            cell.leftUtilityButtons = leftUtilityButtons ;
            cell.rightUtilityButtons = rightUtilityButtons  ;
        }
    
        return cell ;
    }
}

#pragma mark - XHMessageTableViewControllerDataSource

- (id<XHMessageModel>)messageForRowAtIndexPath:(NSIndexPath *)indexPath{
    XHMessage *message = [[XHMessage alloc] initWithText:@"卧槽" sender:@"德玛西亚" timestamp:[NSDate date]] ;
    
    [message setBubbleMessageType:XHBubbleMessageTypeReceiving] ;
    
    return message ;
}

#pragma mark - XHMessageTableViewControllerDelegate

/**
 *  发送文本消息的回调方法
 *
 *  @param text   目标文本字符串
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date{
    if([text length]>0){
//        [sessionManager sendMessageWithObjectId:nil
//                                        content:[CDEmotionUtils convertWithText:text toEmoji:NO]
//                                           type:CDMsgTypeText
//                                       toPeerId:self.chatUser.objectId
//                                          group:self.group];
        [self.messages addObject:text] ;
        [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
    }
}

- (void)getMessage {
    _VcMessage = @"张睿" ;
}

#pragma mark -IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}


@end

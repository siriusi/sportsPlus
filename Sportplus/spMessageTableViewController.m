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
#import "SPSessionManager.h"
#import "spEmotionUtilis.h"
#import "SPCacheService.h"
#import "SPDataBaseService.h"

#import <FMDB/FMDB.h>
#import <MessageDisplayKit/XHMessage.h>

@interface spMessageTableViewController () {
    NSString *_VcMessage ;
    
    SPSessionManager* _sessionManager;
    
    NSMutableDictionary *_loadedData;
    NSMutableArray* _msgs;
    UIImage* defaultAvatar;
    BOOL isLoadingMsg;
}

@property (nonatomic, strong) XHMessageTableViewCell *currentSelectedCell;
@property (nonatomic, strong) NSArray *emotionManagers;

//@property (nonatomic,strong) CDSessionStateView* sessionStateView;
@property (nonatomic,assign) BOOL sessionStateViewVisiable;

@end

@implementation spMessageTableViewController

#pragma mark - life cycle

- (void)initSelf {
    // 配置输入框UI的样式
    //self.allowsSendVoice = NO;
    //       self.allowsSendFace = NO;
    //self.allowsSendMultiMedia = NO;
    isLoadingMsg=NO;
    _loadedData = [[NSMutableDictionary alloc] init];
    _sessionManager=[SPSessionManager sharedInstance];
    defaultAvatar=[UIImage imageNamed:@"head"];
}

- (void)initTitleWithRoomType {
    if(self.type==CDMsgRoomTypeSingle){
        [self.navigationItem setTitle:self.chatUser.sP_userName] ;
        [_sessionManager watchPeerId:self.chatUser.objectId] ;
    }else{
        
    }
}

- (void)initMessageTableViewFrame {
    //移动
    CGRect rect = self.messageTableView.frame ;
    CGRect newRect = CGRectMake(rect.origin.x, rect.origin.y + 90 , rect.size.width, rect.size.height - 90 ) ;
    [self.messageTableView setFrame:newRect] ;
}

- (void)viewDidLoad{
    [super viewDidLoad] ;
    
    self.delegate = self ;
    self.dataSource = self ;
    
    [self.tableView setTag:0] ;
    [self.messageTableView setTag:1] ;
    
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    
    [self initSelf] ;
    //初始化title
    [self initTitleWithRoomType] ;
    //初始化聊天室的位置
    [self initMessageTableViewFrame] ;
    
    // 设置自身用户名
    spUser *currentUser = [spUser currentUser] ;
    self.messageSender = [currentUser sP_userName] ;
    
    // 添加第三方接入数据
//    NSMutableArray *shareMenuItems = [NSMutableArray array];
//    NSArray *plugIcons = @[@"sharemore_pic", @"sharemore_video"];
//    NSArray *plugTitle = @[@"照片", @"拍摄"];
//    for (NSString *plugIcon in plugIcons) {
//        XHShareMenuItem *shareMenuItem = [[XHShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:plugIcon] title:[plugTitle objectAtIndex:[plugIcons indexOfObject:plugIcon]]];
//        [shareMenuItems addObject:shareMenuItem];
//    }
    
    _emotionManagers=[spEmotionUtilis getEmotionManagers];
    self.emotionManagerView.isShowEmotionStoreButton=YES;
    [self.emotionManagerView reloadData];
    
//    self.shareMenuItems = shareMenuItems;
    [self.shareMenuView reloadData];
    
//    _sessionStateView=[[CDSessionStateView alloc] initWithFrame:CGRectMake(0, 64, self.messageTableView.frame.size.width, kCDSessionStateViewHight)];
//    [_sessionStateView setDelegate:self];
//    _sessionStateViewVisiable=NO;
//    [_sessionStateView observeSessionUpdate];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated] ;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter] ;
    [center removeObserver:self name:NOTIFICATION_MESSAGE_UPDATED object:nil] ;
    [center addObserver:self selector:@selector(messageUpdated:) name:NOTIFICATION_MESSAGE_UPDATED object:nil] ;
#warning !! 
//    if(self.type==CDMsgRoomTypeGroup){
//        [center addObserver:self selector:@selector(initWithCurrentChatGroup) name:NOTIFICATION_GROUP_UPDATED object:nil];
//        [self initWithCurrentChatGroup];
//    }
    [SPDataBaseService markHaveReadWithConvid:[self getConvid]];
    [self loadMsgsIsLoadMore:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSInteger tag = tableView.tag ;
    
    if (tag == 1) {
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
            cell.leftUtilityButtons = leftUtilityButtons ;
            cell.rightUtilityButtons = rightUtilityButtons  ;
        }
    
        return cell ;
    }
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = tableView.tag ;
    
    if ( tag == 1) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath] ;
    } else {
        return 90 ;
    }
}

#pragma mark - XHMessageTableViewControllerDataSource

- (id<XHMessageModel>)messageForRowAtIndexPath:(NSIndexPath *)indexPath{
    XHMessage *message = [self.messages objectAtIndex:indexPath.row] ;
    return message ;
}

#pragma mark - XHMessageTableViewControllerDelegate

- (BOOL)shouldLoadMoreMessagesScrollToTop {
    return YES;
}

- (void)loadMoreMessagesScrollTotop {
    NSLog(@"- -") ;
    [self loadMsgsIsLoadMore:YES];
}

/**
 *  发送文本消息的回调方法
 *
 *  @param text   目标文本字符串
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date{
    if([text length]>0){
        [_sessionManager sendMessageWithObjectId:nil
                                        content:[spEmotionUtilis convertWithText:text toEmoji:NO]
                                           type:CDMsgTypeText
                                       toPeerId:self.chatUser.objectId
                                          group:self.group];
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

#pragma mark - MesssageUpdated

-(NSString*)getOtherId{
    if(_type==CDMsgRoomTypeSingle){
        return _chatUser.objectId;
    }else{
        return _chatGroup.objectId;
    }
}

- (void)messageUpdated:(NSNotification *)notification {
    if(isLoadingMsg){
        //for bug: msg status sent table reload is after received
        [SPUtils runAfterSecs:1.0f block:^{
            [self messageUpdated:notification];
        }];
        return;
    }
    spMsg* msg=(spMsg*)notification.object;
    NSString* otherId=[msg getOtherId];
    if(otherId==nil){
        [SPUtils alert:@"other id is null"];
    }
    if([otherId isEqualToString:[self getOtherId]]){
        BOOL found=NO;
        spMsg* foundMsg;
        
        for(spMsg* msgItem in _msgs){
            if([msgItem.objectId isEqualToString:msg.objectId]){
                found=YES;
                foundMsg=msgItem;
                break;
            }
        }
        if(!found){
            [self loadMsgsIsLoadMore:NO];
        }else{
            if(msg.status==CDMsgStatusSendFailed || msg.status==CDMsgStatusSendReceived
               ||msg.status==CDMsgStatusSendSucceed){
                foundMsg.status=msg.status;
                if(msg.type==CDMsgTypeAudio || msg.type==CDMsgTypeImage){
                    if([foundMsg.content isEqualToString:@""]){
                        foundMsg.content=msg.content;
                    }
                }
                if(msg.status==CDMsgStatusSendSucceed){
                    //timestamp changed;
                    [self loadMsgsIsLoadMore:NO];
                }else{
                    NSMutableArray* xhMsgs=[self getXHMessages:_msgs];
                    self.messages=xhMsgs;
                    [self.messageTableView reloadData];
                }
            }else{
                [SPUtils alert:@"receive msg start and no found msg, it's weird"];
            }
        }
    }else{
        
    }
}

-(void)loadMsgsIsLoadMore:(BOOL)isLoadMore{
    if(isLoadingMsg){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self loadMsgsIsLoadMore:isLoadMore];
        });
        NSLog(@"loading msg and return");
        return ;
    }
    isLoadingMsg=YES;
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [SPUtils runInGlobalQueue:^{
        __block NSMutableArray* msgs;
        FMDatabaseQueue* dbQueue=[SPDataBaseService databaseQueue];
        [dbQueue inDatabase:^(FMDatabase *db) {
            int64_t maxTimestamp=(((int64_t)[[NSDate date] timeIntervalSince1970])+10)*1000;
            if(isLoadMore==NO){
                int64_t timestamp=maxTimestamp;
                int limit;
                int count=[self.messages count];
                if(count>ONE_PAGE_SIZE){
                    limit=count;
                }else{
                    limit=ONE_PAGE_SIZE;
                }
                msgs=[self getDBMsgsWithTimestamp:timestamp limit:limit isLoadMore:isLoadMore db:db];
            }else{
                int64_t timestamp;
                if([self.messages count]>0){
                    XHMessage* firstMessage=[self.messages objectAtIndex:0];
                    NSDate* date=firstMessage.timestamp;
                    timestamp=[date timeIntervalSince1970]*1000;
                }else{
                    timestamp=maxTimestamp;
                }
                int limit=ONE_PAGE_SIZE;
                msgs=[self getDBMsgsWithTimestamp:timestamp limit:limit
                                       isLoadMore:isLoadMore db:db];
            }
        }];
        
        [self cacheAndLoadMsgs:msgs isLoadMore:isLoadMore];
    }];
}


- (void)cacheAndLoadMsgs:(NSMutableArray *)msgs isLoadMore:(BOOL)isLoadMore {
    [SPUtils runInMainQueue:^{
        __block NSMutableSet* userIds=[[NSMutableSet alloc] init];
        for(spMsg* msg in msgs){
            [userIds addObject:msg.fromPeerId];
        }
        [SPCacheService cacheUsersWithIds:userIds callback:^(NSArray *objects, NSError *error) {
            if(error){
                [SPUtils alertError:error];
                isLoadingMsg=NO;
            }else{
                [SPUtils runInGlobalQueue:^{
                    for(NSString* userId in userIds){
                        [self cacheAvatarByUserId:userId];
                    }
                    [SPUtils runInMainQueue:^{
                        NSMutableArray *messages= [self getXHMessages:msgs];
                        if(isLoadMore==NO){
                            self.messages=messages;
                            _msgs=msgs;
                            [self.messageTableView reloadData];
                            [self scrollToBottomAnimated:NO];
                            isLoadingMsg=NO;
                        }else{
                            NSMutableArray* newMsgs=[NSMutableArray arrayWithArray:msgs];
                            [newMsgs addObjectsFromArray:_msgs];
                            _msgs=newMsgs;
                            [self insertOldMessages:messages completion:^{
                                isLoadingMsg=NO;
                            }];
                        }
                    }];
                }];
            }
        }];
    }];
}

-(NSMutableArray*)getDBMsgsWithTimestamp:(int64_t)timestamp limit:(int)limit isLoadMore:(BOOL)isLoadMore db:(FMDatabase*)db{
    NSString* convid=[self getConvid];
    NSMutableArray *msgs=[[SPDataBaseService getMsgsWithConvid:convid maxTimestamp:timestamp limit:limit db:db] mutableCopy];
    return msgs;
}


-(NSString*)getConvid{
    return [SPSessionManager getConvidOfRoomType:self.type otherId:self.chatUser.objectId groupId:self.group.groupId];
}

- (NSMutableArray *)getXHMessages:(NSMutableArray *)msgs {
    NSMutableArray* messages=[[NSMutableArray alloc] init];
    for(spMsg* msg in msgs){
        [messages addObject:[self getXHMessageByMsg:msg]];
    }
    return messages;
}

#pragma mark - messageData 

-(void)cacheAvatarByUserId:(NSString*)userId{
    if([_loadedData objectForKey:userId]==nil){
        [_loadedData setObject:defaultAvatar forKey:userId];
        
        AVUser* user=[SPCacheService lookupUser:userId];
        if(user==nil){
            [SPUtils alert:@"can not find the user"];
            return;
        }
#warning !!
//        UIImage* avatar=[SPUserService getAvatarOfUser:user];
        UIImage *avatar = [UIImage imageNamed:@"head"] ;
        [_loadedData setObject:avatar forKey:userId];
    }
}

-(XHMessage*)getXHMessageByMsg:(spMsg*)msg{
    AVUser* fromUser=[SPCacheService lookupUser:msg.fromPeerId];
    AVUser* curUser=[AVUser currentUser];
    XHMessage* xhMessage;

    if(msg.type==CDMsgTypeText){
        xhMessage=[[XHMessage alloc] initWithText:[spEmotionUtilis convertWithText:msg.content toEmoji:YES] sender:fromUser.username timestamp:[msg getTimestampDate]];
    }else if(msg.type==CDMsgTypeAudio){
        NSString* objectId=msg.objectId;
        NSString* path=[SPSessionManager getPathByObjectId:objectId];
        xhMessage=[[XHMessage alloc] initWithVoicePath:path voiceUrl:nil voiceDuration:0 sender:fromUser.username timestamp:[msg getTimestampDate]];
    }else if(msg.type==CDMsgTypeLocation){
        NSArray* parts=[msg.content componentsSeparatedByString:@"&"];
        double latitude=[[parts objectAtIndex:1] doubleValue];
        double longitude=[[parts objectAtIndex:2] doubleValue];
        
        xhMessage=[[XHMessage alloc] initWithLocalPositionPhoto:[UIImage imageNamed:@"Fav_Cell_Loc"] geolocations:[parts objectAtIndex:0] location:[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] sender:fromUser.username timestamp:[msg getTimestampDate]];
    }else if(msg.type==CDMsgTypeImage){
        xhMessage=[[XHMessage alloc] initWithPhoto:[self getImageByMsg:msg] thumbnailUrl:nil originPhotoUrl:nil sender:fromUser.username timestamp:[msg getTimestampDate]];
    }
    xhMessage.avatar = [_loadedData objectForKey:msg.fromPeerId] ;
    xhMessage.avatarUrl = nil ;
    if([curUser.objectId isEqualToString:msg.fromPeerId]){
        xhMessage.bubbleMessageType=XHBubbleMessageTypeSending;
    }else{
        xhMessage.bubbleMessageType=XHBubbleMessageTypeReceiving;
    }
    NSInteger msgStatuses[4]={CDMsgStatusSendStart,CDMsgStatusSendSucceed,CDMsgStatusSendReceived,CDMsgStatusSendFailed};
    NSInteger xhMessageStatuses[4]={XHMessageStatusSending,XHMessageStatusSent,XHMessageStatusReceived,XHMessageStatusFailed};
    
    if(xhMessage.bubbleMessageType==XHBubbleMessageTypeSending){
        XHMessageStatus status=XHMessageStatusReceived;
        int i;
        for(i=0;i<4;i++){
            if(msgStatuses[i]==[msg status]){
                status=xhMessageStatuses[i];
                break;
            }
        }
        xhMessage.status = status ;
        if(msg.roomType==CDMsgRoomTypeGroup){
            if(status==CDMsgStatusSendSucceed){
                xhMessage.status=XHMessageStatusReceived;
            }
        }
    }else{
        xhMessage.status=XHMessageStatusReceived;
    }
    
    return xhMessage;
}

-(UIImage*)getImageByMsg:(spMsg*)msg{
    if(msg.type==CDMsgTypeImage){
        UIImage* image = [_loadedData objectForKey:msg.objectId];
        if (image) {
            return image;
        } else {
            NSString* path=[SPSessionManager getPathByObjectId:msg.objectId];
            NSFileManager* fileMan=[NSFileManager defaultManager];
            //NSLog(@"path=%@",path);
            if([fileMan fileExistsAtPath:path]){
                NSData* data=[fileMan contentsAtPath:path];
                UIImage* image=[UIImage imageWithData:data];
                [_loadedData setObject:image forKey:msg.objectId];
                return image;
            }else{
                NSLog(@"does not exists image file");
            }
        }
    }
    return nil;
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
}


@end

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
#import "systemInfoTableViewCell.h"

#import "SVProgressHUD.h"
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

- (void)dealloc {
    if(self.type==CDMsgRoomTypeSingle){
        [_sessionManager unwatchPeerId:self.chatUser.objectId];
    }else{
        [SPCacheService setCurrentChatGroup:nil] ;
    }
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

- (NSString *)getSystemMessageByRulesForMessageAtIndex:(NSInteger)index {
    NSString *jsonString = ((spMsg *)[_msgs objectAtIndex:index]).content ;
    
    NSDictionary *dic = [[SPSessionManager sharedInstance] getObjWithJsonString:jsonString] ;
    
    NSString *message ;
    
    EngagementStatus status = (EngagementStatus)[[dic objectForKey:@"StatusChangeTo"] integerValue] ;
    
    if (![_currentEngageMent isDataAvailable]) {
        NSLog(@"fuck me") ;
        [_currentEngageMent fetch] ;
    }
    
    if ([[_currentEngageMent fromId].objectId isEqualToString:[spUser currentUser].objectId]) {
        //fromId : A
        
        switch (status) {
            case EngagementStatusReceivedUserHasInputInfo:
                //能改 而且消息是B给A发。
                message = [NSString stringWithFormat:@"%@向你发起邀请",[_chatUser sP_userName]] ;
                break;
            case EngagementStatusCreaterUserHasChangedInfo:
                //不能改 而且消息是A给B发。
                message = [NSString stringWithFormat:@"你向%@发起邀请",[_chatUser sP_userName]] ;
                break ;
            case EngagementStatusDone:
                //消息完成，不能改，邀约达成
                message = @"邀约达成，开始运动吧！" ;
                break ;
            default:
                message = @"未知错误请联系管理员" ;
                break;
        }
        
    } else {
        //toId : B
        switch (status) {
            case EngagementStatusReceivedUserHasInputInfo:
                //不能改 而且消息是B给A发
                message = [NSString stringWithFormat:@"你向%@发起邀请",[_chatUser sP_userName]] ;
                break;
            case EngagementStatusCreaterUserHasChangedInfo:
                //能改 而且消息是A给B发
                message = [NSString stringWithFormat:@"%@向你发起邀请",[_chatUser sP_userName]] ;
                break ;
            case EngagementStatusDone:
                //消息完成，不能改，邀约达成
                message = @"邀约达成，开始运动吧！" ;
                break ;
            default:
                message = @"未知错误请联系管理员" ;
                break;
        }
    }
    
    return message ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1 ) {
        spMsg *msg = [_msgs objectAtIndex:indexPath.row] ;
        if (msg.type != CDMsgTypeWithEngagement) {
            return [super tableView:tableView cellForRowAtIndexPath:indexPath] ;
        } else {
            static NSString *cellIdentifier = @"systemInfoTableViewCellId";
            
            systemInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
            
            if (!cell) {
#warning mark - 修改接口,无用参数info
                cell = [[systemInfoTableViewCell alloc] initWithInfo:@"test" reuserIdentifier:cellIdentifier] ;
            }
            
            NSString * message = [self getSystemMessageByRulesForMessageAtIndex:indexPath.row] ;
            
            [cell configureCellWithInfo:message] ;
            [cell setBackgroundColor:tableView.backgroundColor] ;
            
            return cell ;
        }
    
    } else {
        
        static NSString *cellID = @"InviteInfoTableViewCellID" ;
        
        InviteInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID] ;
    
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InviteInfoTableViewCell" owner:self options:nil] lastObject];
        }
    
        /*config cell*/{
            cell.delegate = self ;
    
            
            
            NSMutableArray *rightUtilityButtons = [NSMutableArray new];
            [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(56, 204, 90) title:@"接受"] ;
            [rightUtilityButtons sw_addUtilityButtonWithColor:RGBCOLOR(248, 45 , 64) title:@"修改"] ;
            [cell setRightUtilityButtons:rightUtilityButtons WithButtonWidth:70] ;
        }
    
        return cell ;
    }
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = tableView.tag ;
    
    if ( tag == 1) {
        
        spMsg *msg = [_msgs objectAtIndex:indexPath.row] ;
        if (msg.type != CDMsgTypeWithEngagement) {
            return [super tableView:tableView heightForRowAtIndexPath:indexPath] ;
        } else {
#warning 无用参数
            return [systemInfoTableViewCell calculateCellHeightWithInfo:@"喔了个大槽"] ;
        }
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

/**
 *  是否显示时间轴Label的回调方法
 *
 *  @param indexPath 目标消息的位置IndexPath
 *
 *  @return 根据indexPath获取消息的Model的对象，从而判断返回YES or NO来控制是否显示时间轴Label
 */
- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        return YES;
    }else{
        XHMessage* msg=[self.messages objectAtIndex:indexPath.row];
        XHMessage* lastMsg=[self.messages objectAtIndex:indexPath.row-1];
        int interval=[msg.timestamp timeIntervalSinceDate:lastMsg.timestamp];
        if(interval>60*3){
            return YES;
        }else{
            return NO;
        }
    }
}
/**
 *  配置Cell的样式或者字体
 *
 *  @param cell      目标Cell
 *  @param indexPath 目标Cell所在位置IndexPath
 */
- (void)configureCell:(XHMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    XHMessage *message = [self.messages objectAtIndex:indexPath.row] ;
    spMsg *msg = [_msgs objectAtIndex:indexPath.row] ;
    
    if (msg.type == CDMsgTypeWithEngagement) {
        NSString *info = [NSString stringWithFormat:@"%@给%@发送一条约伴消息",[[spUser currentUser] sP_userName],[self.chatUser sP_userName]] ;
        [cell.timestampLabel setHeightMode:LKBadgeViewHeightModeLarge] ;
        cell.timestampLabel.text = info ;
    }
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
    //通知的消息
    spMsg* msg=(spMsg*)notification.object;
    NSString* otherId=[msg getOtherId];
    if(otherId==nil){
        [SPUtils alert:@"other id is null"];
    }
    if([otherId isEqualToString:[self getOtherId]]){
        BOOL found=NO;
        spMsg* foundMsg;
        //
        for(spMsg* msgItem in _msgs){
            if([msgItem.objectId isEqualToString:msg.objectId]){
                found=YES;
                foundMsg=msgItem;
                break;
            }
        }
        if(!found){
            //没找到就loadMsg
            [self loadMsgsIsLoadMore:NO];
        }else{
            //找到了消息
            if(msg.status==CDMsgStatusSendFailed || msg.status==CDMsgStatusSendReceived
               ||msg.status==CDMsgStatusSendSucceed){
                //如果消息发送失败||或者消息是发送收到||或者消息是发送成功
                //
                foundMsg.status=msg.status;
                if(msg.type==CDMsgTypeAudio || msg.type==CDMsgTypeImage){
                    if([foundMsg.content isEqualToString:@""]){
                        foundMsg.content=msg.content;
                    }
                }
                if(msg.status==CDMsgStatusSendSucceed){
                    //发送成功
                    //timestamp changed;
                    [self loadMsgsIsLoadMore:NO];
                }else{
                    //发送失败或者发送收到
                    
                    [self beforeMessageTableViewReloadDataWithXHmessageArray:[self getXHMessages:_msgs] andSPmessageArray:_msgs] ;
                    
//                    NSMutableArray* xhMsgs=[self getXHMessages:_msgs];
//                    self.messages=xhMsgs;
                    
//                    [self.messageTableView reloadData];
                }
            }else{
                //消息状态start很奇怪
                [SPUtils alert:@"receive msg start and no found msg, it's weird"];
            }
        }
    }else{
        
    }
}


//读取更多的
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
                //不读取更多
                int64_t timestamp=maxTimestamp;
                int limit;
                int count=[self.messages count];
                if(count>ONE_PAGE_SIZE){
                    limit=count;
                }else{
                    limit=ONE_PAGE_SIZE;
                }
                
                //读取
                msgs=[self getDBMsgsWithTimestamp:timestamp limit:limit isLoadMore:isLoadMore db:db];
            }else{
                //读取更多
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

//缓存和加载Msg
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
                            [self beforeMessageTableViewReloadDataWithXHmessageArray:messages andSPmessageArray:msgs] ;
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

//在DB中获取msg
-(NSMutableArray*)getDBMsgsWithTimestamp:(int64_t)timestamp limit:(int)limit isLoadMore:(BOOL)isLoadMore db:(FMDatabase*)db{
    NSString* convid=[self getConvid];
    NSMutableArray *msgs=[[SPDataBaseService getMsgsWithConvid:convid maxTimestamp:timestamp limit:limit db:db] mutableCopy];
    return msgs;
}

//获取对话Id
-(NSString*)getConvid{
    return [SPSessionManager getConvidOfRoomType:self.type otherId:self.chatUser.objectId groupId:self.group.groupId];
}

//从msg数组获取xhmessage数组
- (NSMutableArray *)getXHMessages:(NSMutableArray *)msgs {
    NSMutableArray* messages=[[NSMutableArray alloc] init];
    for(spMsg* msg in msgs){
        [messages addObject:[self getXHMessageByMsg:msg]];
    }
    [self getCurrentEngagementFromServices] ;
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
    }else if(msg.type==CDMsgTypeWithEngagement){
        
        NSString *jsonString = msg.content ;
        NSLog(@"jsonString = %@",jsonString) ;
        xhMessage = [[XHMessage alloc] initWithText:jsonString sender:fromUser.username timestamp:[msg getTimestampDate]] ;
        
        NSDictionary *dic = [[SPSessionManager sharedInstance] getObjWithJsonString:jsonString] ;
        NSLog(@"obj = %@",dic) ;
        
        _currentEngageMent = [spEngagement_Stranger objectWithoutDataWithObjectId:[dic objectForKey:@"EngagementId"]] ;
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

- (void)acceptStrangerEngagement {
    void (^sendMsgBlock) () = ^() {
        NSLog(@"开发发送") ;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init] ;
        [dic setObject:[_currentEngageMent objectId] forKey:@"EngagementId"] ;
        NSNumber *status = [NSNumber numberWithInteger:[_currentEngageMent status]] ;
        [dic setObject:status forKey:@"StatusChangeTo"] ;
        SPSessionManager *manager = [SPSessionManager sharedInstance] ;
        NSString *content = [manager getJsonStringWithJsonObject:dic] ;
        
        [[SPSessionManager sharedInstance] sendMessageWithObjectId:nil content:content type:CDMsgTypeWithEngagement toPeerId:_chatUser.objectId group:nil] ;
    } ;
    
    _currentEngageMent.status = EngagementStatusDone ;
    [SPUtils showNetworkIndicator] ;
    [SVProgressHUD show] ;
    [_currentEngageMent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        [SVProgressHUD dismiss] ;
        if (succeeded) {
            NSLog(@"保存成功") ;
            sendMsgBlock() ;
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
    
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    if ( index == 0 ) {
        [self acceptStrangerEngagement] ;
        //接受
        //发送，一条msg过去。说接受了
    } else {
        [self performSegueWithIdentifier:@"chatRoomToSendMyInviteInfoVCSegueId" sender:self] ;
        //修改
        //跳转，选好，message_update发送一条message过去
    }
}

#pragma mark - msg数据处理 

- (void)beforeMessageTableViewReloadDataWithXHmessageArray:(NSMutableArray *)XHmsgs andSPmessageArray:(NSMutableArray *)SPmsgs {
    self.messages=XHmsgs;
    _msgs=SPmsgs;
    [self.messageTableView reloadData];
    
}

- (void)getCurrentEngagementFromServices {
#warning 最好食把数据丢进msg的content里，转化出来。以上。不然会请求两次。
    [SPUtils showNetworkIndicator] ;
    [_currentEngageMent fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        [SPUtils hideNetworkIndicator] ;
        if (!error) {
            _currentEngageMent = (spEngagement_Stranger *)object ;
        } else {
            [SPUtils alertError:error] ;
        }
    }] ;
}

@end
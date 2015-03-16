//
//  SPSessionManager.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/11.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "SPSessionManager.h"
#import "spCommon.h"
#import <AFNetworking/AFNetworking.h>
#import "SPDataBaseService.h"
#import "SPCloudSevice.h"
#import <Qiniu/QiniuSDK.h>


@interface SPSessionManager () {
    AVSession *_session ;
    QNUploadManager *upManager;    
}

@end

#define MESSAGES @"messages"

static id instance = nil;
static BOOL initialized = NO;

@implementation SPSessionManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    if (!initialized) {
        [instance commonInit];
    }
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (instancetype)init {
    if ((self = [super init])) {
        upManager=[[QNUploadManager alloc] init];
        _session = [[AVSession alloc] init];
        _session.sessionDelegate = self;
        _session.signatureDelegate = self;
        [AVGroup setDefaultDelegate:self];
        [self commonInit];
    }
    return self;
}

//if type is image ,message is attment.objectId

- (void)commonInit {
    initialized = YES;
}

#pragma mark - session

-(void)openSession{
    [_session openWithPeerId:[AVUser currentUser].objectId];
}

-(void)closeSession{
    [_session close];
}

- (void)clearData {
    [self closeSession];
    initialized = NO;
}

#pragma mark - single chat

- (void)watchPeerId:(NSString *)peerId {
    NSLog(@"unwatch");
    [_session watchPeerIds:@[peerId] callback:^(BOOL succeeded, NSError *error) {
        [SPUtils logError:error callback:^{
            NSLog(@"watch succeed peerId=%@",peerId);
        }];
    }];
}

//取消关注
-(void)unwatchPeerId:(NSString*)peerId{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [_session unwatchPeerIds:@[peerId] callback:^(BOOL succeeded, NSError *error) {
        NSLog(@"unwatch callback");
        [SPUtils logError:error callback:^{
            NSLog(@"unwatch succeed");
        }];
    }];
}

#pragma mark - conversation

//生成一个Id
+(NSString*)convidOfSelfId:(NSString*)myId andOtherId:(NSString*)otherId{
    NSArray *arr=@[myId,otherId];
    NSArray *sortedArr=[arr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableString* result= [[NSMutableString alloc] init];
    for(int i=0;i<sortedArr.count;i++){
        if(i!=0){
            [result appendString:@":"];
        }
        [result appendString:[sortedArr objectAtIndex:i]];
    }
    return [SPUtils md5OfString:result];
}

//如果是单人聊天返回生成的Id ，群组就返回GroupId
+(NSString*)getConvidOfRoomType:(CDMsgRoomType)roomType otherId:(NSString*)otherId groupId:(NSString*)groupId{
    if(roomType==CDMsgRoomTypeSingle){
        NSString* curUserId=[AVUser currentUser].objectId;
        return [SPSessionManager convidOfSelfId:curUserId andOtherId:otherId] ;
    }else{
        return groupId;
    }
}

#pragma mark - send message

-(spMsg*)createMsgWithType:(CDMsgType)type objectId:(NSString*)objectId content:(NSString*)content toPeerId:(NSString*)toPeerId group:(AVGroup*)group{
    spMsg* msg=[[spMsg alloc] init];
    msg.toPeerId=toPeerId;
    int64_t currentTime=[[NSDate date] timeIntervalSince1970]*1000;
    msg.timestamp=currentTime;
    //NSLog(@"%@",[[NSDate dateWithTimeIntervalSince1970:msg.timestamp/1000] description]);
    msg.content=content;
    NSString* curUserId=[AVUser currentUser].objectId;
    msg.fromPeerId=curUserId;
    msg.status=CDMsgStatusSendStart;
    if(!group){
        msg.toPeerId=toPeerId;
        msg.roomType=CDMsgRoomTypeSingle;
    }else{
        msg.roomType=CDMsgRoomTypeGroup;
        msg.toPeerId=@"";
    }
    msg.readStatus=CDMsgReadStatusHaveRead;
    msg.convid=[SPSessionManager getConvidOfRoomType:msg.roomType otherId:msg.toPeerId groupId:group.groupId];
    if(objectId){
        msg.objectId=objectId;
    }else{
        msg.objectId=[SPUtils uuid];
    }
    msg.type=type;
    return msg;
}

-(AVSession*)getSession{
    return _session;
}

-(spMsg*)sendMsg:(spMsg*)msg group:(AVGroup*)group{
    if([_session isOpen]==NO || [_session isPaused]){
        [SPUtils alert:@"会话暂停，请检查网络"] ;
    }
    if(!group){
        AVMessage *avMsg=[AVMessage messageForPeerWithSession:_session toPeerId:msg.toPeerId payload:[msg toMessagePayload]];
        [_session sendMessage:avMsg requestReceipt:YES];
    }else{
        AVMessage *avMsg=[AVMessage messageForGroup:group payload:[msg toMessagePayload]];
        [group sendMessage:avMsg];
    }
    return msg;
}

-(void)uploadFileMsg:(spMsg*)msg block:(AVIdResultBlock)block{
    NSString* path=[SPSessionManager getPathByObjectId:msg.objectId];
    NSMutableString *name;
    name = [self getAVFileName];
    AVFile *f=[AVFile fileWithName:name contentsAtPath:path];
    [f saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            block(nil,error);
        }else{
            block(f,nil);
        }
    }];
}

-(void)convertAudioFile:(AVFile*)file block:(AVIdResultBlock)block{
    NSString* url=[@"https://leancloud.cn/1.1/qiniu/pfop/" stringByAppendingString:file.objectId];
    NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:AVOSAppID forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
    [request setValue:AVOSAppKey forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary* params=@{@"fops":@"avthumb/aac"};
    
    NSData* data=[NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:nil];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse* res=(NSHTTPURLResponse*)response;
        NSDictionary* dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if(connectionError!=nil || [res statusCode]==200){
            [self runTwiceTimeWithTimes:0 avfile:file persistentId:[dict objectForKey:@"persistentId"] callback:block];
        }else{
            block(nil,[[NSError alloc] initWithDomain:[dict description] code:0 userInfo:nil]);
        }
    }];
}

-(void)uploadMsg:(spMsg*)msg block:(AVIdResultBlock)block{
    [self uploadFileMsg:msg block:^(id object, NSError *error) {
        if(error){
            block(nil,error);
        }else{
            AVFile* file=(AVFile*)object;
            if(msg.type==CDMsgTypeImage){
                block(file.url,nil);
            }else if(msg.type==CDMsgTypeAudio){
                [self convertAudioFile:file block:block];
                //block(file.url,nil);
            }
        }
    }];
}

-(void)postUpdatedMsg:(spMsg*)msg{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MESSAGE_UPDATED object:msg userInfo:nil];
}

-(void)postSessionUpdate{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SESSION_UPDATED object:nil userInfo:nil];
}

- (void)sendCreatedMsg:(spMsg *)msg group:(AVGroup*)group{
    if(msg.type==CDMsgTypeAudio || msg.type==CDMsgTypeImage){
        [self uploadMsg:msg block:^(id object, NSError *error) {
            if(error){
                [self setStatusFailedOfMsg:msg];
            }else{
                NSString* url=(NSString*)object;
                msg.content=url;
                [SPDataBaseService updateMsgWithId:msg.objectId content:url] ;
                [self sendMsg:msg group:group];
            }
        }];
    }else{
        [self sendMsg:msg group:group];
    }
}

- (void)sendMessageWithObjectId:(NSString*)objectId content:(NSString *)content type:(CDMsgType)type toPeerId:(NSString *)toPeerId group:(AVGroup*)group{
    spMsg *msg = [self createMsgWithType:type objectId:objectId content:content toPeerId:toPeerId group:group] ;
    [SPDataBaseService insertMsgToDB:msg] ;
    
    [self postUpdatedMsg:msg];
    [self sendCreatedMsg:msg group:group];
}


-(void)resendMsg:(spMsg*)msg toPeerId:(NSString*)toPeerId group:(AVGroup*)group{
    [self sendCreatedMsg:msg group:group];
    NSLog(@"resendMsg");
}

-(void)runTwiceTimeWithTimes:(int)times avfile:(AVFile*)file persistentId:(NSString*)persistentId callback:(AVIdResultBlock)callback{
    NSLog(@"times=%d",times);
    NSError* commonError=[NSError errorWithDomain:@"error" code:0 userInfo:@{NSLocalizedDescriptionKey:@"上传错误"}];
    if(times>=4){
        callback(nil,commonError);
    }else{
        [SPUtils runInGlobalQueue:^{
            sleep(times+1);
            [SPUtils runInMainQueue:^{
                NSString *url=@"http://api.qiniu.com/status/get/prefop";
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                [manager GET:url parameters:@{@"id":persistentId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSDictionary* dict=(NSDictionary*)responseObject;
                    NSArray* arr=[dict objectForKey:@"items"];
                    NSDictionary* result=[arr firstObject];
                    NSString* key=[result objectForKey:@"key"];
                    NSNumber* code=[result objectForKey:@"code"];
                    int codeInt=[code intValue];
                    if(codeInt==0){
                        NSString* finalUrl=[NSString stringWithFormat:@"http://ac-%@.qiniudn.com/%@",file.bucket,key];
                        callback(finalUrl,nil);
                    }else{
                        [self runTwiceTimeWithTimes:times+1 avfile:file persistentId:persistentId callback:callback];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    callback(nil,error);
                }];
            }];
        }];
    }
}

-(void)sendAudioWithId:(NSString*)objectId toPeerId:(NSString*)toPeerId group:(AVGroup*)group callback:(AVBooleanResultBlock)callback{
    NSString* path=[SPSessionManager getPathByObjectId:objectId];
    AVFile* file=[AVFile fileWithName:[self getAVFileName] contentsAtPath:path];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            callback(succeeded,error);
        }else{
            NSString* url=[@"https://leancloud.cn/1.1/qiniu/pfop/" stringByAppendingString:file.objectId];
            NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [request setValue:AVOSAppID forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
            [request setValue:AVOSAppKey forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            NSDictionary* params=@{@"fops":@"avthumb/amr"};
            
            NSData* data=[NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:nil];
            [request setHTTPBody:data];
            [request setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPMethod:@"POST"];
            NSOperationQueue *queue=[[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                NSHTTPURLResponse* res=(NSHTTPURLResponse*)response;
                NSDictionary* dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"%d %@",[res statusCode],dict);
                if(connectionError!=nil || [res statusCode]==200){
                    [self runTwiceTimeWithTimes:0 avfile:file persistentId:[dict objectForKey:@"persistentId"] callback:^(id object, NSError *error) {
                        if(error){
                            callback(NO,error);
                        }else{
                            [self sendMessageWithObjectId:objectId content:(NSString*)object type:CDMsgTypeAudio toPeerId:toPeerId group:group];
                            callback(YES,nil);
                        }
                    }];
                }else{
                    callback(NO,[[NSError alloc] initWithDomain:[dict description] code:0 userInfo:nil]);
                }
            }];
        }
    }];
}

+(NSString*)getFilesPath{
    NSString* appPath=[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* filesPath=[appPath stringByAppendingString:@"/files/"];
    NSFileManager *fileMan=[NSFileManager defaultManager];
    NSError *error;
    BOOL isDir=YES;
    if([fileMan fileExistsAtPath:filesPath isDirectory:&isDir]==NO){
        [fileMan createDirectoryAtPath:filesPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(error){
            [NSException raise:@"error when create dir" format:@"error"];
        }
    }
    return filesPath;
}

+(NSString*)getPathByObjectId:(NSString*)objectId{
    return [[self getFilesPath] stringByAppendingFormat:@"%@",objectId];
}


- (NSMutableString *)getAVFileName {
    AVUser* curUser=[AVUser currentUser];
    double time=[[NSDate date] timeIntervalSince1970];
    NSMutableString *name=[[curUser username] mutableCopy];
    [name appendFormat:@"%f",time];
    return name;
}

#pragma mark - history message

- (void)getHistoryMessagesForPeerId:(NSString *)peerId callback:(AVArrayResultBlock)callback {
    AVHistoryMessageQuery *query = [AVHistoryMessageQuery queryWithFirstPeerId:_session.peerId secondPeerId:peerId];
    [query findInBackgroundWithCallback:callback];
}

- (void)getHistoryMessagesForGroup:(NSString *)groupId callback:(AVArrayResultBlock)callback {
    AVHistoryMessageQuery *query = [AVHistoryMessageQuery queryWithGroupId:groupId];
    [query findInBackgroundWithCallback:callback];
}

#pragma mark - comman message handle

-(void)didMessageSendFinish:(AVMessage*)avMsg group:(AVGroup*)group{
    spMsg* msg=[spMsg fromAVMessage:avMsg];
    msg.status=CDMsgStatusSendSucceed;
    [self setRoomTypeAndConvidOfMsg:msg group:group];
    [SPDataBaseService updateMsgWithId:msg.objectId status:msg.status timestamp:msg.timestamp];
    [self postUpdatedMsg:msg];
}

-(void)setStatusFailedOfMsg:(spMsg*)msg{
    msg.status=CDMsgStatusSendFailed;
    [SPDataBaseService updateMsgWithId:msg.objectId status:CDMsgStatusSendFailed];
    [self postUpdatedMsg:msg];
}

-(void)didMessageSendFailure:(AVMessage*)avMsg group:(AVGroup*)group{
    spMsg* msg=[spMsg fromAVMessage:avMsg];
    [self setRoomTypeAndConvidOfMsg:msg group:group];
    [self setStatusFailedOfMsg:msg];
}

-(void)didMessageArrived:(AVMessage*)avMsg{
    spMsg* msg=[spMsg fromAVMessage:avMsg];
    msg.status=CDMsgStatusSendReceived;
    [self setRoomTypeAndConvidOfMsg:msg group:nil];
    [SPDataBaseService updateMsgWithId:msg.objectId status:CDMsgStatusSendReceived];
    [self postUpdatedMsg:msg];
}

- (void)setRoomTypeAndConvidOfMsg:(spMsg *)msg group:(AVGroup *)group {
    if(group){
        msg.roomType=CDMsgRoomTypeGroup;
        msg.convid=group.groupId;
    }else{
        assert(msg.toPeerId!=nil && msg.fromPeerId!=nil);
        msg.roomType=CDMsgRoomTypeSingle;
        msg.convid=[SPSessionManager convidOfSelfId:msg.toPeerId andOtherId:msg.fromPeerId];
    }
}

-(void)didReceiveAVMessage:(AVMessage*)avMsg group:(AVGroup*)group{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"payload=%@",avMsg.payload);
    spMsg* msg=[spMsg fromAVMessage:avMsg];
    [self setRoomTypeAndConvidOfMsg:msg group:group];
    msg.status=CDMsgStatusSendReceived;
    msg.readStatus=CDMsgReadStatusUnread;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if(msg.type==CDMsgTypeImage || msg.type==CDMsgTypeAudio){
            NSString* path=[SPSessionManager getPathByObjectId:msg.objectId];
            NSFileManager* fileMan=[NSFileManager defaultManager];
            if([fileMan fileExistsAtPath:path]==NO){
                NSString* url=msg.content;
                AVFile* file=[AVFile fileWithURL:url];
                NSData* data=[file getData];
                [data writeToFile:path atomically:YES];
                //[CDUtils downloadWithUrl:url toPath:path];
                int duration=[SPUtils getDurationOfAudioPath:path];
                NSLog(@"du=%d",duration);
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [SPDataBaseService insertMsgToDB:msg];
            [self postUpdatedMsg:msg];
        });
    });
}

#pragma mark - AVSessionDelegate
- (void)sessionOpened:(AVSession *)session {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"session:%@", session.peerId);
    [self postSessionUpdate];
}

- (void)sessionPaused:(AVSession *)session {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"session:%@", session.peerId);
    [self postSessionUpdate];
}

- (void)sessionResumed:(AVSession *)session {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"session:%@", session.peerId);
    [self postSessionUpdate];
}

- (void)session:(AVSession *)session didReceiveMessage:(AVMessage *)message {
    [self didReceiveAVMessage:message group:nil];
}

- (void)session:(AVSession *)session messageSendFailed:(AVMessage *)message error:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"session:%@ message:%@ toPeerId:%@ error:%@", session.peerId, message.payload, message.toPeerId, error);
    [self didMessageSendFailure:message group:nil];
}

- (void)session:(AVSession *)session messageSendFinished:(AVMessage *)message {
    [self didMessageSendFinish:message group:nil];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"session:%@ message:%@ toPeerId:%@", session.peerId, message.payload, message.toPeerId);
}

- (void)session:(AVSession *)session didReceiveStatus:(AVPeerStatus)status peerIds:(NSArray *)peerIds {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"session:%@ peerIds:%@ status:%@", session.peerId, peerIds, status==AVPeerStatusOffline?@"offline":@"online");
}

- (void)sessionFailed:(AVSession *)session error:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"session:%@ error:%@", session.peerId, error);
}

- (void)session:(AVSession *)session messageArrived:(AVMessage *)message{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"%@",message);
    [self didMessageArrived:message];
}


#pragma mark - AVGroupDelegate

- (void)group:(AVGroup *)group didReceiveMessage:(AVMessage *)message {
    [self didReceiveAVMessage:message group:group];
}

- (void)group:(AVGroup *)group didReceiveEvent:(AVGroupEvent)event peerIds:(NSArray *)peerIds {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"group:%@ event:%u peerIds:%@", group.groupId, event, peerIds);
    if(event==AVGroupEventSelfLeft){
        [SPUtils notifyGroupUpdate];
    }
}

- (void)group:(AVGroup *)group messageSendFinished:(AVMessage *)message {
    [self didMessageSendFinish:message group:group];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"group:%@ message:%@", group.groupId, message.payload);
}

- (void)group:(AVGroup *)group messageSendFailed:(AVMessage *)message error:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"group:%@ message:%@ error:%@", group.groupId, message.payload, error);
    [self didMessageSendFailure:message group:group];
}

- (void)session:(AVSession *)session group:(AVGroup *)group messageSent:(NSString *)message success:(BOOL)success {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"group:%@ message:%@ success:%d", group.groupId, message, success);
}

#pragma mark - signature
//
//- (AVSignature *)signatureForPeerWithPeerId:(NSString *)peerId watchedPeerIds:(NSArray *)watchedPeerIds action:(NSString *)action{
//    if(watchedPeerIds==nil){
//        watchedPeerIds=[[NSMutableArray alloc] init];
//    }
//    NSDictionary* result=[SPCloudSevice signWithPeerId:peerId watchedPeerIds:watchedPeerIds];
//    return [self getAVSignatureWithParams:result peerIds:watchedPeerIds];
//}
//
//-(AVSignature*)getAVSignatureWithParams:(NSDictionary*) fields peerIds:(NSArray*)peerIds{
//    AVSignature* avSignature=[[AVSignature alloc] init];
//    NSNumber* timestampNum=[fields objectForKey:@"timestamp"];
//    long timestamp=[timestampNum longValue];
//    NSString* nonce=[fields objectForKey:@"nonce"];
//    NSString* signature=[fields objectForKey:@"signature"];
//
//    [avSignature setTimestamp:timestamp];
//    [avSignature setNonce:nonce];
//    [avSignature setSignature:signature];;
//    [avSignature setSignedPeerIds:[peerIds copy]];
//    return avSignature;
//}
//
//-(AVSignature*)signatureForGroupWithPeerId:(NSString *)peerId groupId:(NSString *)groupId groupPeerIds:(NSArray *)groupPeerIds action:(NSString *)action{
//    NSDictionary* result=[SPCloudSevice groupSignWithPeerId:peerId groupId:groupId groupPeerIds:groupPeerIds action:action];
//    return [self getAVSignatureWithParams:result peerIds:groupPeerIds];
//}



@end
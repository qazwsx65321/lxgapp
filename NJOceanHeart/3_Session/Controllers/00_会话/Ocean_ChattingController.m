//
//  Ocean_ChattingController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ChattingController.h"

#import "Ocean_ContactChoiceController.h"

#import "Ocean_XDConnectRongCloud.h"

#import "Ocean_FriendApplyController.h"

#import "Ocean_ConversationController.h"

#import "Ocean_XDConversationController.h"

#import "Ocean_XDMessage.h"

#import "Ocean_FriendsModel.h"

#import "PFK_NotificationTools.h"

@interface Ocean_ChattingController ()<RCIMReceiveMessageDelegate>

{
    Ocean_FriendsModel *model;
}

@end

@implementation Ocean_ChattingController

-(void)setSelfNav:(UINavigationController *)selfNav{
    _selfNav = selfNav;
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
//                                        @(ConversationType_DISCUSSION),
//                                        @(ConversationType_GROUP)]];
    
    [[RCIM sharedRCIM] registerMessageType:[Ocean_XDMessage class]];
    
    [Ocean_XDMessage messageWithContent:@"aaaaaa"];
    
    self.view.frame = CGRectMake(0, 40, screen_Width, screen_Height - 40 - 49);
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.conversationListTableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
    }
    
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNoti) name:@"AddGroupSuccess" object:nil];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.conversationListTableView reloadData];
    
}

- (void)reloadNoti {
    
    [self.conversationListTableView reloadData];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud]
     JudgeRongCloudConversationWithConversationModel:model
     withUserid:[Ocean_UserInfo sharedOcean_UserInfo].m_uid
     withApplication:^{
         
         
         if ([model.senderUserId isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_uid]) {
             [MBProgressHUD showInfoMessage:@"申请消息已发送!"];
         }else {
             Ocean_FriendApplyController *friendVC = [[Ocean_FriendApplyController alloc] init];
             friendVC.friendid = model.targetId;
             [self.selfNav pushViewController:friendVC animated:YES];
         }
         
        
    } withAccept:^{
    
        if (model.conversationType == ConversationType_GROUP) {
            Ocean_ConversationController *controller = [[Ocean_ConversationController alloc] init];
            controller.conversationType = ConversationType_GROUP;
            controller.targetId = model.targetId;
            controller.title = model.conversationTitle;
            [self.selfNav pushViewController:controller animated:YES];
        }else {
            Ocean_XDConversationController *controller = [[Ocean_XDConversationController alloc] init];
            controller.conversationType = model.conversationType;
            controller.targetId = model.targetId;
            controller.title = model.conversationTitle;
            [self.selfNav pushViewController:controller animated:YES];
        }
        
    } withRefuse:nil withDelete:^{
        [MBProgressHUD showTipMessageInView:@"对方还不是您的好友，请添加好友!"];
    } withConsivation:^{
        
        if (model.conversationType == ConversationType_GROUP) {
            Ocean_ConversationController *controller = [[Ocean_ConversationController alloc] init];
            controller.conversationType = ConversationType_GROUP;
            controller.targetId = model.targetId;
            controller.title = model.conversationTitle;
            [self.selfNav pushViewController:controller animated:YES];
        }else {
            Ocean_XDConversationController *controller = [[Ocean_XDConversationController alloc] init];
            controller.conversationType = model.conversationType;
            controller.targetId = model.targetId;
            controller.title = model.conversationTitle;
            [self.selfNav pushViewController:controller animated:YES];
        }
        
    }];
    
    
}

- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
        
    for (int i = 0; i < dataSource.count; i ++) {
        RCConversationModel *model = dataSource[i];
        
        //筛选请求添加好友的系统消息，用于生成自定义会话类型的cell
        if ([model.lastestMessage isKindOfClass:[RCContactNotificationMessage class]]) {
            RCContactNotificationMessage *not =(RCContactNotificationMessage*)model.lastestMessage;
            NSLog(@"%@",not.message);
            model.conversationTitle =not.message;
            NSArray *arr = [not.extra componentsSeparatedByString:@"&::&"];
            RCUserInfo *rcduserinfo_ = [[RCUserInfo alloc]initWithUserId:model.senderUserId name:arr[1] portrait:arr[0]];
            model.extend = rcduserinfo_;

        }
    }
    
    
    return dataSource;
    
}


- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell

                             atIndexPath:(NSIndexPath *)indexPath {
    
//    if (cell.model) {
//        <#statements#>
//    }
    
    
}


- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell

                   atIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left {
    
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        [self onreviceMessage:message];
    }
    if ([message.content isKindOfClass:[RCContactNotificationMessage class]]) {
        RCContactNotificationMessage *messageContent = (RCContactNotificationMessage *)message.content;
        
      
        
        
        
        if ([ContactNotificationMessage_ContactOperationRequest isEqualToString:messageContent.operation]) {
            //NSLog(@"这是好友申请消息。");
            NSLog(@"--->%@,====>%@",messageContent.message,messageContent.extra);
            
            [self GetFriendsInfoWithFriendsid:messageContent.sourceUserId];
            
//            NSArray *arr = [messageContent.extra componentsSeparatedByString:@"&::&"];
//            
//            RCConversationModel *model = [[RCConversationModel alloc] init];
//            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
//            RCUserInfo *rcduserinfo_ = [[RCUserInfo alloc]initWithUserId:message.senderUserId name:arr[1] portrait:arr[0]];
//            model.extend = rcduserinfo_;
//            model.lastestMessage = messageContent;
//            [self.conversationListDataSource addObject:model];
//            
//            [self.conversationListTableView reloadData];
            
            
        }
    }
    
   
    
 
}


- (void)GetFriendsInfoWithFriendsid:(NSString *)friendsid {
    
    MJWeakSelf;
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_fuid":friendsid
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"GETFRIENDSINFO" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                model = [[Ocean_FriendsModel alloc] init];
                model.m_uid = friendsid;
                model.m_nickname = respInfo[@"m_nickname"];
                model.m_phone = respInfo[@"m_phone"];
                model.m_headpic = respInfo[@"m_headpic"];
                
                J_Insert(model).updateResult;
                
                [weakSelf.conversationListTableView reloadData];
                
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
}


//- (void)addContact
//{
//    Ocean_ContactChoiceController *contactVC = [[Ocean_ContactChoiceController alloc] init];
//    [self.selfNav pushViewController:contactVC animated:YES];
//}


-(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}
-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self  getCurrentWindowVC ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else if ([superVC isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController*)superVC).viewControllers.lastObject;
    }
    return superVC;
}
#pragma mark-消息提示音
/*!
 当App处于后台时，接收到消息并弹出本地通知的回调方法
 
 @param message     接收到的消息
 @param senderName  消息发送者的用户名称
 @return            当返回值为NO时，SDK会弹出默认的本地通知提示；当返回值为YES时，SDK针对此消息不再弹本地通知提示
 
 @discussion 如果您设置了IMKit消息监听之后，当App处于后台，收到消息时弹出本地通知之前，会执行此方法。
 如果App没有实现此方法，SDK会弹出默认的本地通知提示。
 流程：
 SDK接收到消息 -> App处于后台状态 -> 通过用户/群组/群名片信息提供者获取消息的用户/群组/群名片信息
 -> 用户/群组信息为空 -> 不弹出本地通知
 -> 用户/群组信息存在 -> 回调此方法准备弹出本地通知 -> App实现并返回YES        -> SDK不再弹出此消息的本地通知
 -> App未实现此方法或者返回NO -> SDK弹出默认的本地通知提示
 
 
 您可以通过RCIM的disableMessageNotificaiton属性，关闭所有的本地通知(此时不再回调此接口)。
 
 @warning 如果App在后台想使用SDK默认的本地通知提醒，需要实现用户/群组/群名片信息提供者，并返回正确的用户信息或群组信息。
 参考RCIMUserInfoDataSource、RCIMGroupInfoDataSource与RCIMGroupUserInfoDataSource
 */
-(BOOL)onRCIMCustomLocalNotification:(RCMessage*)message
                      withSenderName:(NSString *)senderName{
    
    NSString *objName = message.objectName;
    NSString *Digeststr = @"消息";
    if ([objName isEqualToString:RCLocationMessageTypeIdentifier]) {
        RCLocationMessage *contentmessage = (RCLocationMessage*)message.content;
        Digeststr = [NSString stringWithFormat:@"[位置:%@]",contentmessage.locationName];
    }else if ([objName isEqualToString:RCImageMessageTypeIdentifier]){
        Digeststr = @"[图片]";
    }else if ([objName isEqualToString:RCTextMessageTypeIdentifier]){
        RCTextMessage *contentmessage = (RCTextMessage*)message.content;
        Digeststr = contentmessage.conversationDigest;
    }else if ([objName isEqualToString:RCFileMessageTypeIdentifier]){
        RCFileMessage *fileMessage = (RCFileMessage *)message.content;
        Digeststr = [NSString stringWithFormat:@"[文件]%@",fileMessage.name];
        
    }else if ([objName isEqualToString:RCVoiceMessageTypeIdentifier]){
        Digeststr = @"[语音]";

    }else if ([objName isEqualToString:RCRichContentMessageTypeIdentifier]){
        Digeststr = @"[图文]";
    }
    
    
    [PFK_NotificationTools pushNotification:[NSString stringWithFormat:@"%@:%@",senderName,Digeststr]];
    
    return YES;

}

-(void)onreviceMessage:(RCMessage*)message{

    if ([[self getCurrentUIVC] isKindOfClass:[Ocean_XDConversationController class]]) {
        Ocean_XDConversationController *conrver = (Ocean_XDConversationController*)[self getCurrentUIVC];
        if ([conrver.targetId isEqualToString:message.targetId]) {
                return;
            }
        }
    [XMGAudioTool playSoundWithSoundName:@"hyzxPush.caf"];

}




@end

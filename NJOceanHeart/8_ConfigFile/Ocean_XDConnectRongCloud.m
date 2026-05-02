//
//  Ocean_XDConnectRongCloud.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XDConnectRongCloud.h"
#import <JrmfPacketKit/JrmfPacketManager.h>
#import <JrmfWalletKit/JrmfWalletKit.h>
#import "Ocean_XDConnectRongCloud+Ocean_GetInfo.h"

#define ContactNotificationMessage_ContactOperationDeleteResponse @"OPERATION_DEL"

#import "Ocean_FriendsModel.h"

#import <RongIMKit/RCIM.h>

//20210221 modify
//static NSString *RongCloud_DevKey    = @"k51hidwqk9ocb";  //融云key值(开发环境)，原客户值
static NSString *RongCloud_DevKey    = @"8luwapkv8buil";  //融云key值(开发环境)，原客户值。融云的应用名称：综合电商APP

static NSString *RongCloud_ProKey    = @"8luwapkv8buil";  //融云key值(生产环境)
static NSString *RongCloud_RedPacket = @"XROHRedPacket";  //融云红包 Url Scheme

@interface Ocean_XDConnectRongCloud ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

@end

@implementation Ocean_XDConnectRongCloud

singleton_m(Ocean_XDConnectRongCloud)


#pragma mark ---- 融云通讯
/*!
 * 初始化融云信息
 */
- (void)initRongCloud {
    [[RCIM sharedRCIM] initWithAppKey:RongCloud_ProKey];
}


/*!
 * 连接融云
 */
- (void)connectToRongCloudWithUserName:(NSString *)username
                          withTouXiang:(NSString *)touxiang
                             withToken:(NSString *)token {
    
    //20220416 remark,融云即时通讯sdk的低版本代码注释
//    [[RCIM sharedRCIM] connectWithToken:token
//                                success:^(NSString *userId) {
//        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//
//
//       //存入用户信息
//       RCUserInfo *currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId
//                                                                   name:username
//                                                               portrait:touxiang];
//       [RCIM sharedRCIM].currentUserInfo = currentUserInfo;//告诉SDK当前是哪个用户登录就好了，用户信息是你之前缓存的哦~
//       [[RCIM sharedRCIM]setEnableMessageAttachUserInfo:YES];
//
//
//        [[RCIM sharedRCIM] setUserInfoDataSource:self];
//        [[RCIM sharedRCIM] setGroupInfoDataSource:self];
//
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"登陆的错误码为:%ld", status);
//    } tokenIncorrect:^{
//        //token过期或者不正确。
//        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//        NSLog(@"token错误");
//    }];
    
    
    //20220416 add,升级融云即时通讯sdk版本
    [[RCIM sharedRCIM] connectWithToken:token
      dbOpened:^(RCDBErrorCode code) {
      //消息数据库打开，可以进入到主页面
      }success:^(NSString *userId) {
          //连接成功,可跳转至会话列表页
          NSLog(@"登陆成功。当前登录的用户ID：%@", userId);

         //存入用户信息
         RCUserInfo *currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId
                                                                     name:username
                                                                 portrait:touxiang];
         [RCIM sharedRCIM].currentUserInfo = currentUserInfo;//告诉SDK当前是哪个用户登录就好了，用户信息是你之前缓存的哦~
         [[RCIM sharedRCIM]setEnableMessageAttachUserInfo:YES];
         [[RCIM sharedRCIM] setUserInfoDataSource:self];
         [[RCIM sharedRCIM] setGroupInfoDataSource:self];
      }error:^(RCConnectErrorCode status) {
        if (status == RC_CONN_TOKEN_INCORRECT) {
          //从 APP 服务获取新 token，并重连
          NSLog(@"登陆的错误码为:%ld", status);
        } else {
          //无法连接到 IM 服务器，请根据相应的错误码作出对应处理
          NSLog(@"登陆的错误码为:%ld", status);
        }
      }];
    
}

/*!
 * 断开融云连接
 */
- (void)logoutRongCloudWithReceivePush:(BOOL)isReceivePush {
    
    /*!
     [[RCIM sharedRCIM] disconnect:YES]与[[RCIM sharedRCIM] disconnect]完全一致
     [[RCIM sharedRCIM] disconnect:NO]与[[RCIM sharedRCIM] logout]完全一致
     */
    [[RCIM sharedRCIM] disconnect:isReceivePush];
    
}


/*!
 * 获取用户信息
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    
    RCUserInfo *user = [self getFriendInfo:userId];
    return completion(user);
    
}

/*!
 * 获取群组信息
 */
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion {
    
    RCGroup *group = [self getGroupInfo:groupId];
    return completion(group);
    
}


#pragma mark ---- 融云红包

/*!
 * 初始化红包信息
 */
- (void)initRongCloudRedPacket {
    //设置红包扩展的 Url Scheme
    //extensionModule：红包 SDK 默认值为 JrmfPacketManager 不能修改
    [[RCIM sharedRCIM] setScheme:RongCloud_RedPacket forExtensionModule:@"JrmfPacketManager"];
}

/*!
 * 处理红包函数
 */
- (BOOL)DealRongCloudRedPacketUrlWithOpenUrl:(NSURL *)url {
    
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    return YES;
    
}

/*!
 * 我的钱包
 */
- (void)openRongCloudRedPacket {
    
    if ([[JrmfPacketManager getCurrentVersion] compare:@"2.8.5" options:NSNumericSearch] == NSOrderedDescending
        || [@"2.8.5" isEqualToString:[JrmfPacketManager getCurrentVersion]]) {
        //2.8.5 及更高版本
        //初始化我的钱包界面信息
        JrmfWalletSDK *wallet = [[JrmfWalletSDK alloc] init];
        wallet.themeNavColor = [UIColor colorWithHexString:Navi_Background_Color];
        wallet.themePageColor = [UIColor colorWithHexString:Navi_Background_Color];
//        wallet.NavTitColor  =[UIColor whiteColor];
//        [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor redColor];

        
        //打开我的钱包
        [JrmfWalletSDK openWallet];
        
    }else {
       
        //低于 2.8.5 版本
        //[JrmfPacketManager getEventOpenWallet];
        
    }
    
}



/*!
 * 好友请求的操作(申请、同意、拒绝、删除)
 */
- (void)RongCloudFriendsApplicationWithOption:(FriendRequest)request
                                   withUserid:(NSString *)userid
                                 withFriendid:(NSString *)friendid
                                  withMessage:(NSString *)message
                                  withExtra:(NSString *)extra
                                  withSuccess:(void (^)(void))successBlock
                                    withError:(void (^)(void))errorBlock {
    
    NSString *opration = @"";
    
    RCConversationType type = ConversationType_PRIVATE;
    
    switch (request) {
        case Friend_Apply:
        {
            opration = ContactNotificationMessage_ContactOperationRequest;
            type = ConversationType_PRIVATE;
        }
            break;
        case Friend_Agree:
        {
            opration = ContactNotificationMessage_ContactOperationAcceptResponse;
            type = ConversationType_PRIVATE;
        }
            break;
        case Friend_Refuse:
        {
            opration = ContactNotificationMessage_ContactOperationRejectResponse;
            type = ConversationType_PRIVATE;
        }
            break;
        case Friend_Delete:
        {
            opration = ContactNotificationMessage_ContactOperationDeleteResponse;
            type = ConversationType_PRIVATE;
        }
            break;
            
        default:
            break;
    }
    
    
    
   RCContactNotificationMessage *messageContent = [RCContactNotificationMessage notificationWithOperation:opration
                                               sourceUserId:userid
                                               targetUserId:friendid
                                                    message:message
                                                      extra:extra];
  
    
    [[RCIM sharedRCIM] sendMessage:type
                          targetId:friendid
                           content:messageContent
                       pushContent:message
                          pushData:@""
      success:^(long messageId) {
        
          //NSLog(@"好友申请发送成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successBlock) {
                successBlock();
            }
        });
          
          
    } error:^(RCErrorCode nErrorCode, long messageId) {
        
        //NSLog(@"好友申请发送失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (errorBlock) {
                errorBlock();
            }
        });
        
      
     
    }];
    
    
}

/*!
 * 对会话列表的消息进行监听
 */
- (void)JudgeRongCloudConversationWithConversationModel:(RCConversationModel *)model
                                             withUserid:(NSString *)userid
                                        withApplication:(void (^)(void))applicationBlock
                                             withAccept:(void (^)(void))acceptBlock
                                             withRefuse:(void (^)(void))refuseBlock
                                             withDelete:(void (^)(void))deleteBlock
                                        withConsivation:(void (^)(void))consivationBlock {
    
    if ([model.lastestMessage isKindOfClass:[RCContactNotificationMessage class]]) {
        RCContactNotificationMessage *messageContent = (RCContactNotificationMessage *)model.lastestMessage;
        
        if ([ContactNotificationMessage_ContactOperationRequest isEqualToString:messageContent.operation]) {
            //NSLog(@"这是好友申请消息。");
            
            if (applicationBlock) {
                applicationBlock();
            }
        }else if ([ContactNotificationMessage_ContactOperationAcceptResponse isEqualToString:messageContent.operation]) {
            //NSLog(@"这是同意好友消息。");
            if (acceptBlock) {
                acceptBlock();
            }
        }else if ([ContactNotificationMessage_ContactOperationRejectResponse isEqualToString:messageContent.operation]) {
            //NSLog(@"这是拒绝好友消息。");
            if (refuseBlock) {
                refuseBlock();
            }
        }else if ([ContactNotificationMessage_ContactOperationDeleteResponse isEqualToString:messageContent.operation]) {
            //NSLog(@"这是删除好友消息。");
            if (deleteBlock) {
                deleteBlock();
            }
        }else {
            //NSLog(@"这是普通消息。");
            if (consivationBlock) {
                consivationBlock();
            }
        }
    }else {
        //NSLog(@"这是普通消息。");
        if (consivationBlock) {
            consivationBlock();
        }
    }

    
    
    
}



@end














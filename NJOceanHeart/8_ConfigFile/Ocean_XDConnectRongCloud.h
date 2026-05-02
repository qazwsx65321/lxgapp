//
//  Ocean_XDConnectRongCloud.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * 好友请求
 */
typedef enum : NSUInteger {
    Friend_Apply,  //申请添加好友
    Friend_Agree,  //同意添加好友
    Friend_Refuse, //拒绝添加好友
    Friend_Delete  //删除好友
} FriendRequest;


@interface Ocean_XDConnectRongCloud : NSObject

singleton_h(Ocean_XDConnectRongCloud)

/*!
 * 初始化融云信息
 */
- (void)initRongCloud;

/*!
 * 连接融云
 * username   用户名字
 * touxiang   用户头像
 * token      用户token
 */
- (void)connectToRongCloudWithUserName:(NSString *)username
                          withTouXiang:(NSString *)touxiang
                             withToken:(NSString *)token;

/*!
 * 断开融云连接
 * isReceivePush   YES:断开与融云服务器的连接，但仍然接收远程推送  NO:断开与融云服务器的连接，并不再接收远程推送
 */
- (void)logoutRongCloudWithReceivePush:(BOOL)isReceivePush;

/*!
 * 初始化红包信息
 */
- (void)initRongCloudRedPacket;

/*!
 * 处理红包函数
 * - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
 * - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 * 以上两个方法中调用
 */
- (BOOL)DealRongCloudRedPacketUrlWithOpenUrl:(NSURL *)url;

/*!
 * 我的钱包
 */
- (void)openRongCloudRedPacket;

/*!
 * 好友请求的操作(申请、同意、拒绝、删除)
 * request   操作名
 * userid    当前用户的id
 * friendid  好友的id
 * message   发送的消息
 */
- (void)RongCloudFriendsApplicationWithOption:(FriendRequest)request
                                   withUserid:(NSString *)userid
                                 withFriendid:(NSString *)friendid
                                  withMessage:(NSString *)message
                                    withExtra:(NSString *)extra
                                  withSuccess:(void (^)(void))successBlock
                                    withError:(void (^)(void))errorBlock;


/*!
 * 对会话列表的消息进行监听
 */
- (void)JudgeRongCloudConversationWithConversationModel:(RCConversationModel *)model
                                             withUserid:(NSString *)userid
                                        withApplication:(void (^)(void))applicationBlock
                                             withAccept:(void (^)(void))acceptBlock
                                             withRefuse:(void (^)(void))refuseBlock
                                             withDelete:(void (^)(void))deleteBlock
                                        withConsivation:(void (^)(void))consivationBlock;










@end















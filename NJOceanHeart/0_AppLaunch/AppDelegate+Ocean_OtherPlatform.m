//
//  AppDelegate+Ocean_OtherPlatform.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/26.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "AppDelegate+Ocean_OtherPlatform.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <JPUSHService.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
//20260504 remark
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
#import "Ocean_XDConnectRongCloud.h"
#import "WXApi.h"
#import "Ocean_XDTableObject.h"
//蒲公英
//#import <PgySDK/PgyManager.h>
//#import <PgyUpdate/PgyUpdateManager.h>

@implementation AppDelegate (Ocean_OtherPlatform)



-(void)initBaiDuMap{
    
    BOOL ret =  [[[BMKMapManager alloc]init] start:@"Knc9hrDQZt9c9R13Gtn6el8pfCsuTP4Y" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}



//初始化蒲公英
-(void)initPayer{
//    [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeShake];
//
//    //启动基本SDK
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"01bd6a7342384f75b52885e5ce15fa89"];
//
//    //启动更新检查SDK
//    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"01bd6a7342384f75b52885e5ce15fa89"];
//
//    [[PgyUpdateManager sharedPgyManager] checkUpdate];


}



/**
 * 连接数据库
 */
- (void)ConnectToTableObject {
    if ([Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
        
        [Ocean_XDTableObject CreateTableObj];
        
    }
}


/**
 * 连接融云
 */
- (void)ConnectToRongCloud {
    [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] initRongCloud];
    [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] initRongCloudRedPacket];
    
    if ([Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
        
        [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud]
         connectToRongCloudWithUserName:[Ocean_UserInfo sharedOcean_UserInfo].m_nickname
         withTouXiang:[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang
         withToken:[Ocean_UserInfo sharedOcean_UserInfo].m_token];

    }
    [RCIM sharedRCIM].disableMessageAlertSound = YES;

}

/**
 * 处理融云红包
 */
- (BOOL)DealRongCloudRedPacketWithUrl:(NSURL *)url {
   return [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] DealRongCloudRedPacketUrlWithOpenUrl:url];
}


-(void)sharSDK{
    
    
    
    [ShareSDK   registerActivePlatforms:@[
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 //    20260504 remark
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx7a4f9c89337abc7f"
                                       appSecret:@"299b7d23ae26af80fc5d1a2a84f8932f"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106288364"
                                      appKey:@"sORx2ZgPaRxNvHHJ"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
}


@end

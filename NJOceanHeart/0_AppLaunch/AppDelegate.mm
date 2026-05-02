//
//  AppDelegate.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "AppDelegate.h"
#import "Ocean_TabbarViewController.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "LoginController.h"
#import "Ocean_NavigationController.h"
#import "AppDelegate+Ocean_OtherPlatform.h"
#import "WXRPayTool.h"
#import "Ocean_SessionViewController.h"
#import "ShoppingCartViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "Ocean_AnimationLaunchController.h"

//20260501 modify
//#import <SDWebImageManager.h>
#import "SDWebImageManager.h"

#import "EBForeNotification.h"
#import <JPUSHService.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import "Ocean_OtherPersonLogin.h"
#import <IQKeyboardManager.h>
NSString *appKey = @"e71a54803bbc1d620b0f1c81";
NSString *channel = @"App Store";
BOOL isProduction = NO;
@interface AppDelegate ()<UITabBarControllerDelegate,RCIMConnectionStatusDelegate>

@property (nonatomic, strong)NSMutableArray *tempNotifications;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL ret =  [[[BMKMapManager alloc]init] start:@"Knc9hrDQZt9c9R13Gtn6el8pfCsuTP4Y" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
   
    
    if (_tempNotifications) {
        _tempNotifications = [[NSUserDefaults standardUserDefaults] objectForKey:@"notifications"];
    } else {
        _tempNotifications = [NSMutableArray array];
    }
        
    self.window =  [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    Ocean_AnimationLaunchController *OcenA = [[Ocean_AnimationLaunchController alloc]init];
    self.window.rootViewController = OcenA;
    OcenA.Appde = self;
    [self.window makeKeyAndVisible];
    [[Ocean_UserInfo sharedOcean_UserInfo]initInfoData];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].toolbarTintColor = [UIColor redColor];

    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"授权成功!");
        } else {
            NSLog(@"授权失败!");
        }
    }];
    
    
    //初始化JPush
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:nil];
    
    //连接数据库
    [self ConnectToTableObject];
    
    //连接融云
    [self ConnectToRongCloud];
    
    //初始化分享/第三方登陆
    [self sharSDK];
    
    //初始化百度地图
    [self initBaiDuMap];
    
    //初始化微信
    [WXRPayTool initWXSDK];

   //监听融云
    [RCIM  sharedRCIM].connectionStatusDelegate = self;

    
    //初始化蒲公英
    [self initPayer];
    
    
    return YES;

}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status{
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {

        [Ocean_OtherPersonLogin OtherPersonLogin:self];
        
    }


}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    [WXRPayTool PayCallBackAndStatusFormUrl:url];
    
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{

    [WXRPayTool PayCallBackAndStatusFormUrl:url];

    //融云红包
    return [self DealRongCloudRedPacketWithUrl:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    //融云红包
    return [self DealRongCloudRedPacketWithUrl:url];
    
}





- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    UINavigationController *preVC= (UINavigationController *)viewController;
    UIViewController *childVC = preVC.topViewController;
    if ([childVC isKindOfClass:[Ocean_SessionViewController class]] ||[childVC isKindOfClass:[ShoppingCartViewController class]]) {
        if ([Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
            return YES;
        }else{
            [tabBarController presentViewController:LoginVC animated:YES completion:nil];
            return NO;
        }
        
    }
    NSLog(@"点击了");
    
    return YES;

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    
    
    if (application.applicationState == UIApplicationStateActive) {
        [EBForeNotification handleRemoteNotification:userInfo customSound:@"hyzxPush.caf"];
                if ([@"5" isEqualToString:userInfo[@"type"]]) {
            [self MYCARDS];
            
        }
        }
    
    
    if (_tempNotifications.count) {
        for (NSDictionary *dic in _tempNotifications) {
            if ([dic[@"id"] isEqualToString:userInfo[@"id"]]) {
                return;
            }
        }
    }
    
    
    //保存信息
    [_tempNotifications addObject:userInfo];
    
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_tempNotifications forKey:@"notifications"];
        [userDefaults synchronize];
    
    
    
    
    
    
    completionHandler(UIBackgroundFetchResultNewData);
}
//
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler{

//    UNNotificationContent *content  =notification.request.content;
//    NSDictionary *userInfo = content.userInfo;
//    
//    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:userInfo[@"title"] message:[NSString stringWithFormat:@"%@",userInfo[@"content"]] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
//    [alter show];
//    if ([@"5" isEqualToString:userInfo[@"type"]]) {
//        [self MYCARDS];
//    }
//
//    //保存信息
//    [_tempNotifications addObject:userInfo];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:_tempNotifications forKey:@"notifications"];
//    [userDefaults synchronize];

//}

//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())cxmompletionHandler{

//    UNNotificationContent *content  =response.notification.request.content;
//    NSDictionary *userInfo = content.userInfo;
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
//           }
//    
//    
//    //保存信息
//    [_tempNotifications addObject:userInfo];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:_tempNotifications forKey:@"notifications"];
//    [userDefaults synchronize];
//    
    
//}



#pragma mark - 进入前台，清除右上角图标
-(void)applicationDidEnterBackground:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];

}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    // Required,For systems with less than or equal to iOS6
//    [JPUSHService handleRemoteNotification:userInfo];
//}

-(void)applicationDidBecomeActive:(UIApplication *)application{

    [self MYCARDS];
    
}



-(void)MYCARDS{

    if ([Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
        
        if( [[RCIM  sharedRCIM] getConnectionStatus] ==ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT){
            
            [Ocean_OtherPersonLogin OtherPersonLogin:self];
            
        }
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[Ocean_UserInfo sharedOcean_UserInfo].m_uid,@"m_uid",[Ocean_UserInfo sharedOcean_UserInfo].m_session,@"m_session",nil];
        
        [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"MYCARDS" completion:^(id respInfo, NSError *error) {
            if (!error) {
                if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                    
                    NSString *checkFlag = respInfo[@"m_checkflag"];
                    NSString *m_price = respInfo[@"m_price"];
                    NSString *name = respInfo[@"m_name"];
                    NSString *m_zpic = respInfo[@"m_zpic"];
                    NSString *m_cid = respInfo[@"m_cid"];
                    if (checkFlag) {
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:checkFlag forKey:@"m_checkflag"];
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_price forKey:@"m_cardPrice"];
                        
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_price forKey:@"m_cardPrice"];
                        
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:name forKey:@"m_cardname"];
                        
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_cid forKey:@"m_cardid"];

                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_zpic forKey:@"m_zcardpic"];


                    }else if ([respInfo[@"ERRORCODE"] isEqualToString:@"0003"]){
                        
                    
                    }
                    
                    
                }else{
                }
            }else{
            }
        }];
        

    }
   
    

}





@end

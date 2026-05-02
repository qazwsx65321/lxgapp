//
//  Ocean_OtherPersonLogin.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/25.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_OtherPersonLogin.h"
#import "Ocean_XDConnectRongCloud.h"
#import "Ocean_TabbarViewController.h"
#import <JPUSHService.h>
#import "AppDelegate.h"
@implementation Ocean_OtherPersonLogin

+(void)OtherPersonLogin:(AppDelegate *)appdelegate{

    UIViewController *controller = [self getCurrentUIVC];
    //清理本地数据
    [[Ocean_UserInfo sharedOcean_UserInfo] removeKeyChain];
    [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] logoutRongCloudWithReceivePush:NO];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:0];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",@"OceanTable"]];
    [[JRDBMgr shareInstance] deleteDatabaseWithPath:filePath];
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"异常登录提示" message:@"您的账号已在其他设备登录，请重新登录！" preferredStyle:UIAlertControllerStyleAlert];
    [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Ocean_TabbarViewController *tabbarVC = [[Ocean_TabbarViewController alloc]init];
        tabbarVC.delegate = appdelegate;
        appdelegate.window.rootViewController = tabbarVC;
        
    }]];
    [controller.tabBarController presentViewController:alter animated:YES completion:nil];




}

+(UIViewController *)getCurrentWindowVC
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
+(UIViewController *)getCurrentUIVC
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


@end

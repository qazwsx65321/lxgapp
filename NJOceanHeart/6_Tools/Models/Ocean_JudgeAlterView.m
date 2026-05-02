//
//  Ocean_JudgeAlterView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_JudgeAlterView.h"
#import "Ocean_FinshingInfoController.h"
#import "Ocean_EnterStorePayController.h"
@implementation Ocean_JudgeAlterView

+(BOOL)alterViewFrom:(UIViewController *)vc{

    if (![Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
        //20220406 remark,不需要进入app就弹出登录界面
        //[vc presentViewController:LoginVC animated:YES completion:nil];
        return NO;
    }
    
    
    NSString *checkFlag = [Ocean_UserInfo sharedOcean_UserInfo].m_checkflag;
    
    if ([@"Y" isEqualToString:checkFlag] ) {
        
        return YES;
        
    }else if ([@"N" isEqualToString:checkFlag]){
        
        Ocean_FinshingInfoController *finishVc =  [[Ocean_FinshingInfoController alloc]init];
//        finishVc.classStr = NSStringFromClass([vc class]);
          Ocean_NavigationController *nav =[[Ocean_NavigationController alloc]initWithRootViewController:finishVc];
        [self alterFromVC:vc alterVCtitle:@"提示" alterMessage:@"您申请未通过,请重新申请" activityAction:@"去申请" cancelAction:@"取消" toViewController:nav];
        return NO;
        
    }else if ([@"O"isEqualToString:checkFlag]){
        
        [self alterFromVC:vc alterVCtitle:@"提示" alterMessage:@"申请正在审核" activityAction:nil cancelAction:@"知道了" toViewController:nil];
        return NO;
        
    }else if([@"W"isEqualToString:checkFlag]){
        Ocean_EnterStorePayController *enter  = [[Ocean_EnterStorePayController alloc]init];
        enter.type = 2;
        [self alterFromVC:vc alterVCtitle:@"提示" alterMessage:@"您申请的卡片暂未支付,是否支付" activityAction:@"是的" cancelAction:@"知道了" toViewController:enter];
        return NO;
        
    }else{
        Ocean_FinshingInfoController *finishVc =  [[Ocean_FinshingInfoController alloc]init];
        Ocean_NavigationController *nav =[[Ocean_NavigationController alloc]initWithRootViewController:finishVc];

        [self alterFromVC:vc alterVCtitle:@"提示" alterMessage:@"您还未申请卡片,是否申请?" activityAction:@"是的" cancelAction:@"我再想想" toViewController:nav];
        return NO; 
        
        
    }

    

}
+(void)alterFromVC:(UIViewController *)pre alterVCtitle:(NSString *)VCTitle alterMessage:(NSString *)VCmessage activityAction:(NSString *)message cancelAction:(NSString *)cancelMessage toViewController:(UIViewController *)toVC{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:VCTitle message:VCmessage preferredStyle:UIAlertControllerStyleAlert];
    
    if (message) {
        [alter addAction:[UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([toVC isKindOfClass:[Ocean_NavigationController class]]) {
                [pre presentViewController:toVC animated:YES completion:nil];
            }else if([toVC isKindOfClass:[Ocean_EnterStorePayController class]]){
                Ocean_EnterStorePayController *payvc = (Ocean_EnterStorePayController*)toVC;
                payvc.type = 2;
                Ocean_NavigationController *nav = [[Ocean_NavigationController alloc]initWithRootViewController:payvc];
                [pre presentViewController:nav animated:YES completion:nil];
            }
        }]];
    }
    
    
    [alter addAction:[UIAlertAction actionWithTitle:cancelMessage style:UIAlertActionStyleDefault handler:nil]];
    [pre presentViewController:alter animated:NO completion:nil];
    
    
}


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


@end

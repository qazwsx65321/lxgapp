//
//  XRThreeLoginTool.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/8.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "XRThreeLoginTool.h"

loginStatus loginBlock;

@implementation XRThreeLoginTool

+(void)LoginFrom:(SSDKPlatformType)logintype andCompletion:(loginStatus)comp{
    loginBlock = comp;
    
    NSString *sign = @"";
    
    switch (logintype) {
        case SSDKPlatformTypeWechat:
        {
            sign = @"0";
        }
            break;
            
        default:
            sign = @"1";
            break;
    }
    
    [ShareSDK getUserInfo:logintype
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             [self UserReg_qq_weixin:user.uid andM_sign:sign otherParameter:user];
             
         }
         
         else
         {
             loginBlock(error,nil,nil);
         }
         
     }];
    
}

+(void)UserReg_qq_weixin:(NSString *)m_threeid andM_sign:(NSString *)m_sign otherParameter:(SSDKUser *)user{
    [MBProgressHUD showActivityMessageInWindow:@""];

    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_sign":m_sign,@"m_threeid":m_threeid} methodName:@"UserReg_qq_weixin" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];

            loginBlock(error,respInfo,user);
    }];

}




@end

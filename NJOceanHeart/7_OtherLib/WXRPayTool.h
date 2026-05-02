//
//  WXRPayTool.h
//  OwnerPort
//
//  Created by qiushi on 2017/5/5.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WXRPayToolFinishNotication @"WXRpayFinishAndReloadData"




@interface WXRPayTool : NSObject

//商户APP工程中引入微信lib库和头文件，调用API前，需要先向微信注册您的APPID

+(void)initWXSDK;

+(void)WXRPayToPlatformOderNumber:(NSString *)orderno andOrderPrice:(NSString *)price andPlat:(BOOL)isAliPay;
+(void)PayCallBackAndStatusFormUrl:(NSURL *)url;




@end

//
//  AliPayTools.h
//  AliPayTools
//
//  Created by qiushi on 2016/11/2.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PayCallBack)(NSInteger statusCode);
@interface AliPayTools : NSObject

+(void)payWithAlipaySetOrderID:(NSString *)orderID andPrice:(NSString *)price andKey:(NSString *)privateK andTitleName:(NSString *)titlename andGoodsdescription:(NSString *)goodDescription andPayFinishBlock:(PayCallBack)callback;


/**
 处理钱包或者独立快捷app支付跳回商户app携带的支付结果Url:
 在Appdelegate里的代理方法：-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;
 调用
 */
+ (void)callBackActionWithURL:(NSURL *)url;

@end

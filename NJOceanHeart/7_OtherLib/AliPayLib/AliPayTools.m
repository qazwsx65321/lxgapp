//
//  AliPayTools.m
//  AliPayTools
//
//  Created by qiushi on 2016/11/2.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#define Notify_URL @"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/notify_url.jsp"//回调地址
#define APPID @"2017071807800690"//应用ID
#define appScheme @"XRoceanHeart"//应用注册scheme

#import "AliPayTools.h"
//20260504 remark
//#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"


PayCallBack payBackBlock;

@implementation AliPayTools

+(void)payWithAlipaySetOrderID:(NSString *)orderID andPrice:(NSString *)price andKey:(NSString *)privateK andTitleName:(NSString *)titlename andGoodsdescription:(NSString *)goodDescription andPayFinishBlock:(PayCallBack)callback{
    payBackBlock = callback;

    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = APPID;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    

    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    order.notify_url =  Notify_URL;
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = goodDescription;
    order.biz_content.subject = titlename;
    order.biz_content.out_trade_no = orderID; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = price; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);

    
    [self HAPPY_ALIPAY_SIGN:orderInfo andEncoded:orderInfoEncoded];
    
    
    
}

+ (void)callBackActionWithURL:(NSURL *)url
{
    // 这里是调用支付宝客户端的回调，url就是在appdelelgate里面传过来的
    //20260504 remark
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut2 = %@",resultDic);
//        [self payFinishedWithErrorCode:[resultDic[@"resultStatus"] intValue]];
//    }];
}

+ (void)payFinishedWithErrorCode:(int)code
{
    if (payBackBlock) {
        payBackBlock(code);
    
    }
    
    switch (code) {
        case 9000:
        {
            NSLog(@"支付成功");
            break;
        }
        case 8000:
        {
            NSLog(@"正在处理");
            break;
        }
        case 4000:
        {
            NSLog(@"支付失败");
            break;
        }
        case 6001:
        {
            NSLog(@"支付失败,请重新支付");
            break;
        }
        case 6002:
        {
            NSLog(@"网络故障");
            break;
        }
        default:
        {
            NSLog(@"未知错误");
            break;
        }
    }
}


+ (void)HAPPY_ALIPAY_SIGN:(NSString *)orderInfo andEncoded:(NSString *)Encodedstr{
    
    NSDictionary *dic = @{
                          @"JUDGEMETHOD":@"ALIPAY-SIGN",
                          @"m_content":orderInfo,
                          };
    
    
        [HessianRequest requestWithData:dic completion:^(id respInfo, NSError *error) {
            
            
            if (!error) {
                
                if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                    
                    NSString *signedString = respInfo[@"m_sign"];
                    
                    NSString *newsign = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)signedString, NULL, (CFStringRef)@"!*'();:@&=+ $,./?%#[]", kCFStringEncodingUTF8));

                    
                    // NOTE: 如果加签成功，则继续执行支付
                    if (signedString != nil) {
                        
                        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                                 Encodedstr, newsign];
                        // NOTE: 调用支付结果开始支付
                    
                        
                        //支付结果回调Block，用于wap支付结果回调（非跳转钱包支付）
                        
                        //20260504 remark
//                        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                            NSLog(@"reslut = %@",resultDic);
//                            
//                            NSLog(@"reslut1 = %@",resultDic);
//                            [self payFinishedWithErrorCode:[resultDic[@"resultStatus"] intValue]];
//                        }];
                    }

                    
                    
                }else {

                    
                }
                
            }else {
                
            }
        }];
    
    
}

@end

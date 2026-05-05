//
//  WXRPayTool.m
//  OwnerPort
//
//  Created by qiushi on 2017/5/5.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "WXRPayTool.h"
#import "AliPayTools.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
//#import "payRequsestHandler.h"
@interface WXRWeiXinObjct : NSObject<WXApiDelegate>
singleton_h(WXRWeiXinObjct)



@end


@implementation WXRWeiXinObjct
singleton_m(WXRWeiXinObjct)

- (void)onResp:(BaseResp*)resp
{
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        NSString *strTitle;
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                [[NSNotificationCenter defaultCenter]postNotificationName:WXRPayToolFinishNotication object:nil userInfo:@{@"state":@"OK"}];
                
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付失败！"];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:WXRPayToolFinishNotication object:nil userInfo:@{@"state":@"fail"}];
                
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}





@end


@implementation WXRPayTool

+(void)initWXSDK{

//    20260504 remark
//    [WXApi registerApp:APP_ID];
}

+(void)WXRPayToPlatformOderNumber:(NSString *)orderno andOrderPrice:(NSString *)price andPlat:(BOOL)isAliPay{
    
    
    [MBProgressHUD showActivityMessageInWindow:@"正在提交"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (isAliPay) {
            
            [self zhifubaoPay:orderno andPrice:price];
            
            
        }else{
            NSArray *orderArr = [orderno componentsSeparatedByString:@"&&:&&"];
            [self weixinPay:orderArr[0] andPrice:price andAttach:orderArr[1]];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        
    });
    
   }

+(void)zhifubaoPay:(NSString *)orderNum andPrice:(NSString *)price{
 
    
    NSString *strTitle  = @"支付结果";
    
    [AliPayTools payWithAlipaySetOrderID:orderNum andPrice:price andKey:@"" andTitleName:@"海洋之星" andGoodsdescription:@"海洋之星" andPayFinishBlock:^(NSInteger statusCode) {
        
        NSString * strMsg;
        
        if (statusCode ==9000) {
            strMsg = @"支付成功!";
            [[NSNotificationCenter defaultCenter]postNotificationName:WXRPayToolFinishNotication object:nil userInfo:@{@"state":@"OK"}];

        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:WXRPayToolFinishNotication object:nil userInfo:@{@"state":@"fail"}];
            strMsg = @"支付失败,请重新支付!";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}

+(void)PayCallBackAndStatusFormUrl:(NSURL *)url{
    
    
    if ([url.host isEqualToString:@"safepay"])
    {
        [AliPayTools  callBackActionWithURL:url];

    }
    else if([url.host isEqualToString:@"pay"])
    {
        [WXApi handleOpenURL:url delegate:[WXRWeiXinObjct sharedWXRWeiXinObjct]];
    }


}



+(void)weixinPay:(NSString *)orderNum andPrice:(NSString *)price andAttach:(NSString *)attach{
    

    NSString *m_realprice=[NSString stringWithFormat:@"%.f",[price floatValue] *100];
    
    
    NSString *payNum = [NSString stringWithFormat:@"十号葫芦娃"];
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID order_name:payNum order_price:m_realprice orderno:orderNum attach:attach];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    NSMutableDictionary *dict = [req sendPay_demo];
    
    if(dict != nil){
        NSMutableString *retcode = [dict objectForKey:@"retcode"];
        if (retcode.intValue == 0){
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [dict objectForKey:@"appid"];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            
            //    20260504 remark
            //BOOL isopen =  [WXApi sendReq:req];
            
            
//            BOOL isopen = [WXApi openWXApp];
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        }else{
            [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
        }
    }else{
        [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
    }
    
    
}

//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}




@end

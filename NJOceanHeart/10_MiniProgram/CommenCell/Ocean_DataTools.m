//
//  Ocean_DataTools.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DataTools.h"

#import "Ocean_DataModel.h"

static NSString *appcode = @"6836046a4aa249cbbabe44db0c38bc8d";

@implementation Ocean_DataTools

/*!
 * 火车查询
 */
+ (void)GetTrainLineWithStart:(NSString *)start withEnd:(NSString *)end withIshigh:(NSString *)ishigh withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    start = [start stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    end = [end stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *host = @"http://jisutrain.market.alicloudapi.com";
    NSString *path = @"/train/station2s";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?end=%@&ishigh=%@&start=%@",end,ishigh,start];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       Ocean_TrainHead *model = [Ocean_TrainHead mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                       
                                                       
                                                       
                                                       
                                                   }];
    
    [task resume];
    
}



/*!
 * 驾驶证扣分查询
 */
+ (void)GetDrivePointWithLicenseid:(NSString *)licenseid withLicensenumber:(NSString *)licensenumber withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    NSString *host = @"http://jisujszkf.market.alicloudapi.com";
    NSString *path = @"/driverlicense/query";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?licenseid=%@&licensenumber=%@",licenseid,licensenumber];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       
                                                       Ocean_DriveModel *model = [Ocean_DriveModel mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                       
                                                       
                                                   }];
    
    [task resume];
}

/*!
 * 身份证实名认证
 */
+ (void)GetIDCardWithIDCard:(NSString *)idcard withRealName:(NSString *)realname withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    realname = [realname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *host = @"http://jisusfzsm.market.alicloudapi.com";
    NSString *path = @"/idcardverify/verify";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?idcard=%@&realname=%@",idcard,realname];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       Ocean_IdcardModel *model = [Ocean_IdcardModel mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                   }];
    
    [task resume];
    
}


/*!
 * 新华字典查询
 */
+ (void)GetXinHuaDictionaryWithKeyWord:(NSString *)keyword withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    keyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *host = @"http://jisuzidian.market.alicloudapi.com";
    NSString *path = @"/zidian/word";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?word=%@",keyword];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       Ocean_XinhuaModel *model = [Ocean_XinhuaModel mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                       
                                                       
                                                       
                                                   }];
    
    [task resume];
}


/*!
 * 新闻头条
 */
+ (void)GetNewsWithType:(NSString *)type withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    NSString *host = @"http://toutiao-ali.juheapi.com";
    NSString *path = @"/toutiao/index";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?type=%@",type];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       
                                                       Ocean_NewsHead *head = [Ocean_NewsHead mj_objectWithKeyValues:body];
                                                       Ocean_NewsModel *model = [Ocean_NewsModel mj_objectWithKeyValues:head.result];
                                                       
                                                       if (!model.data.count) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           
                                                           if (completion) {
                                                               completion(model.data);
                                                           }
                                                       }
                                                       
                                                       
                                                       
                                                   }];
    
    [task resume];
    
}

/*!
 * 失信人查询
 */
+ (void)GetShiXinWithRealName:(NSString *)realname withIdCard:(NSString *)idcard withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    realname = [realname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *host = @"http://shixin.market.alicloudapi.com";
    NSString *path = @"/creditblacklist/query";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?idcard=%@&realname=%@",idcard,realname];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       Ocean_ShiXinHead *head = [Ocean_ShiXinHead mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:head.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       } else{
                                                           Ocean_ShiXinModel *model = [Ocean_ShiXinModel mj_objectWithKeyValues:head.result];
                                                           if (completion) {
                                                               completion(model.list);
                                                           }
                                                       }
                                                       
                                                       
                                                       
                                                   }];
    
    [task resume];
    
}


/*!
 * 智能问答
 */
+ (void)GetZhiNengAnswerWithQuestion:(NSString *)question withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    question = [question stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *host = @"http://jisuznwd.market.alicloudapi.com";
    NSString *path = @"/iqa/query";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?question=%@",question];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       Ocean_ZhiNengModel *model = [Ocean_ZhiNengModel mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                       
                                                   }];
    
    [task resume];
    
}


/*!
 * 周公解梦
 */
+ (void)GetZhouGongJieMengWithKeyWord:(NSString *)keyword withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    keyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *host = @"http://jisudream.market.alicloudapi.com";
    NSString *path = @"/dream/search";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?keyword=%@",keyword];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       Ocean_JieMengHead *model = [Ocean_JieMengHead mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                       
                                                   }];
    
    [task resume];
    
}


/*!
 * 全国物流快递
 */
+ (void)GetAllCityWuLiuWithNumOrder:(NSString *)numOrder withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    
    NSString *host = @"http://jisukdcx.market.alicloudapi.com";
    NSString *path = @"/express/query";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?number=%@&type=auto",numOrder];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       
                                                       Ocean_WuLiuHead *head = [Ocean_WuLiuHead mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:head.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           
                                                           Ocean_WuLiuModel *model = [Ocean_WuLiuModel mj_objectWithKeyValues:head.result];
                                                           if (completion) {
                                                               completion(model.list);
                                                           }
                                                       }
                                                       
                                                   }];
    
    [task resume];
    
}


/*!
 * IP地址查询
 */
+ (void)GetIPAddressWithIPNum:(NSString *)IPnum withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    NSString *host = @"http://jisuip.market.alicloudapi.com";
    NSString *path = @"/ip/location";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?ip=%@",IPnum];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       Ocean_IPModel *model = [Ocean_IPModel mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                       
                                                   }];
    
    [task resume];
    
}


/*!
 * 手机号归属地查询
 */
+ (void)GetPhoneAddressWithPhoneNum:(NSString *)phonenum withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock {
    
    NSString *host = @"http://jshmgsdmfb.market.alicloudapi.com";
    NSString *path = @"/shouji/query";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?shouji=%@",phonenum];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       Ocean_PhoneAddressModel *model = [Ocean_PhoneAddressModel mj_objectWithKeyValues:body];
                                                       
                                                       if (![@"0" isEqualToString:model.status]) {
                                                           if (errorBlock) {
                                                               errorBlock();
                                                           }
                                                       }else {
                                                           if (completion) {
                                                               completion(model.result);
                                                           }
                                                       }
                                                       
                                                   }];
    
    [task resume];
    
}



@end

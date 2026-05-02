//
//  HttpRequestTools.m
//  cloudSnatch
//
//  Created by qiushi on 2016/11/14.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import "HttpRequestTools.h"

@implementation HttpRequestTools

+(void)requestUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(Completion)comp{
    NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
    if (postData)[postdic setDictionary: postData];
    [postdic setObject:JUDGEMETHOD forKey:@"JUDGEMETHOD"];
    [postdic setObject:[Ocean_UserInfo sharedOcean_UserInfo].m_uid?[Ocean_UserInfo sharedOcean_UserInfo].m_uid:@"" forKey:@"m_uid"];
    [postdic setObject:[Ocean_UserInfo sharedOcean_UserInfo].m_session?[Ocean_UserInfo sharedOcean_UserInfo].m_session:@"" forKey:@"m_session"];
    [self RequestData:postdic completion:comp];
    
    
}



+(void)requestUNUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(Completion)comp{
    NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
    if (postData)[postdic setDictionary:postData];
    [postdic setObject:JUDGEMETHOD forKey:@"JUDGEMETHOD"];
    [self RequestData:postdic completion:comp];
}

+(void)requestSynUNUInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(Completion)comp{
    
    NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
    if (postData)[postdic setDictionary:postData];
    [postdic setObject:JUDGEMETHOD forKey:@"JUDGEMETHOD"];
    [HessianRequest syncrequestWithData:postdic completion:comp];
}

+(void)RequestData:(NSDictionary *)dic completion:(Completion)comp{
    
    [HessianRequest requestWithData:dic completion:comp];
}
+(void)requestCommomserInfoWithData:(NSDictionary *)postData requestUrl:(NSString *)reqPath  andRqtype:(NSString *)type  completion:(Completion)comp{
    type = [type uppercaseString];
    NSString *urlStr = [reqPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                                    @"Content-Type"  : @"application/json",
                                                   @"Authorization":@" APPCODE 6836046a4aa249cbbabe44db0c38bc8d"
                                                   };
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    if ([@"POST" isEqualToString:type] && postData !=nil) {
        request.HTTPBody = [[self dictionaryToJson:postData] dataUsingEncoding:NSUTF8StringEncoding];
    }
    request.HTTPMethod = type;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                comp(nil,error);
            });
        }else{
            
            NSError *jsonerror;
            NSDictionary *responseData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonerror];
            if (jsonerror || data ==nil) {
                error = jsonerror;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                comp(responseData,error);
                
            });
        }
    }];
    
    // 3.开启网络任务.
    [task resume];
    
    
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
    
}





@end

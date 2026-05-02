//
//  HessianRequestIos14.m
//
//  Created by zhangxiaole on 2020/10/31.
//  Copyright © 2020 NanJing. All rights reserved.
//  解决ios14的问题增加的文件
//

#import <Foundation/Foundation.h>
#import "HessianRequestIos14.h"

@implementation HessianRequestIos14

+ (void)syncrequestWithURL:(NSString *)url reqData:(NSDictionary *)data completion:(xrCompletionBlock)comp {
    [self requestWithURL:url reqData:data completion:comp];
}

+ (void)requestWithURL:(NSString *)url reqData:(NSDictionary *)data completion:(xrCompletionBlock)comp {
    id<ServiceDelegate> rpc = (id<ServiceDelegate>)[CWHessianConnection proxyWithURL:[NSURL URLWithString:url] protocol:@protocol(ServiceDelegate)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        id result = [rpc invokeService:data];
        
        NSError *error;
        if ([result isKindOfClass:[NSException class]]) {
            NSException *ex = (NSException *)result;
            error = [NSError errorWithDomain:@"Exception" code:1005 userInfo:@{@"description":ex.description}];
        }
        if ([result isKindOfClass:[NSError class]]) {
            error = result;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            comp(result,error);
        });
    });
}

@end


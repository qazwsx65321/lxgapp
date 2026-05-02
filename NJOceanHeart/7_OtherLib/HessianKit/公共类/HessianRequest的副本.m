//
//  HessianRequest.m
//  HessianDemo
//
//  Created by 史伟文 on 15/10/13.
//  Copyright (c) 2015年 cczu. All rights reserved.
//
//#define ServerUrl   [NSURL URLWithString:@"http://show.xuanrui68.com/XuanR_YiRenNet_Server/YiRenNetServer"]

#import "HessianRequest.h"

@implementation HessianRequest

+(void)requestWithData:(NSDictionary *)postData completion:(Completion)comp
{
    
    
    id<Service> rpc = (id<Service>)[CWHessianConnection proxyWithURL:[NSURL URLWithString:ServerUrl] protocol:@protocol(Service)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        id result = [rpc invokeService:postData];
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

+(void)syncrequestWithData:(NSDictionary *)postData completion:(Completion)comp{
    
    id<Service> rpc = (id<Service>)[CWHessianConnection proxyWithURL:[NSURL URLWithString:ServerUrl] protocol:@protocol(Service)];
    id result = [rpc invokeService:postData];
    NSError *error;
    if ([result isKindOfClass:[NSException class]]) {
        NSException *ex = (NSException *)result;
        error = [NSError errorWithDomain:@"Exception" code:1005 userInfo:@{@"description":ex.description}];
    }
    
    if ([result isKindOfClass:[NSError class]]) {
        error = result;
    }
    comp(result,error);
    
}



@end

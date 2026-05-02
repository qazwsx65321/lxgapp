//
//  HttpRequestTools.h
//  cloudSnatch
//
//  Created by qiushi on 2016/11/14.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HessianRequest.h"
@interface HttpRequestTools : NSObject
/**
 需登陆参数接口
 */
+(void)requestUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(Completion)comp;
/**
 无需登陆接口
 */
+(void)requestUNUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(Completion)comp;

/**
 同步接口
 */
+(void)requestSynUNUInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(Completion)comp;

/**
 普通的http请求
 */
+(void)requestCommomserInfoWithData:(NSDictionary *)postData requestUrl:(NSString *)reqPath  andRqtype:(NSString *)type  completion:(Completion)comp;
@end

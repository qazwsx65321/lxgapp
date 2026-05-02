//
//  HessianRequest.h
//  BeautifyCommerce
//
//  20201031，解决ios14的hessian数据接口问题
//  该文件所在目录下面有原来的老文件，对照解决其他老工程的hession数据接口ios14问题
//

#import <Foundation/Foundation.h>
#import "HessianRequestIos14.h"

//20210218，解决ios14问题
//typedef void (^Completion)(id respInfo);
typedef void (^Completion)(id respInfo ,NSError *error);

typedef void (^Error)(void);

@interface HessianRequest : NSObject
{
    Completion completion;
    Error error;
}

/**
 需登陆参数接口。该接口暂未使用
 */
+(void)requestUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(xrCompletionBlock)comp;
///**
// 无需登陆接口。该接口暂未使用
// */
+(void)requestUNUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(xrCompletionBlock)comp;
//
///**
// 同步接口。该接口暂未使用
// */
+(void)requestSynUNUInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(xrCompletionBlock)comp;


- (void)requestRetData:(id)data completion:(Completion)comp error:(Error)err;
//20210218 add，解决ios14问题增加的接口
+(void)requestWithData:(NSDictionary *)data  completion:(Completion)comp;
+(void)syncrequestWithData:(NSDictionary *)data  completion:(Completion)comp;


@end




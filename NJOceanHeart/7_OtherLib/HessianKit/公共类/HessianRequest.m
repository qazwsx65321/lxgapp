//
//  HessianRequest.m
//  BeautifyCommerce
//
//  20201031，解决ios14的hessian数据接口问题
//  该文件所在目录下面有原来的老文件，对照解决其他老工程的hession数据接口ios14问题
//

#import "HessianRequest.h"

@implementation HessianRequest

+(void)requestUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(xrCompletionBlock)comp{
        
    //此处代码处理方法，和接着下面的代码方法相同，兼容原来的业务流程代码不变化
    NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
    if (postData)[postdic setDictionary:postData];
    [postdic setObject:JUDGEMETHOD forKey:@"JUDGEMETHOD"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [postdic setObject:app_Version forKey:@"version"];
    
    [self RequestData:postdic completion:comp];
    
}

+(void)requestUNUserInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(xrCompletionBlock)comp{
    NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
    if (postData)[postdic setDictionary:postData];
    [postdic setObject:JUDGEMETHOD forKey:@"JUDGEMETHOD"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [postdic setObject:app_Version forKey:@"version"];
    
    [self RequestData:postdic completion:comp];
}

+(void)requestSynUNUInfoWithData:(NSDictionary *)postData methodName:(NSString *)JUDGEMETHOD completion:(xrCompletionBlock)comp{
    
    NSMutableDictionary *postdic = [NSMutableDictionary dictionary];
    if (postData)[postdic setDictionary:postData];
    [postdic setObject:JUDGEMETHOD forKey:@"JUDGEMETHOD"];
    [HessianRequestIos14 syncrequestWithURL:ServerUrl reqData:postdic completion:comp];
}

+(void)RequestData:(NSDictionary *)dic completion:(xrCompletionBlock)comp{
    [HessianRequestIos14 requestWithURL:ServerUrl reqData:dic completion:^(id respInfo, NSError *error) {
        comp(respInfo,error);
    }];
    
}

//20201031,解决ios14问题。用下面的方法代替
/*
+ (void)requestWithData:(NSDictionary *)data completion:(Completion)comp error:(Error)err
{
    NSDictionary * postData =data;
    NSString * JUDGEMETHOD = [data valueForKey:@"JUDGEMETHOD"];

    [self requestSynUNUInfoWithData:postData methodName:JUDGEMETHOD completion:^(id respInfo, NSError *error){
        [[self alloc] requestRetData:respInfo completion:comp error:err];
    }];
}
+ (void)syncrequestWithData:(NSDictionary *)data completion:(Completion)comp error:(Error)err{
    [self requestWithData:data completion:comp error:err];
}
*/
//20210217 add，解决ios14问题，******************begin
+ (void)requestWithData:(NSDictionary *)data completion:(Completion)comp
{
    NSDictionary * postData =data;
    NSString * JUDGEMETHOD = [data valueForKey:@"JUDGEMETHOD"];
    
    [self requestSynUNUInfoWithData:postData methodName:JUDGEMETHOD completion:^(id respInfo, NSError *error){
        //20210218 modify
        //[[self alloc] requestRetData:respInfo completion:comp error:err];
        [[self alloc] requestRetData:respInfo completion:comp];
    }];
}
+ (void)syncrequestWithData:(NSDictionary *)data completion:(Completion)comp
{
    [self requestWithData:data completion:comp];
}
//20210217 add，解决ios14问题，******************end


/*20210217 modify,解决ios14问题。用下面的方法代替
- (void)requestRetData:(id)data completion:(Completion)comp error:(Error)err
{
    completion = comp;
    error = err;
    id result = data;
    if (result) {
        completion(result);
    } else
    {
        error();
    }
}
*/
- (void)requestRetData:(id)data completion:(Completion)comp
{
    completion = comp;
    NSError *error;
    id result = data;
    if (result) {
        completion(result,error);
    } else
    {
        //error();   //临时处理方法
        ;
    }
}


@end



//
//  HessianRequestIos14.h
//  HessianDemo
//  解决ios14的问题增加的文件
//

#import <Foundation/Foundation.h>
//#import "CWHessianConnection.h"

#import "HessianKit.h"

typedef void (^xrCompletionBlock)(id respInfo, NSError *error);

@protocol ServiceDelegate <NSObject>
- (id)invokeService:(id)params;
@end

@interface HessianRequestIos14 : NSObject
+ (void)syncrequestWithURL:(NSString *)url reqData:(NSDictionary *)data completion:(xrCompletionBlock)comp;
+ (void)requestWithURL:(NSString *)url reqData:(NSDictionary *)data completion:(xrCompletionBlock)comp;

@end


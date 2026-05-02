//
//  HessianRequest.h
//  HessianDemo
//
//  Created by 史伟文 on 15/10/13.
//  Copyright (c) 2015年 cczu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HessianKit.h"

typedef void (^Completion)(id respInfo ,NSError *error);

@protocol Service <NSObject>
- (id)invokeService:(id)params;
@end

@interface HessianRequest : NSObject

+(void)requestWithData:(NSDictionary *)postData  completion:(Completion)comp;
+(void)syncrequestWithData:(NSDictionary *)postData  completion:(Completion)comp;


@end

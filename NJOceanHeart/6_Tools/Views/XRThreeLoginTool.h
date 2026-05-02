//
//  XRThreeLoginTool.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/8.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>


typedef void(^loginStatus)(NSError *error,NSDictionary * respinfo,SSDKUser *user);

@interface XRThreeLoginTool : NSObject

+(void)LoginFrom:(SSDKPlatformType)logintype andCompletion:(loginStatus)comp;

@end

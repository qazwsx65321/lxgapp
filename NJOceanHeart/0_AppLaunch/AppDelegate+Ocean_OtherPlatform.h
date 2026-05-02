//
//  AppDelegate+Ocean_OtherPlatform.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/26.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Ocean_OtherPlatform)

/**
 * 连接数据库
 */
- (void)ConnectToTableObject;

/**
 * 连接融云
 */
- (void)ConnectToRongCloud;

/**
 * 处理融云红包
 */
- (BOOL)DealRongCloudRedPacketWithUrl:(NSURL *)url;
//分享与第三方登陆
-(void)sharSDK;
//百度地图
-(void)initBaiDuMap;
//初始化蒲公英
-(void)initPayer;



@end

//
//  Ocean_DataTools.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_DataTools : NSObject

/*!
 * 火车查询
 */
+ (void)GetTrainLineWithStart:(NSString *)start withEnd:(NSString *)end withIshigh:(NSString *)ishigh withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 驾驶证扣分查询
 */
+ (void)GetDrivePointWithLicenseid:(NSString *)licenseid withLicensenumber:(NSString *)licensenumber withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 身份证实名认证
 */
+ (void)GetIDCardWithIDCard:(NSString *)idcard withRealName:(NSString *)realname withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 新华字典查询
 */
+ (void)GetXinHuaDictionaryWithKeyWord:(NSString *)keyword withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 新闻头条
 */
+ (void)GetNewsWithType:(NSString *)type withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 失信人查询
 */
+ (void)GetShiXinWithRealName:(NSString *)realname withIdCard:(NSString *)idcard withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 智能问答
 */
+ (void)GetZhiNengAnswerWithQuestion:(NSString *)question withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 周公解梦
 */
+ (void)GetZhouGongJieMengWithKeyWord:(NSString *)keyword withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 全国物流快递
 */
+ (void)GetAllCityWuLiuWithNumOrder:(NSString *)numOrder withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * IP地址查询
 */
+ (void)GetIPAddressWithIPNum:(NSString *)IPnum withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

/*!
 * 手机号归属地查询
 */
+ (void)GetPhoneAddressWithPhoneNum:(NSString *)phonenum withBlock:(void(^)(id data))completion withError:(void(^)(void))errorBlock;

@end

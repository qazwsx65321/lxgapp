//
//  KX9RechargeOrderTool.h
//  Glad9TM
//
//  Created by qiushi on 2017/7/14.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KX9RechargeOrderTool : NSObject

+(NSString *)getRechargeorder:(NSString *)userID andType:(NSString *)type;
@end

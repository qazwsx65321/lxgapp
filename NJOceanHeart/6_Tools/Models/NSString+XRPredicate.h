//
//  NSString+XRPredicate.h
//  OwnerPort
//
//  Created by qiushi on 2017/5/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XRPredicate)

#pragma 正则匹配用户密码6-16位数字和字母的组合

- (BOOL)checkPassword;

#pragma 正则匹配充值金额为非零的正整数

- (BOOL)checkMoneyValue;

#pragma 正则匹配Email

- (BOOL)checkEmail;

#pragma 正则匹配手机号

- (BOOL)checkPhoneNo;

#pragma 正则匹配用户身份证号15或18位

- (BOOL)checkIDCard;

#pragma 正则匹配URL

- (BOOL)checkURL;


#pragma 正则匹配护照号
- (BOOL)checkPassportCard;

/**
 
 * 验证台胞证号，只能输入数字，共8个字符
 
 */

- (BOOL)checkTaiWanPassportNumber;

/**
 
 * 验证港澳通行证号，只能输入"W加8位数字"或"C加8位数字"，共9个字符
 
 */

- (BOOL)checkGangAoPassportNumber;

@end

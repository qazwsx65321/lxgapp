//
//  NSString+XRPredicate.m
//  OwnerPort
//
//  Created by qiushi on 2017/5/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "NSString+XRPredicate.h"

@implementation NSString (XRPredicate)

-(BOOL)checkPassword

{
    
    NSString* pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [predicate evaluateWithObject:self];
    
    return isMatch;
    
}

- (BOOL)checkMoneyValue
{
    
    NSString* pattern =@"^[1-9][0-9]*$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [predicate evaluateWithObject:self];
    
    return isMatch;
    
}

- (BOOL)checkEmail

{
    
    NSString* pattern =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [predicate evaluateWithObject:self];
    
    return isMatch;
    
}

- (BOOL)checkPhoneNo

{
    
    NSString* pattern =@"^1[345678]\\d{9}$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [predicate evaluateWithObject:self];
    
    return isMatch;
    
}

- (BOOL)checkIDCard

{
    
    NSString* pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [predicate evaluateWithObject:self];
    
    return isMatch;
    
}

- (BOOL)checkURL

{
    
    NSString* pattern =@"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [predicate evaluateWithObject:self];
    
    return isMatch;
    
}



/**
 
 * 验证护照号，只能输入"G加8位数字"或"E加8位数字"，共9个字符
 
 */

-(BOOL)checkPassportCard{
    
    NSString *regex = @"^[EG]\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject: self]) {
        
        return NO;
        
    }
    
    return YES;
    
    
    
}

/**
 
 * 验证港澳通行证号，只能输入"W加8位数字"或"C加8位数字"，共9个字符
 
 */

- (BOOL)checkGangAoPassportNumber{
    
    NSString *regex = @"^[CW]\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject: self]) {
        
        return NO;
        
    }
    
    return YES;
    
}





/**
 
 * 验证台胞证号，只能输入数字，共8个字符
 
 */

- (BOOL)checkTaiWanPassportNumber{
    
    NSString *regex = @"^\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject: self]) {
        
        return NO;
        
    }
    
    return YES;
    
}



    
    
    



@end

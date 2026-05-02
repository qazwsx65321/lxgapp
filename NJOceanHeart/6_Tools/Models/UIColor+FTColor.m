//
//  UIColor+FTColor.m
//  X16.QiHu
//
//  Created by 史伟文 on 16/9/18.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import "UIColor+FTColor.h"

@implementation UIColor (FTColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)randomColor
{
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)searchBarBackgroundColor {
    return [UIColor colorWithRed:222 / 255.f green:222 / 255.f blue:222 / 255.f alpha:1];
}

+ (UIColor *)lightlightGrayColor {
    return [UIColor colorWithRed:244 / 255.f green:244 / 255.f blue:244 / 255.f alpha:1];
}

+ (UIColor *)detailInfoColor {
    return [UIColor colorWithRed:253 / 255.f green:218 / 255.f blue:209 / 255.f alpha:1];
}

+ (UIColor *)buttonGreenColor
{
    return [UIColor colorWithRed:22 / 255.f green:204 / 255.f blue:200 / 255.f alpha:1];
}

+ (UIColor *)buttonOrangeColor
{
    return [UIColor colorWithRed:241 / 255.f green:145 / 255.f blue:73 / 255.f alpha:1];
}

+ (UIColor *)buttonBlueColor
{
    return [UIColor colorWithRed:39 / 255.f green:191 / 255.f blue:241 / 255.f alpha:1];
}

+ (UIColor *)placeholderColor
{
    return [UIColor colorWithRed:199 / 255.f green:199 / 255.f blue:205 / 255.f alpha:1];
}

+ (UIColor *)defaultGrayColor
{
    return [UIColor colorWithRed:209 / 255.f green:213 / 255.f blue:219 / 255.f alpha:1];
}

+ (UIColor *)lightPurpleColor
{
    return [UIColor colorWithRed:190 / 255.f green:180 / 255.f blue:242 / 255.f alpha:1];
}

@end

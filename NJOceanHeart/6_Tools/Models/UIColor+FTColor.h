//
//  UIColor+FTColor.h
//  X16.QiHu
//
//  Created by 史伟文 on 16/9/18.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FTColor)

#pragma 十六进制颜色
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

#pragma 功能块颜色
+ (UIColor *)randomColor;
+ (UIColor *)searchBarBackgroundColor;
+ (UIColor *)lightlightGrayColor;
+ (UIColor *)lightPurpleColor;
+ (UIColor *)detailInfoColor;
+ (UIColor *)buttonGreenColor;
+ (UIColor *)buttonOrangeColor;
+ (UIColor *)buttonBlueColor;
+ (UIColor *)placeholderColor;
+ (UIColor *)defaultGrayColor;

@end

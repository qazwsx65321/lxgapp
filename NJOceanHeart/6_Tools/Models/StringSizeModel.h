//
//  StringSizeModel.h
//  WisdomLake
//
//  Created by 史伟文 on 15/10/25.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StringSizeModel : NSObject

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW withLineSpace:(CGFloat)lineSpace;

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;

+ (CGSize)sizeWithAttributeText:(NSAttributedString *)attributeText maxW:(CGFloat)maxW;


+ (CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font andMaxSize:(CGSize)size;

@end

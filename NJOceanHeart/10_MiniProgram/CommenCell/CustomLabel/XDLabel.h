//
//  XDLabel.h
//  OwnerPort
//
//  Created by 陈志伟 on 17/3/30.
//  Copyright © 2017年 NanJing. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LINESPACE       = 1 << 0,        /** 行间距 **/
    WORDSPACE       = 1 << 1,        /** 字间距 **/
    PARAgRAPHSPACE  = 1 << 2,        /** 段落间距 **/
    INDENTSPACE     = 1 << 3,        /** 首行缩进 **/
    HEAdINDENTSPACE = 1 << 4,        /** 整体缩进，首行除外 **/
    
} XDLabelAttribute;



@interface XDLabel : UILabel

@property (nonatomic,assign) float XD_lineSpace;         /** 行间距 **/
@property (nonatomic,assign) float XD_wordSpace;         /** 字间距 **/
@property (nonatomic,assign) float XD_paragraphSpace;    /** 段落间距 **/
@property (nonatomic,assign) float XD_indentSpace;       /** 首行缩进值 **/
@property (nonatomic,assign) float XD_headIndentSpace;   /** 整体缩进值 **/



/**
 写入label属性
 
 @param type label属性类型，使用多个可用“|”分割
 */
- (void)XD_setAttributeWithType:(XDLabelAttribute)type;


/**
 设置label部分字的颜色

 @param color 颜色值
 @param colorText 字符串
 */
- (void)XD_setAttributeWithColor:(UIColor *)color withText:(NSString *)colorText;


/**
 设置label部分字加下划线

 @param lineText 字符串
 */
- (void)XD_setAttributeWithBottomLineText:(NSString *)lineText;


/**
 设置label部分字加中划线
 
 @param lineText 字符串
 */
- (void)XD_setAttributeWithMidlineText:(NSString *)lineText;

@end

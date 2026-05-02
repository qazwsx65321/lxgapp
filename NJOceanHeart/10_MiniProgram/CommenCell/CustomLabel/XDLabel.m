//
//  XDLabel.m
//  OwnerPort
//
//  Created by 陈志伟 on 17/3/30.
//  Copyright © 2017年 NanJing. All rights reserved.
//


/*
 
           ┌─┐       ┌─┐
        ┌──┘ ┴───────┘ ┴──┐
        │                 │
        │       ───       │
        │  ─┬┘       └┬─  │
        │                 │
        │       ─┴─       │
        │                 │
        └───┐         ┌───┘
            │         │
            │         │
            │         │
            │         └──────────────┐
            │                        │
            │                        ├─┐
            │                        ┌─┘
            │                        │
            └─┐  ┐  ┌───────┬──┐  ┌──┘
              │ ─┤ ─┤       │ ─┤ ─┤
              └──┴──┘       └──┴──┘
                     神兽保佑
                     永无BUG!
 */

#import "XDLabel.h"

static NSMutableAttributedString *spaceAttributedString;
static NSMutableParagraphStyle *paragraphStyle;

static NSMutableAttributedString *colorAttributedString;
static NSMutableAttributedString *lineAttributedString;

@implementation XDLabel

- (void)XD_setAttributeWithType:(XDLabelAttribute)type  {
    
    spaceAttributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    if (type & LINESPACE) {
        
        [self XD_ChangeLineSpaceWithSpace:_XD_lineSpace];
        
    }
    
    if (type & WORDSPACE) {
        
        [self XD_ChangeWordSpaceWithSpace:_XD_wordSpace];
        
    }
    
    if (type & PARAgRAPHSPACE) {
        
        [self XD_ChangeParagraphSpaceWithSpace:_XD_paragraphSpace];
        
    }
    
    if (type & INDENTSPACE) {
        
        [self XD_ChangeIndentWithIndent:_XD_indentSpace];
        
    }
    
    if (type & HEAdINDENTSPACE) {
        
        [self XD_ChangeHeadIndentSpaceWithSpace:_XD_headIndentSpace];
        
    }
    
    [spaceAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = spaceAttributedString;
    [self sizeToFit];
    
}

/**
 * 设置间距值
 */
- (void)setXD_lineSpace:(float)XD_lineSpace {
    _XD_lineSpace = XD_lineSpace;
}

- (void)setXD_wordSpace:(float)XD_wordSpace {
    _XD_wordSpace = XD_wordSpace;
}

- (void)setXD_paragraphSpace:(float)XD_paragraphSpace {
    _XD_paragraphSpace = XD_paragraphSpace;
}

- (void)setXD_indentSpace:(float)XD_indentSpace {
    _XD_indentSpace = XD_indentSpace;
}

- (void)setXD_headIndentSpace:(float)XD_headIndentSpace {
    _XD_headIndentSpace = XD_headIndentSpace;
}


/**
 设置行间距
 
 @param space 间距值
 */
- (void)XD_ChangeLineSpaceWithSpace:(float)space {
    
    [paragraphStyle setLineSpacing:space];
    
}


/**
 设置字间距
 
 @param space 间距值
 */
- (void)XD_ChangeWordSpaceWithSpace:(float)space {
    [paragraphStyle setLineSpacing:space];
    [spaceAttributedString addAttribute:NSKernAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
}

/**
 设置段落间距
 
 @param space 间距值
 */
- (void)XD_ChangeParagraphSpaceWithSpace:(float)space {
    [paragraphStyle setParagraphSpacing:space];
}

/**
 设置首行缩进
 
 @param indent 缩进值
 */
- (void)XD_ChangeIndentWithIndent:(float)indent {
    
    paragraphStyle.alignment = NSTextAlignmentLeft;  //对齐
    paragraphStyle.headIndent = 0.0f;//行首缩进
    CGFloat emptylen = self.font.pointSize * indent ;
    paragraphStyle.firstLineHeadIndent = emptylen;//首行缩进
    paragraphStyle.tailIndent = 0.0f;//行尾缩进
    
}

/**
 设置整体缩进（首行除外）
 
 @param space 间距值
 */
- (void)XD_ChangeHeadIndentSpaceWithSpace:(float)space {
    [paragraphStyle setHeadIndent:space];
}



/**
 设置label部分字的颜色
 
 @param color 颜色值
 @param colorText 字符串
 */
- (void)XD_setAttributeWithColor:(UIColor *)color withText:(NSString *)colorText {
    
    colorAttributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSRange redRange = NSMakeRange([[colorAttributedString string] rangeOfString:colorText].location, [[colorAttributedString string] rangeOfString:colorText].length);
    [colorAttributedString addAttribute:NSForegroundColorAttributeName value:color range:redRange];
    [self sizeToFit];
    
}


/**
 设置label部分字加下划线
 
 @param lineText 字符串
 */
- (void)XD_setAttributeWithBottomLineText:(NSString *)lineText {
    
    lineAttributedString = [[NSMutableAttributedString alloc] initWithString:lineText];
    NSRange contentRange = {0,[lineAttributedString length]};
    [lineAttributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [self sizeToFit];
}


/**
 设置label部分字加中划线
 
 @param lineText 字符串
 */
- (void)XD_setAttributeWithMidlineText:(NSString *)lineText {
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    lineAttributedString = [[NSMutableAttributedString alloc] initWithString:lineText attributes:attribtDic];
    [self sizeToFit];
    
}



@end

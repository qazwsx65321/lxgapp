//
//  XDTextView.m
//  WorkerPort
//
//  Created by 陈志伟 on 17/2/15.
//  Copyright © 2017年 NanJing. All rights reserved.
//


/*
                              _ooOoo_
                             o8888888o
                             88" . "88
                             (| -_- |)
                             O\  =  /O
                          ____/`---'\____
                        .'  \\|     |//  `.
                       /  \\|||  :  |||//  \
                      /  _||||| -:- |||||-  \
                      |   | \\\  -  /// |   |
                      | \_|  ''\---/''  |   |
                      \  .-\__  `-`  ___/-. /
                    ___`. .'  /--.--\  `. . __
                 ."" '<  `.___\_<|>_/___.'  >'"".
                | | :  `- \`.;`\ _ /`;.`/ - ` : | |
                \  \ `-.   \_ __\ /__ _/   .-` /  /
           ======`-.____`-.___\_____/___.-`____.-'======
                              `=---='
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        佛祖保佑       永无BUG
 */


#import "XDTextView.h"

@interface XDTextView ()<UITextViewDelegate>

@property (nonatomic,strong) UITextView *label;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation XDTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setControls];
    }
    return self;
}


/**
 创建控件
 */
-(void)setControls{
    
    self.label = [[UITextView alloc]init];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor lightGrayColor];
    self.label.editable = NO;
    [self addSubview:self.label];
    
    self.textView = [[UITextView alloc]init];
    
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor lightGrayColor];
    self.textView.delegate = self;
    [self addSubview:self.textView];
    
}



/**
 设置字体颜色

 @param XD_textColor 字体颜色
 */
- (void)setXD_textColor:(UIColor *)XD_textColor{
    _XD_textColor = XD_textColor;
    _textView.textColor = _XD_textColor;
}



/**
 设置占位字符的颜色

 @param XD_placehodelColor 占位字的颜色
 */
- (void)setXD_placehodelColor:(UIColor *)XD_placehodelColor{
    _XD_placehodelColor = XD_placehodelColor;
    _label.textColor = _XD_placehodelColor;
}



/**
 设置占位字

 @param XD_placehodel 占位字
 */
- (void)setXD_placehodel:(NSString *)XD_placehodel{
    _XD_placehodel = XD_placehodel;
    
    _label.text = _XD_placehodel;
    
}


/**
 输入文字

 @param XD_text 输入的文字
 */
-(void)setXD_text:(NSString *)XD_text{
    _XD_text = XD_text;
    
    _textView.text = _XD_text;
    
    if (_textView.text.length > 0) {
        _label.hidden = YES;
    }else{
        _label.hidden = NO;
    }
}

/**
 设置字体

 @param XD_font 字体大小
 */
-(void)setXD_font:(UIFont *)XD_font{
    _XD_font = XD_font;
    
    _label.font = _XD_font;
    _textView.font = _XD_font;
}

/**
 textView代理：开始编辑的时候将占位字隐藏

 @param textView textView代理
 */
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.label.hidden = YES;
    }else{
        self.label.hidden = NO;
    }
    _XD_text = textView.text;
    
    if ([self.delegate respondsToSelector:@selector(didChangeXDText:)]) {
        [self.delegate didChangeXDText:self];
    }
    
    
}


/**
 设置文字是否置顶

 @param XD_isTop 文字是否置顶
 */
- (void)setXD_isTop:(BOOL)XD_isTop {
    _XD_isTop = XD_isTop;
    if (XD_isTop) {
        self.label.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}


/**
 设置代理

 @param textView  输入框  (return键方法)
 @return  YES : NO  返回值
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    /**
     实现代理，该代理为按下键盘return键之后需要做的事件
     */
    if ([self.delegate respondsToSelector:@selector(didKeyBoardReturn:)]) {
            //在这里做你响应return键的代码
        self.XD_text = textView.text;
            [self.delegate didKeyBoardReturn:self];
        }
    return YES;
}


//坐标
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.textView.frame = CGRectMake(0, 0, self.width, self.height);
}


@end

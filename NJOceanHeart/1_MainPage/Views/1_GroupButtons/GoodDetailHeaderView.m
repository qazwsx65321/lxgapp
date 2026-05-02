//
//  GoodDetailHeaderView.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodDetailHeaderView.h"

@interface GoodDetailHeaderView()

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIButton *lastButton;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, strong)UIView *button1line;
@property (nonatomic, strong)UIButton *button2;
@property (nonatomic, strong)UIView *button2line;

@end

@implementation GoodDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.tag = 91;
        [_button1 setTitle:@"商品详情" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor colorWithHexString:Navi_Background_Color] forState:UIControlStateSelected];
        _button1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_button1];
        
        _button1line = [[UIView alloc] init];
        _button1line.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
        [_backView addSubview:_button1line];
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.tag = 92;
        [_button2 setTitle:@"商品评论" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor colorWithHexString:Navi_Background_Color] forState:UIControlStateSelected];
        _button2.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_button2];
        
        _button2line = [[UIView alloc] init];
        _button2line.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
        [_backView addSubview:_button2line];
        _button2line.hidden = YES;
        
        _lastButton = _button1;
        [self buttonClick:_button1];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backView.width = self.width;
    _backView.height = self.height ;
    _backView.x = 0;
    _backView.y = 0;
    
    _button1.width = self.width / 2.f;
    _button1.height = self.height;
    _button1.x = 0;
    _button1.y = 0;
    
    _button1line.width = 60;
    _button1line.height = 2;
    _button1line.x = self.width / 4.f - _button1line.width / 2.f;
    _button1line.y = _button1.bottom - 2;
    
    _button2.width = self.width / 2.f;
    _button2.height = self.height;
    _button2.x = _button1.right;
    _button2.y = 0;
    
    _button2line.width = 60;
    _button2line.height = 2;
    _button2line.x = self.width / 4.f * 3 - _button2line.width / 2.f;
    _button2line.y = _button2.bottom - 2;
}

- (void)buttonClick:(UIButton *)sender
{
    
   
    
    _lastButton.selected = NO;
    _lastButton = sender;
    sender.selected = YES;
    
    if (sender.tag == 91) {
        _button1line.hidden = NO;
        _button2line.hidden = YES;
    } else {
        _button1line.hidden = YES;
        _button2line.hidden = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(headerButtonDidPressed:)]) {
        [self.delegate headerButtonDidPressed:sender.tag-90];
    }
}

@end

//
//  GoodDetailBottomView.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodDetailBottomView.h"

@interface GoodDetailBottomView()

@property (nonatomic, strong)UIButton *cartButton;
@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong)UIButton *buyButton;

@end

@implementation GoodDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cartButton setImage:[UIImage imageNamed:@"usercar"] forState:UIControlStateNormal];
        [_cartButton addTarget:self action:@selector(gotoCart) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cartButton];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton setBackgroundColor:[UIColor orangeColor]];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _addButton.layer.cornerRadius = 5;
        [_addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
        
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyButton setBackgroundColor:[UIColor redColor]];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _buyButton.layer.cornerRadius = 5;
        [_buyButton addTarget:self action:@selector(goBuy) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buyButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _cartButton.width = _cartButton.height = 30;
    _cartButton.x = 15;
    _cartButton.y = 7;
    
    _buyButton.width = 72;
    _buyButton.height = 24;
    _buyButton.x = self.width - _buyButton.width - 15;
    _buyButton.y = 10;
    
    _addButton.width = _buyButton.width;
    _addButton.height = _buyButton.height;
    _addButton.x = CGRectGetMinX(_buyButton.frame) - _addButton.width - 10;
    _addButton.y = _buyButton.y;
}

- (void)gotoCart
{
    if ([self.delegate respondsToSelector:@selector(goodDetailDidGoCart)]) {
        [self.delegate goodDetailDidGoCart];
    }
}

- (void)add
{
    if ([self.delegate respondsToSelector:@selector(goodDetailDidAddToCart)]) {
        [self.delegate goodDetailDidAddToCart];
    }
}

- (void)goBuy
{
    if ([self.delegate respondsToSelector:@selector(goodDetailDidGoBuy)]) {
        [self.delegate goodDetailDidGoBuy];
    }
}

@end

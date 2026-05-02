//
//  DCBrandsSortHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBrandsSortHeadView.h"

// Controllers

// Models
#import "DCClassMianItem.h"
// Views

// Vendors

// Categories

// Others

@interface DCBrandsSortHeadView ()

/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;
@end

@implementation DCBrandsSortHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI
{
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = PFR13Font;
    _headLabel.textColor = BackgroundColors(1);
    [self addSubview:_headLabel];
    
    UIView *linv =[[UIView alloc]init];
    linv.backgroundColor = RGB(241, 241, 241);
    self.p_linv =linv;
    linv.height = .5;
    linv.y = 5;
    [self addSubview:linv];
    
    _headLabel.frame = CGRectMake(DCMargin, 0, self.width, self.height);
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(DCClassMianItem *)headTitle
{
    _headTitle = headTitle;
    _headLabel.text = headTitle.m_name;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.p_linv.width = self.width;
}

@end

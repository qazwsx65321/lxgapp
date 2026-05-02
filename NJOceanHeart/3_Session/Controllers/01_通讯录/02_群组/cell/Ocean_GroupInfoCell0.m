//
//  Ocean_GroupInfoCell0.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupInfoCell0.h"

@interface Ocean_GroupInfoCell0 ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UIView *line;

@end

@implementation Ocean_GroupInfoCell0

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightlightGrayColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, screen_Width, 50)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100/320.f*screen_Width, 30)];
    self.nameLabel.text = @"群头像";
    self.nameLabel.textColor = [UIColor colorWithRed:0.196 green:0.200 blue:0.200 alpha:1.000];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.nameLabel];
    
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_Width - 60, 5, 40, 40)];
    self.picImageView.layer.cornerRadius = 20;
    self.picImageView.layer.masksToBounds = YES;
    self.picImageView.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:self.picImageView];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 59, screen_Width, 1)];
    self.line.backgroundColor = [UIColor lightlightGrayColor];
    [self.contentView addSubview:self.line];
    
}

- (void)setPicurl:(NSString *)picurl {
    _picurl = picurl;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:picurl] placeholderImage:[UIImage imageNamed:@"qz"]];
}

@end

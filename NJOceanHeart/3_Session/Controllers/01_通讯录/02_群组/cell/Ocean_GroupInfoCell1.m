//
//  Ocean_GroupInfoCell1.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupInfoCell1.h"


@interface Ocean_GroupInfoCell1 ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *line;

@end

@implementation Ocean_GroupInfoCell1

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100/320.f*screen_Width, 30)];
    self.nameLabel.text = @"群名称";
    self.nameLabel.textColor = [UIColor colorWithRed:0.196 green:0.200 blue:0.200 alpha:1.000];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nameLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right + 10, 10, screen_Width - 20 - (self.nameLabel.right + 10), 30)];
    self.titleLabel.text = @"test";
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.titleLabel.textColor = [UIColor colorWithRed:0.569 green:0.573 blue:0.576 alpha:1.000];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, screen_Width, 1)];
    self.line.backgroundColor = [UIColor lightlightGrayColor];
    [self.contentView addSubview:self.line];
    
}

- (void)setName:(NSString *)name {
    _name = name;
    
    _titleLabel.text = name;
}

@end

//
//  Ocean_GroupInfoHeaderView.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupInfoHeaderView.h"

@interface Ocean_GroupInfoHeaderView ()

@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation Ocean_GroupInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100/320.f*screen_Width, 30)];
    self.nameLabel.text = @"群成员3人";
    self.nameLabel.textColor = [UIColor colorWithRed:0.196 green:0.200 blue:0.200 alpha:1.000];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.nameLabel];
}

- (void)setGroupNum:(NSString *)groupNum {
    _groupNum = groupNum;
    
    _nameLabel.text = [NSString stringWithFormat:@"群成员%@人",groupNum];
}

@end

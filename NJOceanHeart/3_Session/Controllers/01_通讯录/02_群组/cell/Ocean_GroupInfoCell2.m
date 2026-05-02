//
//  Ocean_GroupInfoCell2.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupInfoCell2.h"

@interface Ocean_GroupInfoCell2 ()

@property (nonatomic,strong) UIButton *quitButton;

@end

@implementation Ocean_GroupInfoCell2

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quitButton.frame = CGRectMake(20, 10, screen_Width - 40, 40);
    self.quitButton.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.quitButton setTitle:@"退出并解散" forState:UIControlStateNormal];
    [self.quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.quitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.quitButton addTarget:self action:@selector(quitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.quitButton];
    
}

- (void)quitClick {
    
    if ([self.delegate respondsToSelector:@selector(quitGroup:)]) {
        [self.delegate quitGroup:self];
    }
    
}

- (void)setIsManager:(BOOL)isManager {
    _isManager = isManager;
    
    if (isManager) {
        [_quitButton setTitle:@"退出并解散" forState:UIControlStateNormal];
    }else {
        [_quitButton setTitle:@"退出" forState:UIControlStateNormal];
    }

}

@end

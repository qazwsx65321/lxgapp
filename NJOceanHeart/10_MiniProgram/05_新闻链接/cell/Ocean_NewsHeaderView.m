//
//  Ocean_NewsHeaderView.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_NewsHeaderView.h"

@interface Ocean_NewsHeaderView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *lastButton;

@end

@implementation Ocean_NewsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    
    
    self.titleArray = [NSArray array];
    self.titleArray = @[
                        @{@"title":@"推荐",@"type":@"top"},
                        @{@"title":@"社会",@"type":@"shehui"},
                        @{@"title":@"国内",@"type":@"guonei"},
                        @{@"title":@"国际",@"type":@"guoji"},
                        @{@"title":@"娱乐",@"type":@"yule"},
                        @{@"title":@"体育",@"type":@"tiyu"},
                        @{@"title":@"军事",@"type":@"junshi"},
                        @{@"title":@"科技",@"type":@"keji"},
                        @{@"title":@"财经",@"type":@"caijing"},
                        @{@"title":@"时尚",@"type":@"shishang"},
                        ];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 40)];
    self.scrollView.contentSize = CGSizeMake(screen_Width * 2, 40);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 38, screen_Width/5.f, 2)];
    self.line.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self.line];
    
    CGFloat BW = screen_Width/5.f;
    for (int i = 0; i < 10; i ++) {
        
        NSDictionary *dic = self.titleArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(BW*i, 0, BW, 38);
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(fun:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
        if (i == 0 ) {
            button.selected = YES;
            self.lastButton = button;
        }else {
            button.selected = NO;
        }
        
    }
    
    
}

- (void)fun:(UIButton *)sender {
    
    if (sender != self.lastButton) {
        self.lastButton.selected = NO;
        sender.selected = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.line.centerX = sender.centerX;
        }];
        self.lastButton = sender;
        
        NSDictionary *dic = self.titleArray[sender.tag - 100];
        if ([self.delegate respondsToSelector:@selector(didNewsWithType:)]) {
            [self.delegate didNewsWithType:dic[@"type"]];
        }
        
        
    }
    
    
}

@end

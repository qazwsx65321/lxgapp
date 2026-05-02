//
//  Ocean_FirstPageHeadView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FirstPageHeadView.h"
#import "Ocean_MoreButton.h"
@interface Ocean_FirstPageHeadView()

@property (nonatomic,weak) UILabel * p_label;
@property (nonatomic,weak) Ocean_MoreButton * p_button;


@end

@implementation Ocean_FirstPageHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.font = [UIFont fontWithName:Heiti_Light size:14];
        self.p_label = label;
        
        Ocean_MoreButton *accebutton = [Ocean_MoreButton buttonWithType:UIButtonTypeCustom];
        [accebutton setTitle:@"更多" forState:0];
        [accebutton setTitleColor:RGB(200, 200, 200) forState:0];
        accebutton.titleLabel.font = [UIFont systemFontOfSize:13];
        [accebutton setImage:[UIImage imageNamed:@"more01"] forState:0];
        [self addSubview:accebutton];
        self.p_button = accebutton;
        [accebutton sizeToFit];
        
        
    }
    return self;
}

-(void)setP_info:(NSDictionary *)p_info{
    _p_info = p_info;
    if ([p_info isKindOfClass:[NSNull class]]) {
        self.p_button.hidden = YES;
        self.p_label.hidden = YES;
    }else{
        self.p_label.hidden = NO;
        if (p_info[@"more"]) {
            self.p_button.hidden = NO;
        }else{
            self.p_button.hidden = YES;
        }
        self.p_label.text = p_info[@"content"];
    }
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.p_label.x = 10;
    self.p_label.width = 100;
    self.p_label.height = 15;
    self.p_label.y = 10;
    
    self.p_button.centerY = self.p_label.centerY;
    self.p_button.right = self.width - 10;
}


@end

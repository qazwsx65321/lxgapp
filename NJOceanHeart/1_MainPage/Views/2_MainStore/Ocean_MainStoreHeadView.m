//
//  Ocean_MainStoreHeadView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/11.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MainStoreHeadView.h"

@interface Ocean_MainStoreHeadView()

@property (nonatomic,weak) UIImageView * p_imageV;
@property (nonatomic,weak) UILabel * p_saleLb;
@property (nonatomic,weak) UILabel * p_countLb;



@end

@implementation Ocean_MainStoreHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.height = imageV.width = 65;
        imageV.x = 10;
        imageV.bottom = self.height -10;
        self.p_imageV = imageV;
        [self addSubview:imageV];
        
        self.p_titleLb= [self creatLb:[UIFont systemFontOfSize:14]];
        self.p_titleLb.x =imageV.right +10;
        self.p_titleLb.width = self.width - self.p_titleLb.x - 30;
        self.p_titleLb.height = 15;
        self.p_titleLb.bottom = self.p_imageV.centerY -5;
        
        
        self.p_saleLb= [self creatLb:[UIFont systemFontOfSize:13]];
        self.p_saleLb.y = self.p_titleLb.bottom +10;
        self.p_saleLb.x = self.p_titleLb.x;
        self.p_saleLb.height = 14;
    
        self.p_countLb= [self creatLb:[UIFont systemFontOfSize:13]];
        self.p_countLb.y = self.p_titleLb.bottom +10;
        self.p_countLb.height = 14;

        
        UIImageView *accImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more01"]];
        accImage.width = 11;
        accImage.height = 20;
        accImage.centerY = imageV.centerY;
        accImage.right = self.width -10;
        [self addSubview:accImage];
        
    }
    return self;
}

-(void)setModel:(shopInfoModel *)model{
    _model = model;
    [self.p_imageV sd_setImageWithURL:[NSURL URLWithString:model.m_listpic] placeholderImage:[UIImage imageNamed:@"errorImage"]];
    self.p_titleLb.text = model.m_name;
//    [self.p_titleLb sizeToFit];
    
    self.p_saleLb.text = [NSString stringWithFormat:@"销量%@",model.m_soldnum];
    [self.p_saleLb sizeToFit];
    
    
    self.p_countLb.text = [NSString stringWithFormat:@"共%@件商品",model.m_allnum];
    [self.p_countLb sizeToFit];
    self.p_countLb.x = self.p_saleLb.right +5;
    
}

-(UILabel *)creatLb:(UIFont *)font{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.font = font;
    [self addSubview:label];
    return label;
}

@end

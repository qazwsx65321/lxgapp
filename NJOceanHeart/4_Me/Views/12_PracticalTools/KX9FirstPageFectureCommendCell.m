//
//  KX9FirstPageFectureCommendCell.m
//  Glad9TM
//
//  Created by qiushi on 2017/5/27.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "KX9FirstPageFectureCommendCell.h"

@interface KX9FirstPageFectureCommendCell()

@property (nonatomic,weak) UIImageView * p_titleImageV;
@property (nonatomic,weak) UILabel * p_priceLb;
@property (nonatomic,weak) UILabel * p_titleLb;
@property (nonatomic,weak) UILabel * p_detalTitleLb;

@end

@implementation KX9FirstPageFectureCommendCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.shadowOffset = CGSizeMake(2, 2);
//        self.layer.shadowColor = RGB(244, 244, 244).CGColor;
//        self.layer.shadowOpacity = 5;
        
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *titImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_img01"]];
        [self addSubview:titImageView];
        self.p_titleImageV = titImageView;
        
   
        
        self.p_titleLb = [self creatLb];
        self.p_titleLb.font = [UIFont systemFontOfSize:14];
        self.p_titleLb.textAlignment = NSTextAlignmentCenter;
        self.p_titleLb.numberOfLines = 0;

        
        
    }
    return self;
}

-(UILabel *)creatLb{

    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    return label;
}


-(void)setModel:(KX9FirstPageProductModel *)model{
    _model = model;
    [self.p_titleImageV sd_setImageWithURL:[NSURL URLWithString:model.m_picture]];
    self.p_titleLb.text = model.m_name;
}


-(void)layoutSubviews{
    [super layoutSubviews];

    self.p_titleImageV.height =  self.p_titleImageV.width = self.width *100/158;
    self.p_titleImageV.centerX = self.width/2;
    self.p_titleImageV.y = self.height *20/150;
    
    self.p_titleLb.width = self.width -10;
    [self.p_titleLb  sizeToFit];
    self.p_titleLb.centerX = self.width/2;
    self.p_titleLb.y = self.p_titleImageV.bottom +10;
    
}

@end

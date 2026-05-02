//
//  Ocean_RecommendStoreCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_RecommendStoreCell.h"
#import "Ocean_TMShopView.h"

#define shopNum 3
#define space 5
#define section 10

@interface Ocean_RecommendStoreCell()

@property (nonatomic,strong) NSMutableArray * p_shopListArr;

@property (nonatomic,weak) UIImageView * p_TMHeadImageV;

@property (nonatomic,weak) UILabel * p_titleLb;

@property (nonatomic,weak) UILabel * p_markCountLb;

@property (nonatomic,weak) UILabel * p_shopLb;

@property (nonatomic,weak) UIButton * p_inputButton;


@end

@implementation Ocean_RecommendStoreCell

-(NSMutableArray *)p_shopListArr{
    if (!_p_shopListArr) {
        NSMutableArray *mutalArr = [NSMutableArray array];
        for (int i = 0; i<shopNum; i++) {
            Ocean_TMShopView *shopView = [[Ocean_TMShopView alloc]init];
            [mutalArr addObject:shopView];
        }
        _p_shopListArr = mutalArr;
    }
    return _p_shopListArr;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView * TMImageView =[[UIImageView alloc]init];
        self.p_TMHeadImageV = TMImageView;
        [self.contentView addSubview:TMImageView];
        TMImageView.image = [UIImage imageNamed:@"shop_img02"];
        
        self.p_titleLb = [self creatLbFont:[UIFont systemFontOfSize:14] TextColor:[UIColor blackColor]];
        self.p_titleLb.text = @"智派旗舰店";
        
        
        self.p_markCountLb = [self creatLbFont:[UIFont systemFontOfSize:13] TextColor:RGB(186, 186, 186)];
        self.p_markCountLb.text = @"销量 2236";

        
        self.p_shopLb = [self creatLbFont:[UIFont systemFontOfSize:13] TextColor:RGB(186, 186, 186)];
        self.p_shopLb.text = @"共38件商品";

        
        UIButton *inputTMButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [inputTMButton setTitle:@"进店" forState:0];
        inputTMButton.userInteractionEnabled = NO;
        [inputTMButton setTitleColor:BackgroundColors(1) forState:0];
        inputTMButton.titleLabel.font = [UIFont fontWithName:Heiti_Light size:13];
        inputTMButton.layer.borderColor = BackgroundColors(1).CGColor;
        inputTMButton.layer.borderWidth = .8;
        [self.contentView addSubview:inputTMButton];
        self.p_inputButton = inputTMButton;
        
        
        int i = 0;
        for (Ocean_TMShopView *shopview in self.p_shopListArr) {
            i ++;
            shopview.userInteractionEnabled = NO;

            [self.contentView addSubview:shopview];
            
            [shopview setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"img00%d",i]] forState:0];
            
            [shopview setTitle:@"¥2299.00" forState:0];
        }
        
    }
    return self;
}

-(void)setModel:(shopInfoModel *)model{
    _model = model;
    [self.p_TMHeadImageV sd_setImageWithURL:[NSURL URLWithString:model.m_listpic] placeholderImage:[UIImage imageNamed:@"errorImage"]];
    self.p_shopLb.text =[NSString stringWithFormat:@"共 %@",model.m_allnum];
    self.p_markCountLb.text =[NSString stringWithFormat:@"销量 %@",model.m_soldnum];
    self.p_titleLb.text = model.m_name;
    for (int i = 0; i<self.p_shopListArr.count; i++) {
//        NSString *goodsid = [model valueForKeyPath:[NSString stringWithFormat:@"m_goodsid%d",i+1]];
        NSString *price = [model valueForKeyPath:[NSString stringWithFormat:@"m_price%d",i+1]];
        NSString *pic = [model valueForKeyPath:[NSString stringWithFormat:@"m_goodspic%d",i+1]];

        Ocean_TMShopView *shopview = self.p_shopListArr[i];
        [shopview setTitle:[NSString stringWithFormat:@"¥%@",price] forState:0];
        [shopview sd_setBackgroundImageWithURL:[NSURL URLWithString:pic] forState:0];
    }
    
    [self setNeedsLayout];
    
}

-(UILabel *)creatLbFont:(UIFont *)font TextColor:(UIColor *)textcolor{
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = textcolor;
    [self.contentView addSubview:label];
    return label;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.p_TMHeadImageV.x = 10;
    self.p_TMHeadImageV.y = 15;
    self.p_TMHeadImageV.height = self.p_TMHeadImageV.width = 40;
    
    self.p_titleLb.x = self.p_TMHeadImageV.right +15;
    [self.p_titleLb sizeToFit];
    self.p_titleLb.bottom = self.p_TMHeadImageV.centerY -3;
    
    self.p_markCountLb.x = self.p_titleLb.x;
    [self.p_markCountLb sizeToFit];
    self.p_markCountLb.y = self.p_TMHeadImageV.centerY +3;
    
    self.p_shopLb.x = self.p_markCountLb.right +10;
    [self.p_shopLb sizeToFit];
    self.p_shopLb.centerY = self.p_markCountLb.centerY;
    
    self.p_inputButton.width = 45;
    self.p_inputButton.height = self.p_inputButton.width/2;
    self.p_inputButton.right = self.width -10;
    self.p_inputButton.centerY = self.p_TMHeadImageV.centerY;
    self.p_inputButton.layer.cornerRadius = self.p_inputButton.height/2;
    self.p_inputButton.layer.masksToBounds = YES;
    
    
    CGFloat W = (self.width -3*section)/3;
    CGFloat Y = self.p_TMHeadImageV.bottom +15;
    
    for (int i = 0; i<self.p_shopListArr.count; i++) {
        Ocean_TMShopView *shopView = self.p_shopListArr[i];
        shopView.width = shopView.height = W;
        shopView.y = Y;
        shopView.x = 10 + i *(space + W);
    }
    
}

@end


//
//  Ocean_FistHotGoodsCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FistHotGoodsCell.h"
#import "SDWebImageManager.h"
@interface Ocean_FistHotGoodsCell()



@end

@implementation Ocean_FistHotGoodsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UILabel *titleLb = [[UILabel alloc]init];
        self.m_titleLb =titleLb;
        [self.contentView addSubview:titleLb];
        self.m_titleLb.lineBreakMode =NSLineBreakByCharWrapping;
        titleLb.numberOfLines = 2;
        
        UILabel *detailLb = [[UILabel alloc]init];
        self.m_desLb = detailLb;
        self.m_desLb.lineBreakMode =NSLineBreakByCharWrapping;
        detailLb.font = [UIFont systemFontOfSize:12];
        detailLb.textColor = RGB(172, 172, 172);
        [self.contentView addSubview:detailLb];
        detailLb.numberOfLines = 2;
        
        UIImageView *goodImageV = [[UIImageView alloc]init];
        [self.contentView addSubview:goodImageV];
        goodImageV.contentMode = UIViewContentModeScaleToFill;
        self.m_goodsImageV = goodImageV;
    }
    return self;
}

-(void)setSelected:(BOOL)selected{


}



-(void)setM_model:(hotGoodsModel *)m_model{
    _m_model =m_model;
    
 
    if (1) {
        NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:m_model.m_picture]];
        if (cacheImageKey.length) {
            NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
            if (cacheImagePath.length) {
//                imageData = [NSData dataWithContentsOfFile:cacheImagePath];
            }
        }
    }
    
    [self.m_goodsImageV sd_setImageWithURL:[NSURL URLWithString:m_model.m_picture] placeholderImage:[UIImage imageNamed:@"errorImage"]];
    self.m_titleLb.text = m_model.m_title;
    self.m_desLb.text = m_model.m_saletitle;
    [self setNeedsLayout];
}


//184/259

-(void)layoutSubviews{
    [super layoutSubviews];
    
//    if (!_sign) {
//        self.m_titleLb.font = [UIFont fontWithName:Heiti_Light size:18];
//        self.m_titleLb.textAlignment = NSTextAlignmentLeft;
//        self.m_desLb.hidden=  NO;
//    }else{
//        self.m_titleLb.font = [UIFont fontWithName:Heiti_Light size:13];
//        self.m_titleLb.textAlignment = NSTextAlignmentCenter;
//        self.m_desLb .hidden = YES;
//    }
//    
//    self.m_titleLb.x = 5;
//    self.m_titleLb.y = 5;
//    self.m_titleLb.width = self.width - 2*self.m_titleLb.x;
//    [self.m_titleLb sizeToFit];
//    self.m_titleLb.centerX = self.width/2;
//    
//    self.m_desLb.width = self.m_titleLb.width;
//    self.m_desLb.height = 14;
//    self.m_desLb.y = self.m_titleLb.bottom +15;
//    self.m_desLb.x = self.m_titleLb.x;
//    
//    self.m_goodsImageV.width = self.width *176/184;
//    self.m_goodsImageV.height = self.width *120/184;
//    self.m_goodsImageV.centerX = self.width/2;
//    self.m_goodsImageV.bottom = self.height - self.height *20/259;
    
    self.m_goodsImageV.frame = self.bounds;
}


@end

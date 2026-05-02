//
//  Ocean_CategoryRightFramModel.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_CategoryRightFramModel.h"

@implementation Ocean_CategoryRightFramModel


-(instancetype)initWithFoodModel:(FoodModel *)model{
    
    self = [super init];
    if (self) {
        _m_foodModel = model;
        CGFloat cellW = SCREEN_WIDTH - 80;
        
        _ImageFram = CGRectMake(15, 15, 65, 65);
        
        NSString *title = model.m_title;
        CGFloat titleX = CGRectGetMaxX(_ImageFram)+10;
        CGFloat titleW = cellW - titleX - 10;
        CGSize titleSize = [StringSizeModel sizeWithText:title font:[UIFont systemFontOfSize:14] maxW:titleW];
        _titleFram = CGRectMake(titleX,15 ,titleSize.width,titleSize.height);
        
        NSString *sale = [NSString stringWithFormat:@"已售%@件",model.m_count];
        CGSize saleSize = [StringSizeModel sizeWithText:sale font:[UIFont systemFontOfSize:13] maxW:MAXFLOAT];
        
        _saleFram = CGRectMake(titleX, CGRectGetMaxY(_titleFram)+10, saleSize.width, saleSize.height);
        
        
        CGFloat baseX= CGRectGetMaxX(_saleFram)+10;
        _baseFram = CGRectMake(baseX, CGRectGetMaxY(_titleFram)+10, cellW-baseX, saleSize.height);
        
        _priceFram = CGRectMake(titleX, CGRectGetMaxY(_saleFram)+15, cellW-titleX, 15);
        
        _cellHeight = CGRectGetMaxY(_priceFram) +15;
        
    }
    return self;
    
}


@end

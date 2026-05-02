//
//  Ocean_FistHotGoodsCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_FIRSTPAGESHOWModel.h"
@interface Ocean_FistHotGoodsCell : UICollectionViewCell
@property (nonatomic,weak) UILabel * m_titleLb;
@property (nonatomic,weak) UILabel * m_desLb;
@property (nonatomic,weak) UIImageView * m_goodsImageV;
@property (nonatomic,assign) NSUInteger sign;
@property (nonatomic,strong) hotGoodsModel * m_model;
@end

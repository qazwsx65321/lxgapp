//
//  Ocean_CategoryRightFramModel.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
@interface Ocean_CategoryRightFramModel : NSObject

@property (nonatomic,assign) CGRect ImageFram;
@property (nonatomic,assign) CGRect titleFram;
@property (nonatomic,assign) CGRect saleFram;
@property (nonatomic,assign) CGRect baseFram;
@property (nonatomic,assign) CGRect priceFram;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,strong) FoodModel * m_foodModel;

-(instancetype)initWithFoodModel:(FoodModel *)model;


@end

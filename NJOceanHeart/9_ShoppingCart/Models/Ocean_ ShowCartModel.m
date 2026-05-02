//
//  Ocean_ ShowCartModel.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ ShowCartModel.h"

@implementation Ocean__ShowCartModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"SHOPPINGCARTINFO":@"Ocean__ShowCartGoodsHead"};
}
@end

@implementation Ocean__ShowCartGoodsHead

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"m_goodslist":@"Ocean__ShowCartGoodsModel"};
}

@end

@implementation Ocean__ShowCartGoodsModel

@end

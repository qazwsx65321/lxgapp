//
//  Ocean_DataModel.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DataModel.h"

@implementation Ocean_DataModel

@end

/*!
 * 火车查询
 */
@implementation Ocean_TrainHead

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"result":@"Ocean_TrainModel"};
}

@end

@implementation Ocean_TrainModel


@end


/*!
 * 驾驶证扣分查询
 */
@implementation Ocean_DriveModel

@end


/*!
 * 身份证实名认证
 */
@implementation Ocean_IdcardModel

@end

@implementation Ocean_IdcardBody

@end


/*!
 * 新华字典
 */
@implementation Ocean_XinhuaModel

@end

/*!
 * 新闻头条
 */
@implementation Ocean_NewsHead

@end

@implementation Ocean_NewsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":@"Ocean_NewsBody"};
}

@end

@implementation Ocean_NewsBody

@end


/*!
 * 失信人查询
 */
@implementation Ocean_ShiXinHead

@end

@implementation Ocean_ShiXinModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"Ocean_ShiXinBody"};
}



@end

@implementation Ocean_ShiXinBody

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"desc":@"description"};
}

@end


/*!
 * 智能问答
 */
@implementation Ocean_ZhiNengModel

@end


/*!
 * 周公解梦
 */
@implementation Ocean_JieMengHead

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"result":@"Ocean_JieMengModel"};
}

@end

@implementation Ocean_JieMengModel

@end


/*!
 * 全国物流快递
 */
@implementation Ocean_WuLiuHead

@end

@implementation Ocean_WuLiuModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"Ocean_WuLiuBody"};
}

@end

@implementation Ocean_WuLiuBody

@end


/*!
 * IP地址查询
 */
@implementation Ocean_IPModel

@end

/*!
 * 手机号归属地查询
 */
@implementation Ocean_PhoneAddressModel

@end




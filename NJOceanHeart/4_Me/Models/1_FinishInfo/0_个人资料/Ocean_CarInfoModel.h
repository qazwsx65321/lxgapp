//
//  Ocean_CarInfoModel.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_CarInfoModel : NSObject
@property (nonatomic,strong) NSString * m_cid;
@property (nonatomic,strong) NSString * m_name;
@property (nonatomic,strong) NSString * m_zpic;
@property (nonatomic,strong) NSString * m_fpic;
@property (nonatomic,strong) NSString * m_price;
@property (nonatomic,assign) BOOL isSelect;

@end

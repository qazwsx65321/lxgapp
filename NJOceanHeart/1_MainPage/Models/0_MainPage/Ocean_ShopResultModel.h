//
//  Ocean_ShopResultModel.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_ShopResultModel : NSObject

@property (nonatomic, strong)NSString *m_logo;
@property (nonatomic, strong)NSString *m_bname;
@property (nonatomic, strong)NSString *m_bid;
@property (nonatomic, assign)int m_soldallnum;
@property (nonatomic, assign)int m_allnum;

@property (nonatomic, strong)NSString *m_type;

@property (nonatomic, strong)NSString *m_picturelist;
@property (nonatomic, strong)NSString *m_name;
@property (nonatomic, strong)NSString *m_price;
@property (nonatomic, strong)NSString *m_salescount;
@property (nonatomic, strong)NSString *m_goodsid;

@end



@interface Ocean_SearchResultModel : NSObject

@property (nonatomic, strong)NSArray  *GOODSINFO;

@end

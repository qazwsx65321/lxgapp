//
//  Ocean_FIRSTPAGESHOWModel.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_FIRSTPAGESHOWModel : NSObject

@property (nonatomic,strong) NSArray * m_goodslist;
@property (nonatomic,strong) NSArray * m_goodslist2;
@property (nonatomic,strong) NSArray * m_goodslist3;
@property (nonatomic,strong) NSArray * m_goodslist4;
@property (nonatomic,strong) NSString * ERRORCODE;
@property (nonatomic,strong) NSString * ERRORDESTRIPTION;
@property (nonatomic,strong) NSString * m_showios_6;
@end


@interface groupButtonModel : NSObject

@property (nonatomic,strong) NSString * m_gcid;
@property (nonatomic,strong) NSString * m_name;
@property (nonatomic,strong) NSString * m_picture;
@property (nonatomic,strong) NSString * m_type;
@property (nonatomic,strong) NSString * m_url;

@end

@interface announcementModel : NSObject

@property (nonatomic,strong) NSString * m_buildtime;
@property (nonatomic,strong) NSString * m_title;
@property (nonatomic,strong) NSString * m_id;

@end

@interface hotGoodsModel : NSObject

@property (nonatomic,strong) NSString * m_gbid;
@property (nonatomic,strong) NSString * m_picture;
@property (nonatomic,strong) NSString * m_saletitle;
@property (nonatomic,strong) NSString * m_title;

@end




@interface shopInfoModel : NSObject

@property (nonatomic,strong) NSString * m_allnum;
@property (nonatomic,strong) NSString * m_gbid;

@property (nonatomic,strong) NSString * m_goodsid1;
@property (nonatomic,strong) NSString * m_goodsid2;
@property (nonatomic,strong) NSString * m_goodsid3;

@property (nonatomic,strong) NSString * m_goodspic1;
@property (nonatomic,strong) NSString * m_goodspic2;
@property (nonatomic,strong) NSString * m_goodspic3;

@property (nonatomic,strong) NSString * m_listpic;
@property (nonatomic,strong) NSString * m_name;
@property (nonatomic,strong) NSString * m_price1;
@property (nonatomic,strong) NSString * m_price2;

@property (nonatomic,strong) NSString * m_price3;
@property (nonatomic,strong) NSString * m_soldnum;
@end



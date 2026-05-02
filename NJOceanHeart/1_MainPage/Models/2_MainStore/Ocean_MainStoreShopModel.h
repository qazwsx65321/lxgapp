//
//  Ocean_MainStoreShopModel.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/11.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_MainStoreShopModel : NSObject

@property (nonatomic,strong) NSArray * shopinfolist;
@property (nonatomic,strong) NSArray * goodslist;
@property (nonatomic,strong) NSArray * classlist;
@property (nonatomic,strong) NSString* ERRORCODE;
@property (nonatomic,strong) NSString* ERRORDESTRIPTION;
@end

@interface storeShopModel : NSObject

@property (nonatomic,strong) NSString* m_area;
@property (nonatomic,strong) NSString* m_bid;
@property (nonatomic,strong) NSString* m_cardid;
@property (nonatomic,strong) NSString* m_cardno;
@property (nonatomic,strong) NSString* m_certype;
@property (nonatomic,strong) NSString* m_city;
@property (nonatomic,strong) NSString* m_compaddress;
@property (nonatomic,strong) NSString* m_content;
@property (nonatomic,strong) NSString* m_corphone;
@property (nonatomic,strong) NSString* m_corporation;
@property (nonatomic,strong) NSString* m_detailpic;
@property (nonatomic,strong) NSString* m_fcardno;
@property (nonatomic,strong) NSString* m_handcard;
@property (nonatomic,strong) NSString* m_lat;
@property (nonatomic,strong) NSString* m_license;
@property (nonatomic,strong) NSString* m_listpic;
@property (nonatomic,strong) NSString* m_lng;
@property (nonatomic,strong) NSString* m_logo;
@property (nonatomic,strong) NSString* m_name;
@property (nonatomic,strong) NSString* m_orgcode;
@property (nonatomic,strong) NSString* m_pro;
@property (nonatomic,strong) NSString* m_shopclassname;
@property (nonatomic,strong) NSString* m_taxreg;
@property (nonatomic,strong) NSString* m_threelicense;
@property (nonatomic,strong) NSString* m_type;
@property (nonatomic,strong) NSString* m_zcardno;

@property (nonatomic,strong) NSString* m_soldallnum;
@property (nonatomic,strong) NSString* m_allnum;



@end

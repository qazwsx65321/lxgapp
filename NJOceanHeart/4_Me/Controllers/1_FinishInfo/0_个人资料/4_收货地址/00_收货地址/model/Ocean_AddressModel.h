//
//  Ocean_AddressModel.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/4.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_AddressModel : NSObject

@end


//提交订单的默认地址
@interface ShopAddressModel : Ocean_AddressModel

@property (nonatomic,copy) NSString *m_name;
@property (nonatomic,copy) NSString *m_telphone;
@property (nonatomic,copy) NSString *m_pro;
@property (nonatomic,copy) NSString *m_city;
@property (nonatomic,copy) NSString *m_area;
@property (nonatomic,copy) NSString *m_address;
@property (nonatomic,copy) NSString *m_lat;
@property (nonatomic,copy) NSString *m_lng;

@end

@interface ShopAddressBody : Ocean_AddressModel

@property (nonatomic,copy) NSString *ERRORCODE;
@property (nonatomic,copy) NSString *ERRORDESTRIPTION;
@property (nonatomic,strong) NSArray *MYADDRESS;

@end



//我的收货地址
@interface MyAddressModel : Ocean_AddressModel

@property (nonatomic,copy) NSString *m_id;
@property (nonatomic,copy) NSString *m_linkname;
@property (nonatomic,copy) NSString *m_telphone;
@property (nonatomic,copy) NSString *m_pro;
@property (nonatomic,copy) NSString *m_city;
@property (nonatomic,copy) NSString *m_area;
@property (nonatomic,copy) NSString *m_address;
@property (nonatomic,copy) NSString *m_coordinatex;
@property (nonatomic,copy) NSString *m_coordinatey;
@property (nonatomic,copy) NSString *m_flag; //flag:0是一般，1默认地址

@end


@interface MyAddressBody : Ocean_AddressModel

@property (nonatomic,copy) NSString *ERRORCODE;
@property (nonatomic,copy) NSString *ERRORDESTRIPTION;
@property (nonatomic,strong) NSArray *MYADDRESS;

@end


//添加收货地址
@interface AddAddressModel : Ocean_AddressModel

@property (nonatomic,copy) NSString *m_uid;
@property (nonatomic,copy) NSString *m_session;
@property (nonatomic,copy) NSString *m_addressid;
@property (nonatomic,copy) NSString *m_linkname;
@property (nonatomic,copy) NSString *m_linktel;
@property (nonatomic,copy) NSString *m_pro;
@property (nonatomic,copy) NSString *m_city;
@property (nonatomic,copy) NSString *m_area;
@property (nonatomic,copy) NSString *m_address;
@property (nonatomic,copy) NSString *m_flag;
@property (nonatomic,copy) NSString *m_coordinatex;  //经度
@property (nonatomic,copy) NSString *m_coordinatey;  //纬度
@property (nonatomic,copy) NSString *m_compaddress;
@property (nonatomic,copy) NSString *m_storeAddress;

@end





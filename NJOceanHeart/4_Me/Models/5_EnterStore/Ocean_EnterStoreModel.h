//
//  Ocean_EnterStoreModel.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_EnterStoreModel : NSObject

@property (nonatomic,strong) NSString * m_corporation;//法人
@property (nonatomic,strong) NSString * m_cardno;// 身份证号
@property (nonatomic,strong) NSString * m_corphone;// 手机号
@property (nonatomic,strong) NSString * m_spreadcode;//  推广码
@property (nonatomic,strong) NSData * m_zcardno;//证件照正面
@property (nonatomic,strong) NSData * m_fcardno;//证件照反面
@property (nonatomic,strong) NSString * m_type;// 商户的类型，1企业，2个体，3其他


@property (nonatomic,strong) NSString * m_name;//店铺名称
@property (nonatomic,strong) NSString * m_content;// 店铺文字介绍
@property (nonatomic,strong) NSString * m_storeAddress;
@property (nonatomic,strong) NSString * m_compaddress;//详细地址
@property (nonatomic,strong) NSString * m_lng;//经度
@property (nonatomic,strong) NSString * m_lat;//纬度
@property (nonatomic,strong) NSString * m_filepix;//文件后缀名
@property (nonatomic,strong) NSData * m_license;//营业执照
@property (nonatomic,strong) NSData * m_orgcode;//组织机构代码证
@property (nonatomic,strong) NSData * m_taxreg;//税务登记证
@property (nonatomic,strong) NSData * m_threelicense;//三证合一
@property (nonatomic,strong) NSString * m_pro;// 省
@property (nonatomic,strong) NSString * m_city;// 市
@property (nonatomic,strong) NSString * m_area;// 区
@property (nonatomic,strong) NSString * m_sign;// 是否三证合一    0：是   1：不是
@property (nonatomic,strong) NSString * m_gbcid;//商户分类ID
@property (nonatomic,strong) NSString * m_gbname;//商户分类名称




@end

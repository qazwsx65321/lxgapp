//
//  Ocean_DataModel.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_DataModel : NSObject

@end

/*!
 * 火车查询
 */
@interface Ocean_TrainHead : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSArray *result;

@end

@interface Ocean_TrainModel : NSObject

@property (nonatomic,copy) NSString *trainno;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *station;
@property (nonatomic,copy) NSString *endstation;
@property (nonatomic,copy) NSString *departuretime;
@property (nonatomic,copy) NSString *arrivaltime;
@property (nonatomic,copy) NSString *sequenceno;
@property (nonatomic,copy) NSString *costtime;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *isend;
@property (nonatomic,copy) NSString *pricesw;
@property (nonatomic,copy) NSString *pricetd;
@property (nonatomic,copy) NSString *pricegr1;
@property (nonatomic,copy) NSString *pricegr2;
@property (nonatomic,copy) NSString *pricerw1;
@property (nonatomic,copy) NSString *pricerw2;
@property (nonatomic,copy) NSString *priceyw1;
@property (nonatomic,copy) NSString *priceyw2;
@property (nonatomic,copy) NSString *priceyw3;
@property (nonatomic,copy) NSString *priceyd;
@property (nonatomic,copy) NSString *priceed;

@end


/*!
 * 驾驶证扣分查询
 */
@interface Ocean_DriveModel : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end


/*!
 * 身份证实名认证
 */
@interface Ocean_IdcardModel : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end

@interface Ocean_IdcardBody : NSObject

@property (nonatomic,copy) NSString *idcard;
@property (nonatomic,copy) NSString *realname;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *town;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *birth;
@property (nonatomic,copy) NSString *verifystatus;
@property (nonatomic,copy) NSString *verifymsg;

@end


/*!
 * 新华字典
 */
@interface Ocean_XinhuaModel : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end


/*!
 * 新闻头条
 */
@interface Ocean_NewsHead : NSObject

@property (nonatomic,copy) NSString *reason;
@property (nonatomic,strong) NSDictionary *result;

@end

@interface Ocean_NewsModel : NSObject

@property (nonatomic,copy) NSString *stat;
@property (nonatomic,strong) NSArray *data;

@end

@interface Ocean_NewsBody : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *author_name;
@property (nonatomic,copy) NSString *thumbnail_pic_s;
@property (nonatomic,copy) NSString *thumbnail_pic_s02;
@property (nonatomic,copy) NSString *thumbnail_pic_s03;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *uniquekey;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *realtype;

@end


/*!
 * 失信人查询
 */
@interface Ocean_ShiXinHead : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end

@interface Ocean_ShiXinModel : NSObject

@property (nonatomic,copy) NSString *realname;
@property (nonatomic,copy) NSString *idcard;
@property (nonatomic,strong) NSArray *list;

@end

@interface Ocean_ShiXinBody : NSObject

@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *idcard;
@property (nonatomic,copy) NSString *filingdate;
@property (nonatomic,copy) NSString *caseno;
@property (nonatomic,copy) NSString *baseonno;
@property (nonatomic,copy) NSString *baseonorg;
@property (nonatomic,copy) NSString *court;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *duty;
@property (nonatomic,copy) NSString *performance;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *pubdate;

@end


/*!
 * 智能问答
 */
@interface Ocean_ZhiNengModel : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end

/*!
 * 周公解梦
 */
@interface Ocean_JieMengHead : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSArray *result;

@end

@interface Ocean_JieMengModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *content;

@end

/*!
 * 全国物流快递
 */
@interface Ocean_WuLiuHead : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end

@interface Ocean_WuLiuModel : NSObject

@property (nonatomic,copy) NSString *issign;
@property (nonatomic,strong) NSArray *list;

@end

@interface Ocean_WuLiuBody: NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *status;

@end


/*!
 * IP地址查询
 */
@interface Ocean_IPModel : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end

/*!
 * 手机号归属地查询
 */
@interface Ocean_PhoneAddressModel : NSObject

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSDictionary *result;

@end



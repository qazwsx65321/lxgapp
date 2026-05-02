//
//  Ocean_OrderDetailModel.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/2.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_OrderDetailModel : NSObject

@property (nonatomic,copy) NSString *m_dgid;
@property (nonatomic,copy) NSString *m_goodsid;
@property (nonatomic,copy) NSString *m_state;
@property (nonatomic,copy) NSString *m_checkorder;
@property (nonatomic,copy) NSString *m_checkmark;
@property (nonatomic,copy) NSString *m_title;
@property (nonatomic,copy) NSString *m_guigename;
@property (nonatomic,copy) NSString *m_num;
@property (nonatomic,copy) NSString *m_pic;
@property (nonatomic,copy) NSString *m_fee;
@property (nonatomic,copy) NSString *m_returngoodstime;
@property (nonatomic,copy) NSString *m_price;
@property (nonatomic,copy) NSString *m_orderno3;
@property (nonatomic,copy) NSString *m_saletitle;
@property (nonatomic,copy) NSString *m_returngoodsflag;

@end

@interface Ocean_OrderDetailHead : NSObject

@property (nonatomic,copy) NSString *ERRORCODE;

@property (nonatomic,copy) NSString *m_address;
@property (nonatomic,copy) NSString *m_allnum;
@property (nonatomic,copy) NSString *m_bid;
@property (nonatomic,copy) NSString *m_bname;
@property (nonatomic,strong) NSArray *m_goodslist;
@property (nonatomic,copy) NSString *m_buildtime;
@property (nonatomic,copy) NSString *m_checkorder;
@property (nonatomic,copy) NSString *m_cherkmark;
@property (nonatomic,copy) NSString *m_expressname;
@property (nonatomic,copy) NSString *m_expressnumber;
@property (nonatomic,copy) NSString *m_isfee;
@property (nonatomic,copy) NSString *m_logo;
@property (nonatomic,copy) NSString *m_paytime;
@property (nonatomic,copy) NSString *m_sendtime;
@property (nonatomic,copy) NSString *m_soldallnum;
@property (nonatomic,copy) NSString *m_state;
@property (nonatomic,copy) NSString *m_suretime;

@end

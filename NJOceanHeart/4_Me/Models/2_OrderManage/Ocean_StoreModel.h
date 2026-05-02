//
//  Ocean_StoreModel.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_StoreOrderModel : NSObject

@property (nonatomic,copy) NSString *m_logo;
@property (nonatomic,copy) NSArray  *GOODINFO;
@property (nonatomic,copy) NSString *m_bid;
@property (nonatomic,copy) NSString *m_bname;
@property (nonatomic,copy) NSString *m_checkmark;
@property (nonatomic,copy) NSString *m_checkorder;
@property (nonatomic,copy) NSString *m_fee;
@property (nonatomic,copy) NSString *m_orderno;
@property (nonatomic,copy) NSString *m_state;
@property (nonatomic,copy) NSString *m_isfee;   //配送方式，1配送，2快递
@property (nonatomic,copy) NSString *m_expressnumber;  //配送方式为1的时候是预计到达时间，2就是快递单号
@property (nonatomic,copy) NSString *m_expressname;  //配送方式为2的时候是快递公司名称

@end


@interface Ocean_StoreCommodityModel : NSObject

@property (nonatomic,copy) NSString *m_dgid;
@property (nonatomic,copy) NSString *m_goodsid;
@property (nonatomic,copy) NSString *m_guigename;
@property (nonatomic,copy) NSString *m_num;
@property (nonatomic,copy) NSString *m_orderno3;
@property (nonatomic,copy) NSString *m_pic;
@property (nonatomic,copy) NSString *m_price;
@property (nonatomic,copy) NSString *m_saletitle;
@property (nonatomic,copy) NSString *m_title;

@end

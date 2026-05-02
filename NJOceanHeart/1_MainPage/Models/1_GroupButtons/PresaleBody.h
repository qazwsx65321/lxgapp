//
//  PresaleBody.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/13.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresaleBody : NSObject

@end

@interface PresaleReqBody : PresaleBody

@property (nonatomic, copy)NSString *JUDGEMETHOD;
@property (nonatomic, copy)NSString *m_goodstype;

@end

@interface PresaleRespBody : PresaleBody

@property (nonatomic, copy)NSString *ERRORCODE;
@property (nonatomic, copy)NSString *ERRORDESTRIPTION;
@property (nonatomic, strong)NSArray *SPECIALGOODSINFO;

@end

@interface PresaleModel : NSObject

@property (nonatomic, copy)NSString *m_price;
@property (nonatomic, copy)NSString *m_id;
@property (nonatomic, copy)NSString *m_title;
@property (nonatomic, copy)NSString *m_salescount;
@property (nonatomic, copy)NSString *m_listpic;

@end

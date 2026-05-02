//
//  GoodDetailBody.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDetailBody : NSObject

@end

@interface GoodDetailReqBody : GoodDetailBody

@property (nonatomic, copy)NSString *JUDGEMETHOD;
@property (nonatomic, copy)NSString *m_goodsid;

@end

@interface GoodDetailRespBody : GoodDetailBody

@property (nonatomic, copy)NSString *ERRORCODE;
@property (nonatomic, copy)NSString *ERRORDESTRIPTION;
@property (nonatomic, strong)NSArray *list1;
@property (nonatomic, strong)NSArray *m_detailpic;
@property (nonatomic, strong)NSArray *m_winlistpic;

@property (nonatomic, copy)NSString *m_allnum;
@property (nonatomic, copy)NSString *m_bid;
@property (nonatomic, copy)NSString *m_evalnum;
@property (nonatomic, copy)NSString *m_listpic;
@property (nonatomic, copy)NSString *m_name;
@property (nonatomic, copy)NSString *m_price;
@property (nonatomic, copy)NSString *m_saletitle;
@property (nonatomic, copy)NSString *m_shownum;
@property (nonatomic, copy)NSString *m_soldallnum;
@property (nonatomic, copy)NSString *m_soldnum;
@property (nonatomic, copy)NSString *m_title;

@end

//@interface GoodDetailModel : NSObject
//
//@property (nonatomic, copy)NSString *m_title;
//@property (nonatomic, copy)NSString *m_aprice;
//@property (nonatomic, copy)NSString *m_Allsalescount;
//@property (nonatomic, copy)NSString *m_id;
//@property (nonatomic, copy)NSString *m_allKucun;
//@property (nonatomic, copy)NSString *m_goodstype;
//@property (nonatomic, strong)NSArray *m_guige;
//@property (nonatomic, strong)NSArray *m_lunbopic;
//@property (nonatomic, strong)NSArray *m_deatilpic;
//
//@end

@interface GoodSpecModel : NSObject

@property (nonatomic, copy)NSString *m_dgid;
@property (nonatomic, copy)NSString *m_gid;
@property (nonatomic, copy)NSString *m_guige;
@property (nonatomic, copy)NSString *m_kcnum;
@property (nonatomic, copy)NSString *m_nprice;
@property (nonatomic, copy)NSString *m_price;
@property (nonatomic, copy)NSString *m_soldnum;
@property (nonatomic, copy)NSString *m_title;

@end

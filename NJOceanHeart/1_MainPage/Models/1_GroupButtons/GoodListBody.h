//
//  GoodListBody.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodListBody : NSObject

@end

@interface GoodListReqBody : GoodListBody

@property (nonatomic, copy)NSString *JUDGEMETHOD;
@property (nonatomic, copy)NSString *m_classifyid;
@property (nonatomic, copy)NSString *m_sign;
@property (nonatomic, copy)NSString *m_flag;

@end

@interface GoodListRespBody : GoodListBody

@property (nonatomic, copy)NSString *ERRORCODE;
@property (nonatomic, copy)NSString *ERRORDESTRIPTION;
@property (nonatomic, strong)NSArray *m_goodslist;

@end

@interface GoodListModel : NSObject

@property (nonatomic, copy)NSString *m_evalnum;
@property (nonatomic, copy)NSString *m_gid;
@property (nonatomic, copy)NSString *m_listpic;
@property (nonatomic, copy)NSString *m_price;
@property (nonatomic, copy)NSString *m_saletitle;
@property (nonatomic, copy)NSString *m_shownum;
@property (nonatomic, copy)NSString *m_soldnum;
@property (nonatomic, copy)NSString *m_title;

@end

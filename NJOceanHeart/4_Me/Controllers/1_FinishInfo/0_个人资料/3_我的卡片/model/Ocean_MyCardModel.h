//
//  Ocean_MyCardModel.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_MyCardModel : NSObject

@property (nonatomic,copy) NSString *ERRORCODE;
@property (nonatomic,copy) NSString *ERRORDESTRIPTION;
@property (nonatomic,copy) NSString *m_cid;//一卡通种类id
@property (nonatomic,copy) NSString *m_name;//一卡通类型
@property (nonatomic,copy) NSString *m_zpic;//卡正面
@property (nonatomic,copy) NSString *m_fpic;//卡反面
@property (nonatomic,copy) NSString *m_checkflag;//审核状态    Y通过，N不通过，O待审核
@property (nonatomic,copy) NSString *m_balance;//余额
@property (nonatomic,copy) NSString *m_lockbalance;//冻结余额
@property (nonatomic,copy) NSString *m_bankno;//银行卡号;
@property (nonatomic,copy) NSString *m_bankname;//开户行
@property (nonatomic,copy) NSString *m_reson;//审核说明

@end

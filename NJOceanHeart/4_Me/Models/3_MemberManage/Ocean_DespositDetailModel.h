//
//  Ocean_DespositDetailModel.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

//System.out.print("提现id:"+mapsub.get("m_txid"));
//System.out.print("提现申请月份:"+mapsub.get("m_month"));
//System.out.print("提现申请时间:"+mapsub.get("m_buildtime"));
//List<String> statelist = (List<String>) mapsub.get("m_statelist");
//System.out.print("进度状态:"+statelist);
//System.out.print("不通过说明:"+mapsub.get("m_reson"));
//System.out.print("审核时间:"+mapsub.get("m_checktime"));
//System.out.print("提现金额:"+mapsub.get("m_money"));
//System.out.print("手续费:"+mapsub.get("m_around"));
//System.out.print("实的金额:"+mapsub.get("m_smoney"));

@interface Ocean_DespositDetailModel : NSObject

@property (nonatomic,strong) NSString * m_txid;
@property (nonatomic,strong) NSString * m_month;
@property (nonatomic,strong) NSString * m_buildtime;
@property (nonatomic,strong) NSArray * m_statelist;
@property (nonatomic,strong) NSString * m_reson;
@property (nonatomic,strong) NSString * m_checktime;
@property (nonatomic,strong) NSString * m_money;
@property (nonatomic,strong) NSString * m_around;
@property (nonatomic,strong) NSString * m_smoney;
@property (nonatomic,strong) NSString * m_state;


@end

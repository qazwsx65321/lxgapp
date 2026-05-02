//
//  autoScrollUpAndDownModel.h
//  XRElectricMall
//
//  Created by qiushi on 2016/10/11.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface autoScrollUpAndDownModel : NSObject


/**
 用户名
 */
@property (nonatomic,copy)NSString *m_uname;
/**
 商品名
 */
@property (nonatomic,copy)NSString *m_gname;
/**
 揭晓时间
 */
@property (nonatomic,copy)NSString *m_publishtime;
/**
 服务器当前时间
 */
@property (nonatomic,copy)NSString *m_currenttime;
/**
 商品的id
 */
@property (nonatomic,copy)NSString *m_goodsid;
/**
 商品期数
 */
@property (nonatomic,copy)NSString *m_period;



@end

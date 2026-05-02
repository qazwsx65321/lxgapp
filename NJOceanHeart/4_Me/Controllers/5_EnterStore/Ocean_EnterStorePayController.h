//
//  Ocean_EnterStorePayController.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_EnterStorePayController : UITableViewController

@property (nonatomic,strong) NSString * m_bid;
@property (nonatomic,strong) NSString * m_price;
@property (nonatomic,strong) NSString * m_remark;

@property (nonatomic,assign) NSInteger type;//0商户入驻,1申请卡片后支付,2直接支付卡片
@property (nonatomic,strong) NSString * m_phone;


@end

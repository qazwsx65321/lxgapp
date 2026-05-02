//
//  Ocean_ ShowCartModel.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean__ShowCartModel : NSObject

@property (nonatomic, strong)NSArray *SHOPPINGCARTINFO;

@end

@interface Ocean__ShowCartGoodsHead : NSObject

@property (nonatomic, assign)int headState;
@property (nonatomic, assign)int headClickState;
@property (nonatomic, strong)NSString *m_bid;
@property (nonatomic, strong)NSString *m_bname;
@property (nonatomic, strong)NSString *m_logo;
@property (nonatomic, strong)NSString *m_soldallnum;
@property (nonatomic, strong)NSString *m_allnum;
@property (nonatomic,strong) NSString * m_zytype;
@property (nonatomic, strong)NSMutableArray *m_goodslist;
@end

@interface Ocean__ShowCartGoodsModel : NSObject

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign)int cellClickState;
@property (nonatomic, assign)int cellEditState;
@property (nonatomic, assign)int headState;


@property (nonatomic, strong)NSString *m_gid;
@property (nonatomic, strong)NSString *m_listpic;
@property (nonatomic, strong)NSString *m_title;
@property (nonatomic, strong)NSString *m_price;
@property (nonatomic, strong)NSString *m_num;
@property (nonatomic, strong)NSString *m_cprice;
@property (nonatomic, strong)NSString *m_guigename;
@property (nonatomic, strong)NSString *m_dgid;
@property (nonatomic, strong)NSString *m_kcnum;
@property (nonatomic, strong)NSString *m_limitnum;
@property (nonatomic, strong)NSString *m_aid;
@property (nonatomic, strong)NSString *m_shengyu;

@end

//
//  Ocean_GoodsDetailModel.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_GoodsDetailModel : NSObject

@property (strong, nonatomic)NSString *m_shownum;
@property (strong, nonatomic)NSString *m_price;
@property (strong, nonatomic)NSString *m_gid;
@property (assign, nonatomic)int m_soldallnum;
@property (strong, nonatomic)NSArray *m_winlistpic;
@property (strong, nonatomic)NSString *m_evalnum;
@property (strong, nonatomic)NSString *m_listpic;
@property (strong, nonatomic)NSString *m_bid;
@property (strong, nonatomic)NSString *ERRORCODE;
@property (strong, nonatomic)NSDictionary *list1;
@property(nonatomic,strong)NSArray *m_list2;
@property (assign, nonatomic)int m_allnum;
@property (strong, nonatomic)NSString *m_soldnum;
@property (strong, nonatomic)NSString *m_name;
@property (strong, nonatomic)NSArray *m_detailpic;
@property (strong, nonatomic)NSString *m_title;
@property (strong, nonatomic)NSString *m_saletitle;
@property (nonatomic,strong) NSArray * m_showmenu;
@property (strong, nonatomic)NSString *ERRORDESCRIPTION;
@property (nonatomic,strong) NSString * m_zytype;


@end

@interface SizeModel : NSObject

@property (strong, nonatomic)NSString *m_dgid;
@property (strong, nonatomic)NSString *m_title;
@property (strong, nonatomic)NSString *m_soldnum;
@property (strong, nonatomic)NSString *m_price;
@property (strong, nonatomic)NSString *m_kcnum;
@property (strong, nonatomic)NSString *m_nprice;
@property (strong, nonatomic)NSString *m_guige;
@property (strong, nonatomic)NSString *m_gid;

@end


@interface showMenuModel : NSObject

@property (nonatomic,strong) NSString * one;
@property (nonatomic,strong) NSArray * two;


@end

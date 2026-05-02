//
//  CategoryModel.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *m_name;
@property (nonatomic, copy) NSString *m_id;
@property (nonatomic, copy) NSString *m_icon;
@property (nonatomic, copy) NSString *m_bcid;
@property (nonatomic, strong) NSArray *m_goodslist;


@end

@interface FoodModel : NSObject

@property (nonatomic, copy) NSString *m_shopid;
@property (nonatomic, copy) NSString *m_title;
@property (nonatomic, copy) NSString *m_destitle;
@property (nonatomic, copy) NSString *m_price;
@property (nonatomic, copy) NSString *m_pic;
@property (nonatomic, copy) NSString *m_code;
@property (nonatomic, copy) NSString *m_count;
@property (nonatomic, copy) NSString *m_commentNum;
@property (nonatomic, copy) NSString *m_lookNum;
@property (nonatomic, copy) NSString *m_BaseCount;
-(instancetype)initObjectWithArray:(NSArray *)arr;

@end


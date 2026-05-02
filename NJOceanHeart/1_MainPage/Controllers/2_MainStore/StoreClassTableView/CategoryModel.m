//
//  CategoryModel.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "CategoryModel.h"

@implementation CategoryModel



@end

@implementation FoodModel


-(instancetype)initObjectWithArray:(NSArray *)arr{

    self = [super init];
    if (self) {
        _m_shopid = arr[0];
        _m_title = arr[1];
        _m_destitle = arr[2];
        _m_price = arr[3];
        _m_pic = arr[4];
        _m_code = arr[5];
        _m_count = arr[6];
        _m_commentNum = arr[7];
        _m_lookNum = arr[8];
        _m_BaseCount = arr[9];

    }
    return self;

}

@end

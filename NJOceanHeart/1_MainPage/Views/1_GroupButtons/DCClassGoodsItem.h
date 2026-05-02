//
//  DCClassGoodsItem.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCClassGoodsItem : NSObject

/** 文标题  */
@property (nonatomic, copy ,readonly) NSString *m_cid;
/** plist  */
@property (nonatomic, copy ,readonly) NSString *m_picture;

@property (nonatomic, copy ,readonly) NSString *m_name;

@property (nonatomic, copy ,readonly) NSString *m_price;


@end

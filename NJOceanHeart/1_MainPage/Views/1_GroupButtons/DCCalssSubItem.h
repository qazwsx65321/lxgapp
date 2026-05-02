//
//  DCCalssSubItem.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCalssSubItem : NSObject
/** 商品图片  */
@property (nonatomic, copy ,readonly) NSString *m_picture;

@property (nonatomic, copy ,readonly) NSString *m_cid;
/** 商品类题  */
@property (nonatomic, copy ,readonly) NSString *m_name;


@end

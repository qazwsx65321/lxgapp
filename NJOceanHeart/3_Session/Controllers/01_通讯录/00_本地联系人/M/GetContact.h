//
//  GetContact.h
//  X16.QiHu
//
//  Created by 史伟文 on 16/9/27.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetContact : NSObject

+ (NSArray *)getNativeContact;
+ (NSArray *)getNativeContactPrevIOS10;

+ (NSArray *)getEnterpriceContact;

@property (nonatomic, strong)NSArray *infoList;

@end

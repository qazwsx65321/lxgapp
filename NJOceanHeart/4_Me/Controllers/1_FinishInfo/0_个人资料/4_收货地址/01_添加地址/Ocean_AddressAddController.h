//
//  Ocean_AddressAddController.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddAddressModel;
@interface Ocean_AddressAddController : UIViewController

@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,strong) AddAddressModel *selfModel;

@end

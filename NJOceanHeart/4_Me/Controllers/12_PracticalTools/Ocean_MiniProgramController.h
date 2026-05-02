//
//  Ocean_MiniProgramController.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/14.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KX9FirstPageProductModel.h"

@interface Ocean_MiniProgramController : UIViewController

@property (nonatomic,strong) KX9FirstPageProductModel *model;

- (void)usingToolsPayWithID:(NSString *)toolid withPrice:(NSString *)toolprice withSuccess:(void(^)(void))success;

@end

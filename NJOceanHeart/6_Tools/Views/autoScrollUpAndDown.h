//
//  autoScrollUpAndDown.h
//  XRElectricMall
//
//  Created by qiushi on 2016/10/8.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "autoScrollUpAndDownModel.h"

@class autoScrollUpAndDown;
@protocol autoScrollUpAndDownDelegate <NSObject>

-(void)TapView:(autoScrollUpAndDown *)view andChoosenum:(NSInteger )num;

@end

@interface autoScrollUpAndDown : UIView
/**
 传入的数组
 */
@property(nonatomic,strong)NSArray *m_infoArr;
@property(nonatomic,weak)id<autoScrollUpAndDownDelegate>delegate;
@end

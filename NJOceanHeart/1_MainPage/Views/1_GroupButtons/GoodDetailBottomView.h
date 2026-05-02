//
//  GoodDetailBottomView.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodDetailBottomDelegate <NSObject>

- (void)goodDetailDidAddToCart;
- (void)goodDetailDidGoCart;
- (void)goodDetailDidGoBuy;

@end

@interface GoodDetailBottomView : UIView

@property (nonatomic, assign)id<GoodDetailBottomDelegate>delegate;

@end

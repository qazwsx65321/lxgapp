//
//  Ocean_WithMoneyView.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_WithMoneyViewdelegate <NSObject>

-(void)judgeInputRight:(BOOL)isRight andText:(NSString *)money;

@end

@interface Ocean_WithMoneyView : UIView

@property (nonatomic,weak) id<Ocean_WithMoneyViewdelegate> delegate;

@property (nonatomic,weak) UILabel * p_lable2;


-(void)setCommissionCharge:(NSString *)money;

@end

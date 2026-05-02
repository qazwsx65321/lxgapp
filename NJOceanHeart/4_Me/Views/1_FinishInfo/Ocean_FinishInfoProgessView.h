//
//  Ocean_FinishInfoProgessView.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_FinishInfoProgessView : UIView

- (instancetype)initWithFrame:(CGRect)frame andCardTitle:(NSArray *)titleArr andNavtionVC:(UINavigationController *)nav;

-(void)setProgress:(NSUInteger)tag;

@end

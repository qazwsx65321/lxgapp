//
//  GoodDetailHeaderView.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodDetailHeaderDelegate <NSObject>

- (void)headerButtonDidPressed:(NSInteger)index;

@end

@interface GoodDetailHeaderView : UIView

@property (nonatomic, assign)id<GoodDetailHeaderDelegate>delegate;

@end

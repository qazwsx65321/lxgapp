//
//  Ocean_NewsHeaderView.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_NewsHeaderViewDelegate <NSObject>

- (void)didNewsWithType:(NSString *)type;

@end

@interface Ocean_NewsHeaderView : UIView

@property (nonatomic,assign) id<Ocean_NewsHeaderViewDelegate>delegate;

@end

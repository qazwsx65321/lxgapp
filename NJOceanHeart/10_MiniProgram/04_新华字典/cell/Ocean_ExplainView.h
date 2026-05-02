//
//  Ocean_ExplainView.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_ExplainView : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;

@property (nonatomic,assign) float lineSpace;

- (instancetype)initWithFrame:(CGRect)frame withContentHight:(CGFloat)contentHight;

@end

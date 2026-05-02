//
//  Ocean_FirstPageHeadView.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_FirstPageHeadViewDelegate <NSObject>

-(void)headviewClickMoreMethod;

@end

@interface Ocean_FirstPageHeadView : UICollectionReusableView
@property (nonatomic,strong) NSDictionary * p_info;
@property (nonatomic,weak) id<Ocean_FirstPageHeadViewDelegate>delegate;

@end

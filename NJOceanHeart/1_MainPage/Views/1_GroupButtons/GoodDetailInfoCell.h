//
//  GoodDetailInfoCell.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodDetailRespBody, GoodSpecModel;

@protocol GoodDetailInfoDelegate <NSObject>

- (void)goodDetailInfoDidSelectedItem:(GoodSpecModel *)spec;

@end

@interface GoodDetailInfoCell : UITableViewCell


@property (nonatomic, strong)GoodDetailRespBody *goodDetail;

@end

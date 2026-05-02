//
//  Ocean_ GoodsStandardCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodDetailBody.h"
@class JCTagListView;
@protocol Ocean_GoodsStandardCellDelegate <NSObject>

- (void)StandardCellInfoDidSelectedItem:(GoodSpecModel *)spec;

-(void)standardCellGetstandardNum:(CGFloat)standardH;

@end

@interface Ocean_GoodsStandardCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)GoodDetailRespBody *goodDetail;
@property (nonatomic, assign)id<Ocean_GoodsStandardCellDelegate>delegate;


@end

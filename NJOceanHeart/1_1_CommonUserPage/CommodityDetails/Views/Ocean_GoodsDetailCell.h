//
//  Ocean_GoodsDetailCell.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_GoodsDetailModel.h"
@interface Ocean_GoodsDetailCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)Ocean_GoodsDetailModel *model;

@end

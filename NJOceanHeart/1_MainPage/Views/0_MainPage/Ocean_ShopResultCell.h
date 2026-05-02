//
//  Ocean_ShopResultCell.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_ShopResultModel.h"
@interface Ocean_ShopResultCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)Ocean_ShopResultModel *model;

@end

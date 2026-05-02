//
//  Ocean_HotListCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ocean_HotGoodsModel;
@interface Ocean_HotListCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) Ocean_HotGoodsModel * good;
@end

//
//  Ocean_ShopAddressCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopAddressModel;
@interface Ocean_ShopAddressCell : UITableViewCell
@property (nonatomic,strong) ShopAddressModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

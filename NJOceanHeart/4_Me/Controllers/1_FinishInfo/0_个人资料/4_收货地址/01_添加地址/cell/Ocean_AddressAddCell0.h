//
//  Ocean_AddressAddCell0.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddAddressModel;
@interface Ocean_AddressAddCell0 : UITableViewCell

@property (nonatomic,strong) AddAddressModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

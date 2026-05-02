//
//  Ocean_StoreIDCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_EnterStoreModel.h"
@interface Ocean_StoreIDCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) Ocean_EnterStoreModel * model;

@property (nonatomic,strong) NSDictionary * p_accInfo;

@property (nonatomic,weak) UIViewController *vc;

@end

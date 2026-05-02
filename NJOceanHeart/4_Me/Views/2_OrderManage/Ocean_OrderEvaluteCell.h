//
//  Ocean_OrderEvaluteCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_StoreCommodityModel,Ocean_OrderEvaluteModel;
@interface Ocean_OrderEvaluteCell : UITableViewCell

@property (nonatomic,strong) Ocean_OrderEvaluteModel *evalutModel;
@property (nonatomic,strong) Ocean_StoreCommodityModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

//
//  Ocean_TrainLineCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_TrainModel;

@interface Ocean_TrainLineCell : UITableViewCell

@property (nonatomic,strong) Ocean_TrainModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

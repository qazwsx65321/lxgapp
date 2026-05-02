//
//  Ocean_GroupCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Ocean_GroupModel;
@interface Ocean_GroupCell : UITableViewCell


@property (nonatomic,strong) Ocean_GroupModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

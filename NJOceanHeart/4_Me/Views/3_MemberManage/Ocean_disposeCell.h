//
//  Ocean_disposeCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/24.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ocean_DespositDetailModel;
@interface Ocean_disposeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) Ocean_DespositDetailModel * model;

@end

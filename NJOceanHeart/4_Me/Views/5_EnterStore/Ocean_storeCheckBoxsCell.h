//
//  Ocean_storeCheckBoxsCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/4.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ocean_EnterStoreModel;
@interface Ocean_storeCheckBoxsCell : UITableViewCell

@property (nonatomic,strong) Ocean_EnterStoreModel * model;

@property (nonatomic,strong) NSDictionary * p_accInfo;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

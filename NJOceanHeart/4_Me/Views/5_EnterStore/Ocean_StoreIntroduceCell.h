//
//  Ocean_ StoreIntroduceCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ocean_EnterStoreModel;
@interface Ocean_StoreIntroduceCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) Ocean_EnterStoreModel * model;
@property (nonatomic,strong) NSDictionary * p_accInfo;

@end

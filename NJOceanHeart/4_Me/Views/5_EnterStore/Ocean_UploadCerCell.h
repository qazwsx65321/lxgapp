//
//  Ocean_UploadCerCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/30.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_EnterStoreModel;


@interface Ocean_UploadCerCell : UITableViewCell

@property (nonatomic,strong) Ocean_EnterStoreModel * model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) NSDictionary * p_accInfo;

@end

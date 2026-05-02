//
//  Ocean_cardInfoCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ocean_CarInfoModel,Ocean_PersonageInfoModel;
@interface Ocean_cardInfoCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) Ocean_CarInfoModel * cardinfoModel;
@property (nonatomic,strong)  Ocean_PersonageInfoModel* infoModel;

@end

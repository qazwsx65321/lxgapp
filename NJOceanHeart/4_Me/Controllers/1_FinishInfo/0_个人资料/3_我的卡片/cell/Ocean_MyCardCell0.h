//
//  Ocean_MyCardCell0.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_MyCardModel;
@interface Ocean_MyCardCell0 : UITableViewCell

@property (nonatomic,strong) Ocean_MyCardModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

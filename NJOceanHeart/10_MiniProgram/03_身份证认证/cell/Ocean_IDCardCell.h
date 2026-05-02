//
//  Ocean_IDCardCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_IDCardCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dic;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

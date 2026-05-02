//
//  Ocean_DriveCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_DriveCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dic;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

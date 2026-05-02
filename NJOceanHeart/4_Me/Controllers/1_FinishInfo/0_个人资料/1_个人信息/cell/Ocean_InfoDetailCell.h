//
//  Ocean_InfoDetailCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_InfoDetailCell : UITableViewCell

@property (nonatomic,assign) NSInteger type;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

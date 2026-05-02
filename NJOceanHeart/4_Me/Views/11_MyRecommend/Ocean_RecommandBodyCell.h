//
//  Ocean_RecommandBodyCell.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_RecommandModel.h"
@interface Ocean_RecommandBodyCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)Ocean_RecommandBody *model;
@property (nonatomic, strong)NSArray *titles;
@end

//
//  Ocean_WuLiuLineCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_WuLiuBody;
@interface Ocean_WuLiuLineCell : UITableViewCell

@property (nonatomic,strong) Ocean_WuLiuBody *model;

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger index;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

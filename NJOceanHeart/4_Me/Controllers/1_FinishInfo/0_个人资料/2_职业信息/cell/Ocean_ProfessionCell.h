//
//  Ocean_ProfessionCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_ProfessionCell : UITableViewCell

@property (nonatomic,assign) NSInteger type;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

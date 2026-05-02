//
//  Ocean_InfoHeadCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/25.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_InfoHeadCell : UITableViewCell

@property (nonatomic,copy) NSString *cardImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

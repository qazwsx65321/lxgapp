//
//  Ocean_PersonageInfoCell1.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_PersonageInfoCell1 : UITableViewCell

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) NSString *nameText;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

//
//  Ocean_MyCardCell2.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Ocean_MyCardModel;
@interface Ocean_MyCardCell2 : UITableViewCell

@property (nonatomic,strong) Ocean_MyCardModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

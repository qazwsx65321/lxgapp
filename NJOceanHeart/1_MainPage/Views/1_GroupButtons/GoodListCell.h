//
//  GoodListCell.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodListModel, SearchModel;

@interface GoodListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)GoodListModel *good;
@property (nonatomic, strong)SearchModel *searchGood;

@property (nonatomic, copy)NSString *thumbImage;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *count;

@end

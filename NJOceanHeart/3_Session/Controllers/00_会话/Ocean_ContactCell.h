//
//  Ocean_ContactCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_FriendsModel;

@interface Ocean_ContactCell : UITableViewCell

@property (nonatomic,strong) Ocean_FriendsModel *model;

@property (nonatomic,assign) BOOL isTongXun; //判断是否是通讯录界面的

@property (nonatomic,assign) BOOL isSelect;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

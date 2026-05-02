//
//  Ocean_SearchFriendCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/20.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_SearchModel,ContactModel;
@interface Ocean_SearchFriendCell : UITableViewCell

@property (nonatomic,strong) Ocean_SearchModel *model;

@property (nonatomic,strong) ContactModel *contactmodel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

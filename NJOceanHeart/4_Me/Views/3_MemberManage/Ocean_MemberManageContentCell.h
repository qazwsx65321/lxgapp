//
//  Ocean_MemberManageContentCell.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_memberManageModel.h"
@interface Ocean_MemberManageContentCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) Ocean_memberManageModel * model;

@end

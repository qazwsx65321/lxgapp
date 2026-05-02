//
//  Ocean_MemberManageHeadCell.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemberHeadDelegate <NSObject>

- (void)manageDidBack;
- (void)manageDidSetup;
- (void)manageDidRecharge;
- (void)manageDidWithdraw;

@end

@interface Ocean_MemberManageHeadCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, assign)id<MemberHeadDelegate>delegate;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *cashLabel;
@end

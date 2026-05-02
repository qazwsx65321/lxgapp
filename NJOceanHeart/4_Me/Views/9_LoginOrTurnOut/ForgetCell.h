//
//  ForgetCell.h
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/17.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForgetCell;

@protocol ForgetCellDelegate <NSObject>

@optional
- (void)didNextStep:(ForgetCell *)cell;

@end

@interface ForgetCell : UITableViewCell

@property (nonatomic,assign) id<ForgetCellDelegate>delegate;

@property (nonatomic,assign) BOOL isForget;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

//
//  RegistCell1.h
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/17.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistCell1;

@protocol RegistCell1Delegate <NSObject>

@optional
- (void)didRegist:(RegistCell1 *)cell;

@end

@interface RegistCell1 : UITableViewCell

@property (nonatomic,assign) id<RegistCell1Delegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

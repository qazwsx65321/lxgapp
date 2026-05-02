//
//  RegistCell0.h
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/14.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistCell0;
@protocol RegistCell0Delegate <NSObject>

- (void)didSelectCar:(RegistCell0 *)cell withIndex:(NSInteger)index;

@end

@interface RegistCell0 : UITableViewCell

@property (nonatomic,assign) id<RegistCell0Delegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

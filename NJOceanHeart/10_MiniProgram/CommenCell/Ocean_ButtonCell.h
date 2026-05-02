//
//  Ocean_ButtonCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_ButtonCell;
@protocol Ocean_ButtonCellDelegate <NSObject>

- (void)didInquiry:(Ocean_ButtonCell *)cell;

@end

@interface Ocean_ButtonCell : UITableViewCell

@property (nonatomic,assign) id<Ocean_ButtonCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

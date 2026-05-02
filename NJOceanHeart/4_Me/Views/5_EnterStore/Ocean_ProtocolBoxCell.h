//
//  Ocean_ProtocolBoxCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol Ocean_ProtocolBoxCellDelegate <NSObject>

-(void)ProtocolBoxCellClickButton:(UIButton *)sender;

@end

@interface Ocean_ProtocolBoxCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id<Ocean_ProtocolBoxCellDelegate> delegate;

@end

//
//  Ocean_ChooseTypePayCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_ChooseTypePayCellDelegate <NSObject>

-(void)Ocean_ChooseTypePayCellChoosePay:(NSInteger)tag;

@end

@interface Ocean_ChooseTypePayCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id<Ocean_ChooseTypePayCellDelegate> delegate;

@end

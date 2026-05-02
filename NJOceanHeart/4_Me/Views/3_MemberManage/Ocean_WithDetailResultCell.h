//
//  Ocean_WithDetailResultCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/24.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_WithDetailResultCellDelegate <NSObject>

-(void)Ocean_WithDetailResultCellClickResonButton;

@end

@interface Ocean_WithDetailResultCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * m_dic;
@property (nonatomic,weak) id<Ocean_WithDetailResultCellDelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end

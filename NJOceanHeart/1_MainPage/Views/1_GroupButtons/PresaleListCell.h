//
//  PresaleListCell.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/30.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PresaleModel;

@interface PresaleListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)PresaleModel *good;

//@property (nonatomic, copy)NSString *thumbImage;
//@property (nonatomic, copy)NSString *name;
//@property (nonatomic, copy)NSString *price;
//@property (nonatomic, copy)NSString *count;

@end

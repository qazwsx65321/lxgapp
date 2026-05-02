//
//  MeHeaderCell.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/27.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeHeaderCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy)NSString *headpicture;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)UILabel *messageLb;

@end

//
//  GoodCommentCell.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodDetailCommentModel;

@interface GoodCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)GoodDetailCommentModel *comment;

@end

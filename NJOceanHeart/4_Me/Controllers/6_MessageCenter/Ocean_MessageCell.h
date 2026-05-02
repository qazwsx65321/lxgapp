//
//  Ocean_MessageCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_MessageFrame;
@interface Ocean_MessageCell : UITableViewCell

@property (nonatomic,strong) Ocean_MessageFrame *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end




@interface Ocean_MessageFrame : NSObject

@property (nonatomic,strong) NSDictionary *infoDic;

@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect picImageViewF;
@property (nonatomic,assign) CGRect titleLabelF;
@property (nonatomic,assign) CGRect stateLabelF;
@property (nonatomic,assign) CGRect contentLabelF;
@property (nonatomic,assign) CGFloat cellHeight;

@end

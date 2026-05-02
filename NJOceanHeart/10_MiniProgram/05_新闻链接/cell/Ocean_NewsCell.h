//
//  Ocean_NewsCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_DataModel.h"

@class Ocean_NewsFrame,Ocean_NewsBody;

@interface Ocean_NewsCell : UITableViewCell

@property (nonatomic,strong) Ocean_NewsFrame *cellframes;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end


@interface Ocean_NewsFrame : NSObject

@property (nonatomic,strong) Ocean_NewsBody *model;

@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect titleLabelF;
@property (nonatomic,assign) CGRect ima0F;
@property (nonatomic,assign) CGRect ima1F;
@property (nonatomic,assign) CGRect ima2F;
@property (nonatomic,assign) CGRect nameLabelF;
@property (nonatomic,assign) CGRect timeLabelF;

@end

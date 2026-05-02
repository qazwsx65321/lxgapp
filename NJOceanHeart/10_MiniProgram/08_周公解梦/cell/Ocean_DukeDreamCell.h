//
//  Ocean_DukeDreamCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Ocean_DataModel.h"

@class Ocean_DukeDreamFrame;
@interface Ocean_DukeDreamCell : UITableViewCell

@property (nonatomic,strong) Ocean_DukeDreamFrame *cellframes;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end


@interface Ocean_DukeDreamFrame : NSObject

@property (nonatomic,strong) Ocean_JieMengModel *model;

@property (nonatomic,copy) NSString *XD_content;

@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect titleLabelF;
@property (nonatomic,assign) CGRect explainLabelF;

@end

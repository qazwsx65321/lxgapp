//
//  Ocean_XinHuaCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_XinHuaFrames;
@interface Ocean_XinHuaCell : UITableViewCell

@property (nonatomic,strong) Ocean_XinHuaFrames *cellframes;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end


@interface Ocean_XinHuaFrames : NSObject

@property (nonatomic,strong) NSMutableArray *hightArray;
@property (nonatomic,strong) NSDictionary *dic;

@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect nameLabelF;
@property (nonatomic,assign) CGRect pinyinLabelF;
@property (nonatomic,assign) CGRect bihuaLabelF;
@property (nonatomic,assign) CGRect bushouLabelF;
@property (nonatomic,assign) CGRect jiegouLabelF;
@property (nonatomic,assign) CGRect bishunLabelF;
@property (nonatomic,assign) CGRect wubiLabelF;
@property (nonatomic,assign) CGRect englishLabelF;
@property (nonatomic,assign) CGRect explainLabelF;

@end

//
//  Ocean_DisHonestCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ocean_DataModel.h"

@class Ocean_DisHonestFrame;
@interface Ocean_DisHonestCell : UITableViewCell

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *idnum;

@property (nonatomic,strong) Ocean_DisHonestFrame *cellframes;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface Ocean_DisHonestFrame : NSObject

@property (nonatomic,strong) Ocean_ShiXinBody *model;

@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect nameLabelF;
@property (nonatomic,assign) CGRect idLabelF;
@property (nonatomic,assign) CGRect ageLabelF;
@property (nonatomic,assign) CGRect sexLabelF;
@property (nonatomic,assign) CGRect filingdateLabelF;
@property (nonatomic,assign) CGRect casenoLabelF;
@property (nonatomic,assign) CGRect baseonnoLabelF;
@property (nonatomic,assign) CGRect baseonorgLabelF;
@property (nonatomic,assign) CGRect courtLabelF;
@property (nonatomic,assign) CGRect provinceLabelF;
@property (nonatomic,assign) CGRect dutyLabelF;
@property (nonatomic,assign) CGRect performanceLabelF;
@property (nonatomic,assign) CGRect descriptionLabelF;
@property (nonatomic,assign) CGRect pubdateLabelF;

@end

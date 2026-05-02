//
//  Ocean_ZhiNengQuestionCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_ZhiNengQuestionFrame;
@interface Ocean_ZhiNengQuestionCell : UITableViewCell

@property (nonatomic,strong) Ocean_ZhiNengQuestionFrame *cellframes;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface Ocean_ZhiNengQuestionFrame : NSObject

@property (nonatomic,strong) NSDictionary *dic;

@property (nonatomic,assign) CGRect typeLabelF;
@property (nonatomic,assign) CGRect replyLabelF;
@property (nonatomic,assign) CGRect contentLabelF;
@property (nonatomic,assign) CGRect relquestionLabelF;
@property (nonatomic,assign) CGFloat cellhight;

@end

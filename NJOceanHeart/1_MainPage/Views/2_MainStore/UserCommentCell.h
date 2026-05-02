//
//  UserCommentCell.h
//  Glad9TM
//
//  Created by 陈志伟 on 17/6/8.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserCommentModel,MeStarRateView,UserCommentFrame;

@interface UserCommentCell : UITableViewCell

@property (nonatomic,strong) UserCommentFrame *XD_frame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface UserCommentFrame : NSObject

@property (nonatomic,strong) UserCommentModel *model;

@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect XD_headPicF;
@property (nonatomic,assign) CGRect XD_nameLabelF;
@property (nonatomic,assign) CGRect XD_timeLabelF;
@property (nonatomic,assign) CGRect XD_contentLabelF;
@property (nonatomic,assign) CGRect photoViewF;
@property (nonatomic,assign) CGRect XD_starViewF;
@property (nonatomic,assign) CGFloat cellHeight;

@end

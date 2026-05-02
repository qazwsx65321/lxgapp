//
//  Ocean_OrderDetailCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_OrderDetailHead,Ocean_OrderDetailFrame;
@interface Ocean_OrderDetailCell : UITableViewCell

@property (nonatomic,strong) Ocean_OrderDetailFrame *cellFrame;

@property (nonatomic,copy) NSString *state;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end


@interface Ocean_OrderDetailFrame : NSObject

@property (nonatomic,strong) Ocean_OrderDetailHead *model;

@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect titleLabelF;
@property (nonatomic,assign) CGRect payWayLabelF;
@property (nonatomic,assign) CGRect lineF;
@property (nonatomic,assign) CGRect nameLabelF;
@property (nonatomic,assign) CGRect phoneLabelF;
@property (nonatomic,assign) CGRect addressLabelF;
@property (nonatomic,assign) CGRect stateLabelF;
@property (nonatomic,assign) CGFloat cellHeight;

@end





@class Ocean_OrderDetailBodyCell,Ocean_OrderDetailModel,Ocean_OrderDetailBodyFrame;

@protocol Ocean_OrderDetailBodyCellDelegate <NSObject>

@optional
- (void)didQuitClick:(Ocean_OrderDetailBodyCell *)cell;

@end

@interface Ocean_OrderDetailBodyCell : UITableViewCell

@property (nonatomic,assign) id<Ocean_OrderDetailBodyCellDelegate>delegate;
@property (nonatomic,strong) Ocean_OrderDetailBodyFrame *cellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface Ocean_OrderDetailBodyFrame : NSObject

@property (nonatomic,strong) Ocean_OrderDetailModel * model;
@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect picImageViewF;
@property (nonatomic,assign) CGRect titleLabelF;
@property (nonatomic,assign) CGRect infoLabelF;
@property (nonatomic,assign) CGRect priceLabelF;
@property (nonatomic,assign) CGRect numLabelF;
@property (nonatomic,assign) CGRect quitButtonF;
@property (nonatomic,assign) CGRect lineF;
@property (nonatomic,assign) CGFloat cellHeight;

@end


@class Ocean_OrderDetailFootCell;
@protocol Ocean_OrderDetailFootCellDelegate <NSObject>

- (void)lookWuliu:(Ocean_OrderDetailFootCell *)cell;

@end

@interface Ocean_OrderDetailFootCell : UITableViewCell

@property (nonatomic,assign) id<Ocean_OrderDetailFootCellDelegate>delegate;

@property (nonatomic,strong) Ocean_OrderDetailHead *model;

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *orderno;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end






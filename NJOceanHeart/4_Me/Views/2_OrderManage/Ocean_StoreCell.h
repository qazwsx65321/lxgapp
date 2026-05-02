//
//  Ocean_StoreCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_StoreCommodityModel ,Ocean_StoreOrderModel;
@interface Ocean_StoreCell : UITableViewCell

@end


//头部
@interface Ocean_StoreHeadCell : Ocean_StoreCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,assign) BOOL isHideState;

@property (nonatomic,strong) Ocean_StoreOrderModel * orderModel;


@end




//商品列表
@class Ocean_StoreBodyFrame;
@interface Ocean_StoreBodyCell : Ocean_StoreCell
@property (nonatomic,strong) Ocean_StoreBodyFrame * cellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
//商品列表--计算cell高度
@interface Ocean_StoreBodyFrame : NSObject

@property (nonatomic,strong) Ocean_StoreCommodityModel * model;
@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect picImageViewF;
@property (nonatomic,assign) CGRect titleLabelF;
@property (nonatomic,assign) CGRect infoLabelF;
@property (nonatomic,assign) CGRect priceLabelF;
@property (nonatomic,assign) CGRect numLabelF;
@property (nonatomic,assign) CGRect lineF;
@property (nonatomic,assign) CGFloat cellHeight;


@end


//尾部
@class Ocean_StoreFootFrame,Ocean_StoreFootCell;

@protocol Ocean_StoreFootCellDelegate <NSObject>

@optional
- (void)didCancelClickCell:(Ocean_StoreFootCell *)cell;
- (void)didPayMoneyClickCell:(Ocean_StoreFootCell *)cell;
- (void)didQuitGetGoodsClickCell:(Ocean_StoreFootCell *)cell;
- (void)didSureGetGoodsClickCell:(Ocean_StoreFootCell *)cell;
- (void)didEvaluateClickCell:(Ocean_StoreFootCell *)cell;

@end

@interface Ocean_StoreFootCell : Ocean_StoreCell

@property (nonatomic,copy) NSString *goodsNum;

@property (nonatomic,assign) id<Ocean_StoreFootCellDelegate>delegate;
@property (nonatomic,strong) Ocean_StoreFootFrame * cellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
//尾部--计算cell高度
@class Ocean_StoreOrderModel;
@interface Ocean_StoreFootFrame : NSObject

@property (nonatomic,strong) Ocean_StoreOrderModel * model;
@property (nonatomic,strong) NSArray * bodyFramArr;
@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect totalLabelF;
@property (nonatomic,assign) CGRect cancelButtonF;
@property (nonatomic,assign) CGRect rightButtonF;
@property (nonatomic,assign) CGFloat cellHeight;

@end





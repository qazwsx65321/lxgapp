//
//  ChoseView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"
#import "BuyCountView.h"
#import "Ocean_AddCartModel.h"
@interface ChoseView : UIView<UITextFieldDelegate,UIAlertViewDelegate,TypeSeleteDelegete>
@property(nonatomic, retain)UIView *alphaiView;
@property(nonatomic, retain)UIView *whiteView;

@property(nonatomic, retain)UIImageView *img;

@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain)TypeView *sizeView;
@property(nonatomic, retain)TypeView *colorView;
@property(nonatomic, retain)BuyCountView *countView;

@property(nonatomic, retain)UIButton *bt_sure;
@property(nonatomic, retain)UIButton *bt_cancle;

@property(nonatomic)NSArray *sizearr;
@property(nonatomic)NSArray *colorarr;
@property(nonatomic)NSDictionary *stockdic;
@property(nonatomic) int stock;

@property (nonatomic, strong)Ocean_AddCartModel *model;
-(void)initTypeView:(NSArray *)sizeArr :(NSArray *)colorArr :(NSDictionary *)stockDic :(NSString *)imgUrl;
@end

//
//  Ocean_AddressListCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_AddressListCell,MyAddressModel,Ocean_AddressListFrame;
@protocol Ocean_AddressListCellDelegate <NSObject>

@optional
- (void)didDefaultAddress:(Ocean_AddressListCell *)cell;
- (void)didEditAddress:(Ocean_AddressListCell *)cell;
- (void)didDeleteAddress:(Ocean_AddressListCell *)cell;

@end

@interface Ocean_AddressListCell : UITableViewCell

@property (nonatomic,strong) Ocean_AddressListFrame *cellFrame;
@property (nonatomic,assign) id<Ocean_AddressListCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end


@interface Ocean_AddressListFrame : NSObject

@property (nonatomic,strong) MyAddressModel *model;
@property (nonatomic,assign) CGRect bgViewF;
@property (nonatomic,assign) CGRect nameLabelF;
@property (nonatomic,assign) CGRect phoneLabelF;
@property (nonatomic,assign) CGRect addressLabelF;
@property (nonatomic,assign) CGRect selectBtnF;
@property (nonatomic,assign) CGRect editBtnF;
@property (nonatomic,assign) CGRect deleteBtnF;
@property (nonatomic,assign) CGFloat cellHeight;

@end

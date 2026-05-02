//
//  Ocean_AddressAddCell1.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDTextView,AddAddressModel,Ocean_AddressAddCell1;

@protocol Ocean_AddressAddCell1Delegate <NSObject>

- (void)didDeleteAddress:(Ocean_AddressAddCell1 *)cell;

@end

@interface Ocean_AddressAddCell1 : UITableViewCell

@property (nonatomic,assign) id<Ocean_AddressAddCell1Delegate>delegate;

@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,strong) AddAddressModel *model;

@property (nonatomic,strong) XDTextView *textView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

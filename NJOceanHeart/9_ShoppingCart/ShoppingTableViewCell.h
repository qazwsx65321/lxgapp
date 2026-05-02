//
//  ShoppingTableViewCell.h
//  TDS
//
//  Created by 黎金 on 16/3/24.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingBtn.h"
#import "Ocean_ ShowCartModel.h"
@protocol ShoppingTableViewCellDelegate <NSObject>

-(void)ShoppingTableViewCell:(Ocean__ShowCartGoodsModel *)model;

@end
@interface ShoppingTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ShoppingTableViewCellDelegate>delegate;


@property (nonatomic, strong) Ocean__ShowCartGoodsModel *model;


@end

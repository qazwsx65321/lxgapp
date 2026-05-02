//
//  MeOrderCell.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/27.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeOrderCell;

@protocol MeOrderDelegate <NSObject>

- (void)meOrderCell:(MeOrderCell *)orderCell didSelectedTpyeAtIndex:(NSInteger)index;

@end

@interface MeOrderCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, assign)id<MeOrderDelegate>delegate;
@property (nonatomic, strong)NSArray *badges;

@end

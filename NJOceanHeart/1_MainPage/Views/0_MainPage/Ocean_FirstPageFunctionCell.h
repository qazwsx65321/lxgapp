//
//  Ocean_FirstPageFunctionCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_FirstPageFunctionCellDelegate <NSObject>

-(void)FunctionCellClickItem:(UIButton *)button andClassinfo:(NSDictionary *)classInfo;

@end

@interface Ocean_FirstPageFunctionCell : UICollectionViewCell

@property (nonatomic,weak) id<Ocean_FirstPageFunctionCellDelegate> delegate;

@property (nonatomic,strong) NSArray * m_groupButtons;

@end

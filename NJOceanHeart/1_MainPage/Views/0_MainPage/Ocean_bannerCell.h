//
//  Ocean_bannerCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ocean_MainPageBannerModel;
@protocol Ocean_bannerCellDelegate <NSObject>

-(void)bannerCellselectItemInfo:(Ocean_MainPageBannerModel *)bannerModel;

@end

@interface Ocean_bannerCell : UICollectionViewCell

@property (nonatomic,strong) NSArray * m_scrollItems;

@property (nonatomic,weak)id<Ocean_bannerCellDelegate>delegate;

@end

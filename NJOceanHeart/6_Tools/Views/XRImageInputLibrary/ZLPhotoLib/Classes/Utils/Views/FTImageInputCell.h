//
//  FTImageInputCell.h
//  X19.HundredSchoolForum
//
//  Created by 史伟文 on 17/1/4.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTImageInputCell : UICollectionViewCell

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;

@property (nonatomic, strong)UIImageView *imageView;

@end

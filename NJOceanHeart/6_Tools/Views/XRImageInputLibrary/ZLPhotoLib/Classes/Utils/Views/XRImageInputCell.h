//
//  XRImageInputCell.h
//  AssertLibraryDemo
//
//  Created by 史伟文 on 15/12/1.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRImageInputCell : UICollectionViewCell

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIButton *deleteimage;
@end

//
//  FTImageInputCell.m
//  X19.HundredSchoolForum
//
//  Created by 史伟文 on 17/1/4.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "FTImageInputCell.h"

@implementation FTImageInputCell

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
    static NSString *cellIdentifier = @"FTImageInputCell";
    FTImageInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[FTImageInputCell alloc] init];
    }
    
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}

@end


//  XRImageInputCell.m
//  AssertLibraryDemo
//
//  Created by 史伟文 on 15/12/1.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import "XRImageInputCell.h"

@interface XRImageInputCell()

@end

@implementation XRImageInputCell

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
    static NSString *cellIdentifier = @"XRImageInputCell";
    XRImageInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XRImageInputCell alloc] init];
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
        
        _deleteimage = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteimage.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1];
        _deleteimage.titleLabel.font = [UIFont fontWithName:Heiti_Medium size:11];
        _deleteimage.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_deleteimage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_imageView addSubview:_deleteimage];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, 70, 70);
    _deleteimage.frame=CGRectMake(0, 50, 70, 20);
}

@end

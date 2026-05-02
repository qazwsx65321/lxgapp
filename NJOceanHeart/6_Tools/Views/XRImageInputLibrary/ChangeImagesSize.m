//
//  ChangeImagesSize.m
//  WorkerPort
//
//  Created by 陈志伟 on 17/2/28.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "ChangeImagesSize.h"

@implementation ChangeImagesSize

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(60, 60);
    
}

@end

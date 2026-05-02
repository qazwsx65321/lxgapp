//
//  Ocean_MainPageLayout.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MainPageLayout.h"

@interface Ocean_MainPageLayout()

@property (nonatomic,strong) UICollectionViewLayoutAttributes * firstLayoutAttr;

@end

@implementation Ocean_MainPageLayout

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    NSArray *attrArr = [[NSArray alloc] initWithArray:array copyItems:YES];

    for (UICollectionViewLayoutAttributes *layoutAttr in attrArr) {
        
        if (layoutAttr.indexPath.section ==3 &&layoutAttr.indexPath.item==0) {
            if (_firstLayoutAttr.frame.origin.y != layoutAttr.frame.origin.y) {
                _firstLayoutAttr = layoutAttr;
            }
        }else if (layoutAttr.indexPath.section ==3){
            
            
            CGRect orRect = layoutAttr.frame;
            CGFloat W = layoutAttr.frame.size.width;
            CGFloat H = (_firstLayoutAttr.frame.size.height -5)/2;
            orRect.origin.x = CGRectGetMaxX(_firstLayoutAttr.frame) + 5 + ((layoutAttr.indexPath.item-1) % 2)*(5+W);
            orRect.origin.y = _firstLayoutAttr.frame.origin.y + ((layoutAttr.indexPath.item -1)/2) *(5+H);
            orRect.size.height = H;
            layoutAttr.frame = orRect;
            
        }
        
    }
    
    return attrArr ;
}



-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return NO;

}

@end

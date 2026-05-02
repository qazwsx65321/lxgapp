//
//  Ocean_SearchTextField.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/9/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_SearchTextField.h"

@implementation Ocean_SearchTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect size = [super leftViewRectForBounds:bounds];
    size.origin.x +=5;
    return size;
}
@end

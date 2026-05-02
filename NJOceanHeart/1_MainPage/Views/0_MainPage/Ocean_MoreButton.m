
//
//  Ocean_MoreButton.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MoreButton.h"

@implementation Ocean_MoreButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.right = self.width;
    self.titleLabel.right = self.imageView.x - 5;
}

@end

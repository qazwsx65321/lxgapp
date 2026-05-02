//
//  Ocean_TMShopView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_TMShopView.h"

@interface  Ocean_TMShopView()

@property (nonatomic,weak) UILabel * p_priceLb;

@end

@implementation Ocean_TMShopView

- (instancetype)init
{
    self = [super init];
    if (self) {
     
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.backgroundColor = RGBA(178, 178, 178, .7);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height *26/150;
    self.titleLabel.bottom = self.height;
}

@end

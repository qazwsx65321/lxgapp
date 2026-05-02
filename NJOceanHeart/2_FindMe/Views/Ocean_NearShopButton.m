//
//  Ocean_NearShopButton.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/25.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_NearShopButton.h"

@implementation Ocean_NearShopButton

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.imageView.x  = self.titleLabel.right +5;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}



+(instancetype)buttonWithType:(UIButtonType)buttonType{
   Ocean_NearShopButton *button = [super buttonWithType:buttonType];
    [button setTitleColor:[UIColor blackColor] forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    return button;
}


@end

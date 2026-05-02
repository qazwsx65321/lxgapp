//
//  Ocean_ZFDropDown.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/25.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ZFDropDown.h"
#import "ZFView.h"
#import "Ocean_NearShopButton.h"
@implementation Ocean_ZFDropDown

- (void)setUpUI{
    [super setUpUI];
    [self.topicButton removeFromSuperview];
    ZFView *topicContainerView = [self valueForKeyPath:@"topicContainerView"];
    self.topicButton = [Ocean_NearShopButton buttonWithType:UIButtonTypeSystem];
    self.topicButton.frame = CGRectMake(10, 0, CGRectGetWidth(topicContainerView.frame) - 20, CGRectGetHeight(topicContainerView.frame));
    [self.topicButton setImage:[UIImage imageNamed:@"Find_more2"] forState:UIControlStateNormal];
    self.topicButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.topicButton addTarget:self action:@selector(beforeShow) forControlEvents:UIControlEventTouchUpInside];
    [topicContainerView addSubview:self.topicButton];
    
}

-(void)beforeShow{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChooseOcean_ZFDropDown" object:self];
}

@end

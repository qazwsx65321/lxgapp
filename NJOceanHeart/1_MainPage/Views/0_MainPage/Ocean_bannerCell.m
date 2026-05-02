//
//  Ocean_bannerCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_bannerCell.h"
#import "SDCycleScrollView.h"
#import "Ocean_MainPageBannerModel.h"

@interface Ocean_bannerCell()<SDCycleScrollViewDelegate>


@property (nonatomic,weak) SDCycleScrollView * p_scrollerview;

@end

@implementation Ocean_bannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        SDCycleScrollView *sdView = [[SDCycleScrollView alloc]init];
        self.p_scrollerview = sdView;
        sdView.localizationImageNamesGroup = @[@"banner"];
        sdView.delegate = self;
        sdView.currentPageDotColor = BackgroundColors(1);
        [self addSubview:sdView];
        
    }
    return self;
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(bannerCellselectItemInfo:)]) {
        [self.delegate bannerCellselectItemInfo:self.m_scrollItems[index]];
    }

}

-(void)setM_scrollItems:(NSArray *)m_scrollItems{
    if (_m_scrollItems !=m_scrollItems) {
        _m_scrollItems = m_scrollItems;
        NSMutableArray *mutalArr = [NSMutableArray array];
        for (Ocean_MainPageBannerModel *model in m_scrollItems) {
            [mutalArr addObject:model.m_headpiclist];
        }
        self.p_scrollerview.imageURLStringsGroup = mutalArr;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.p_scrollerview.frame = self.bounds;
}


@end

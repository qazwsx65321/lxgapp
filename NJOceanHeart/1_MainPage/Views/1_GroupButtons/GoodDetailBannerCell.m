//
//  GoodDetailBannerCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodDetailBannerCell.h"
#import "SDCycleScrollView.h"

@interface GoodDetailBannerCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;

@end

@implementation GoodDetailBannerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"GoodDetailBannerCell";
    GoodDetailBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GoodDetailBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        // 绘制底图
        [self setupCellView];
        
    }
    return self;
}

- (void)setupCellView
{
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@""]];
    [_backView addSubview:_cycleScrollView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backView.width = self.width;
    _backView.height = self.height - 2;
    _backView.x = 0;
    _backView.y = 0;
    
    _cycleScrollView.width = _backView.width;
    _cycleScrollView.height = _backView.height;
    _cycleScrollView.x = 0;
    _cycleScrollView.y = 0;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    _cycleScrollView.imageURLStringsGroup = images;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

@end

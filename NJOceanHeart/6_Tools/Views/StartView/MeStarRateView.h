//
//  MeStarRateView.h
//  ZHDApp
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 czw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeStarRateView;
@protocol MeStarRateViewDelegate <NSObject>

@optional
-(void)starRateView:(MeStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScrorePercent;

@end

@interface MeStarRateView : UIView

@property (nonatomic,assign) CGFloat scorePercent;//得分值，范围为0-1，默认值为1
@property (nonatomic,assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic,assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic,copy) NSString *lightStar;
@property (nonatomic,copy) NSString *darkStar;

@property (nonatomic,weak) id<MeStarRateViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars andLightStar:(NSString *)lightStar andDarkStar:(NSString *)darkStar;

@end

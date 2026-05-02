//
//  MeStarRateView.m
//  ZHDApp
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 czw. All rights reserved.
//

#import "MeStarRateView.h"

#define DEFALUT_STAR_NUMER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface MeStarRateView ()

@property (nonatomic,strong) UIView *foregroundStartView;
@property (nonatomic,strong) UIView *backgroundStartView;
@property (nonatomic,assign) NSInteger numberOfStars;

@end

@implementation MeStarRateView

#pragma mark----Ina=it Methods
-(instancetype)init
{
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMER andLightStar:nil andDarkStar:nil];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _numberOfStars = DEFALUT_STAR_NUMER;
        
        [self buildDataAndUI];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars andLightStar:(NSString *)lightStar andDarkStar:(NSString *)darkStar
{
    if (self = [super initWithFrame:frame])
    {
        _numberOfStars = numberOfStars;
        _lightStar = lightStar;
        _darkStar = darkStar;
        
        [self buildDataAndUI];
    }
    return self;
}


#pragma mark----Private Methods
-(void)buildDataAndUI
{
    _scorePercent = 1; //默认为1
    _hasAnimation = NO; //默认为NO
    _allowIncompleteStar = NO; //默认为NO
    
    self.foregroundStartView = [self createStarViewWithImage:_lightStar];
    self.backgroundStartView = [self createStarViewWithImage:_darkStar];
    
    [self addSubview:self.backgroundStartView];
    [self addSubview:self.foregroundStartView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

-(void)userTapRateView:(UITapGestureRecognizer *)gesture
{
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offSet = tapPoint.x;
    CGFloat realStarScore = offSet / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceil(realStarScore);
    self.scorePercent = starScore / self.numberOfStars;
}

-(UIView *)createStarViewWithImage:(NSString *)imageName
{
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < _numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    __weak MeStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
       
        weakSelf.foregroundStartView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
}

#pragma mark----Get and Set Methods
-(void)setScorePercent:(CGFloat)scorePercent
{
    if (_scorePercent == scorePercent)
    {
        return;
    }
    
    if (scorePercent < 0)
    {
        _scorePercent = 0;
    }
    else if (scorePercent > 1)
    {
        _scorePercent = 1;
    }
    else
    {
        _scorePercent = scorePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)])
    {
        [self.delegate starRateView:self scroePercentDidChange:scorePercent];
    }
    [self setNeedsLayout];
}

@end

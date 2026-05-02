//
//  autoScrollUpAndDown.m
//  XRElectricMall
//
//  Created by qiushi on 2016/10/8.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import "autoScrollUpAndDown.h"
#import "Ocean_FIRSTPAGESHOWModel.h"
@interface autoScrollUpAndDown()<CAAnimationDelegate>
{
    NSArray *arr;
    NSInteger num;
    BOOL isChange;
    NSInteger realNum ;
}

@property(nonatomic,weak)UIImageView *p_imageV;
@property(nonatomic,assign)NSInteger msgCount;
@property(nonatomic,strong)UILabel *scrollLabel;
@property(nonatomic,strong)NSTimer *p_timer;

@end

@implementation autoScrollUpAndDown


-(NSTimer *)p_timer{
    if(!_p_timer){
        _p_timer = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(layerAnmintion) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_p_timer forMode:NSRunLoopCommonModes];
    
    }
    return _p_timer;
}

-(UILabel *)scrollLabel{
    
    if (!_scrollLabel) {
        _scrollLabel = [[UILabel alloc]init];
        _scrollLabel.x = 0;
        _scrollLabel.width = self.width;
        _scrollLabel.height = 17;
        _scrollLabel.font = [UIFont fontWithName:Heiti_Light size:13];
        _scrollLabel.y =self.height;
        _scrollLabel.layer.shadowOffset = CGSizeMake(0, 5);
        _scrollLabel.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _scrollLabel.layer.shadowOpacity = 0.8;
        [self addSubview:_scrollLabel];

    }
    return _scrollLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isChange = YES;
        self.layer.masksToBounds  = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
        [self addGestureRecognizer:pan];
    }
    return self;
}



-(void)click{
    
 [[NSNotificationCenter defaultCenter]postNotificationName:@"ScorllerInfoArr" object:self.m_infoArr[realNum]];
}

-(void)setM_infoArr:(NSArray *)m_infoArr{
    _m_infoArr = m_infoArr;
    NSMutableArray *arrs = [NSMutableArray array];
    
    for (announcementModel*model in m_infoArr) {
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:model.m_title];
        [arrs addObject:attribute];
    }

//    //测试
//    NSMutableAttributedString *attribute1 = [[NSMutableAttributedString alloc]initWithString:@"11111111"];
//    [arrs addObject:attribute1];
//    
//    NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc]initWithString:@"22222222"];
//    [arrs addObject:attribute2];
//    
//    
//    NSMutableAttributedString *attribute3 = [[NSMutableAttributedString alloc]initWithString:@"3333333"];
//    [arrs addObject:attribute3];
//    
//    
//    NSMutableAttributedString *attribute4 = [[NSMutableAttributedString alloc]initWithString:@"4444444"];
//    [arrs addObject:attribute4];
//    
//    
//    NSMutableAttributedString *attribute5 = [[NSMutableAttributedString alloc]initWithString:@"555555"];
//    [arrs addObject:attribute5];
//    
//    //测试
//    
    _m_infoArr = arrs;
    [self.p_timer invalidate];
    self.p_timer = nil;
    [self.p_timer fire];
    
}






-(void)layerAnmintion{

    [self.scrollLabel.layer removeAnimationForKey:@"MyTextLayer1"];

    
    if (!_m_infoArr.count) {
        return;
    }
    if (num>=self.m_infoArr.count) {
        num = 0;
    }
    realNum = num %self.m_infoArr.count;
    self.scrollLabel.attributedText = self.m_infoArr[realNum];
    num++;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation1.duration = .5;
    animation1.fromValue =@(self.height +self.height/2);
    animation1.toValue = @(self.height/2);
    animation1.fillMode=kCAFillModeForwards ;
    [animation1 setBeginTime:0.0];
    
    //由于第一段动画和第二段动画滚动的距离不一样，为了让两个动画看起速度一样，动画的执行时间需要计算一下，公式为 Time1/Time2 = Distance1/Distance2**
    CFTimeInterval animationDurantion2 = 1;
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation2.duration = animationDurantion2;
    animation2.fromValue =  @(self.height/2);
    animation2.toValue = @(-self.scrollLabel.height/2);
    animation2.fillMode=kCAFillModeForwards ;
    [animation2 setBeginTime:1.5];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2];
    group.duration = 2.5;
    group.removedOnCompletion = NO;
    group.fillMode=kCAFillModeForwards ;
    group.repeatCount = 1;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction       functionWithName:kCAMediaTimingFunctionLinear];
    [self.scrollLabel.layer addAnimation:group forKey:@"MyTextLayer1"];
}



//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//        if (!_m_infoArr.count) {
//            return;
//        }
//        if (num>=self.m_infoArr.count) {
//            num = 0;
//        }
//        realNum = num %self.m_infoArr.count;
//        self.scrollLabel.attributedText = self.m_infoArr[realNum];
//        num++;
//        [self layerAnmintion];
//        NSLog(@"%d",flag);
//}



@end

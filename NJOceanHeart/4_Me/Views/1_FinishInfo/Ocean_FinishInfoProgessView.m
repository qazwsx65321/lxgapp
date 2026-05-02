//
//  Ocean_FinishInfoProgessView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FinishInfoProgessView.h"

@interface Ocean_FinishInfoProgessView()<UINavigationControllerDelegate>
{
    CGFloat itemW;
    NSInteger initialIndex;
    BOOL isFirstNav;
}

@property (nonatomic,weak) UIView * p_linv;
@property (nonatomic,strong) NSMutableArray * p_itemArr;
@property (nonatomic,weak) UINavigationController * p_nav;

@end

@implementation Ocean_FinishInfoProgessView

- (instancetype)initWithFrame:(CGRect)frame andCardTitle:(NSArray *)titleArr andNavtionVC:(UINavigationController *)nav
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        itemW = self.width/titleArr.count;
        _p_itemArr = [NSMutableArray array];
        for (int i = 0; i<titleArr.count; i++) {
            NSString *title = titleArr[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:0];
            [button setTitleColor:RGB(243, 170, 83) forState:UIControlStateSelected];
            [button setTitleColor:[UIColor blackColor] forState:0];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:button];
            button.width = itemW;
            button.height = self.height;
            button.x = i *itemW;
            button.tag = i+100;
            [_p_itemArr  addObject:button];
        }
        UIView *lineV = [[UIView alloc]init];
        lineV.height = 2;
        lineV.width = self.width/titleArr.count;
        lineV.backgroundColor = RGB(243, 170, 83);
        self.p_linv = lineV;
        lineV.bottom = self.height;
        [self addSubview:lineV];
        nav.delegate = self;
        self.p_nav = nav;
    }
    return self;
}

-(void)dealloc{
    self.p_nav.delegate = nil;
    NSLog(@"销毁了");
}

-(void)setProgress:(NSUInteger)tag{
    [UIView animateWithDuration:.3 animations:^{
        self.p_linv.width = (tag) *itemW;
    }];
    for (UIView *childrenView in self.subviews) {
        if ([childrenView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)childrenView;
            button.selected = ((childrenView.tag -100)<tag);
        }
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
  
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (!isFirstNav) {
//        initialIndex = navigationController.childViewControllers.count - 1;
//        isFirstNav = YES;
//    }
//    [self setProgress:navigationController.childViewControllers.count-initialIndex];
    [self setProgress:navigationController.childViewControllers.count];
    
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cx =  UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, rect.size.height - 2)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [path setLineWidth:2.0];
    RGB(244, 244, 244).setStroke;
    CGContextAddPath(cx, path.CGPath);
    CGContextDrawPath(cx, kCGPathStroke);
    

}


@end

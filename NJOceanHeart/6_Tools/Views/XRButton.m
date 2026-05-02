//
//  XRButton.m
//  WEC4Teacher
//
//  Created by 史伟文 on 15/5/13.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#define kButtonImageRatio 0.5

#import "XRButton.h"
#import "UIImage+XRImageToolBox.h"
#import "XRBadgeButton.h"

@interface XRButton()

@property (nonatomic, strong)XRBadgeButton *badgeButton;

@end


@implementation XRButton

- (instancetype)initWithFrame:(CGRect)frame andIsTabItem:(BOOL)isTab
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (isTab) {
            self.imageView.contentMode = UIViewContentModeCenter;
            self.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        } else {
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.titleLabel.font = [UIFont fontWithName:Heiti_Medium size:14];
        }
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setTitleColor:[UIColor colorWithHexString:Tabbar_Text_Color_Normal alpha:1] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:Tabbar_Text_Color_Selected alpha:1] forState:UIControlStateSelected];
        
        XRBadgeButton *badgeButton = [XRBadgeButton buttonWithType:UIButtonTypeCustom];
        self.imageView.contentMode = UIViewContentModeScaleToFill;

        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
//    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * kButtonImageRatio;
    
    if (self.item.title==nil) {
        
        return CGRectMake(contentRect.size.width / 2.0 - (imageH/kButtonImageRatio-4)/2.0, 2, imageH/kButtonImageRatio-4,contentRect.size.height-4                                                                                                                                           );
    }
    
    return CGRectMake(contentRect.size.width / 2 - imageH / 2, 2, imageH, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * kButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY + 2, titleW, titleH);
}


-(void)layoutSubviews{
    [super layoutSubviews];
//    self.imageView.width = self.width;
//    self.imageView.height =
//    self.imageView.centerX = self.titleLabel.centerX;
//    self.imageView.bottom = self.titleLabel.y;
    
    
}
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    self.badgeButton.badgeValue = self.item.badgeValue;

    CGFloat badgeY = 1;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 8;
    CGRect badgeFrame = self.badgeButton.frame;
    badgeFrame.origin.x = badgeX;
    badgeFrame.origin.y = badgeY;
    self.badgeButton.frame = badgeFrame;
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}
@end

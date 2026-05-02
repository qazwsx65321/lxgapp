//
//  XRBadgeButton.m
//  WEC4Teacher
//
//  Created by 史伟文 on 15/5/14.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import "XRBadgeButton.h"
#import "UIImage+XRImageToolBox.h"

@implementation XRBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setBackgroundImage:[UIImage resizeImageWithName:@"badge圆圈"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGRect frame = self.frame;
        
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font};
            CGSize badgeSize = [badgeValue sizeWithAttributes:attributes];
            badgeW = badgeSize.width + 12;
        }
        
        if ([badgeValue intValue] > 99) {
            NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font};
            CGSize badgeSize = [badgeValue sizeWithAttributes:attributes];
            badgeW = badgeSize.width + 10;
            self.badgeValue = @"99+";
        }
        
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}
@end

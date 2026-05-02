//
//  MeOrderCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/27.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "MeOrderCell.h"
#import "XRBadgeButton.h"
#import "UIButton+XDButton.h"
@interface MeOrderCell()

@property (nonatomic, strong)UIView *topBackView;
@property (nonatomic, strong)UIView *bottomBackView;

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, strong)NSArray *buttons;
//@property (nonatomic, strong)UIButton *treatPayButton;
//@property (nonatomic, strong)UIButton *treatDeliverButton;
//@property (nonatomic, strong)UIButton *treatReceiveButton;
//@property (nonatomic, strong)UIButton *treatCommentButton;
//@property (nonatomic, strong)UIButton *drawBackButton;

@end

@implementation MeOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"MeOrderCell";
    MeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MeOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    _topBackView = [[UIView alloc] init];
    _topBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topBackView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"我的订单";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [_topBackView addSubview:_titleLabel];
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.text = @"查看全部订单 >";
    _tipLabel.textColor = [UIColor grayColor];
    _tipLabel.textAlignment = NSTextAlignmentRight;
    _tipLabel.font = [UIFont systemFontOfSize:12];
    [_topBackView addSubview:_tipLabel];
    
    
    _bottomBackView = [[UIView alloc] init];
    _bottomBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomBackView];
    
    NSArray *titles = @[@"待付款", @"待发货", @"待收货", @"待评价", @"换货"];
//    NSArray *icons = @[@"wallet", @"huo", @"car", @"flower", @"tui"];
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:5];
    for (NSUInteger i = 0; i < 5; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        NSString *picname = [NSString stringWithFormat:@"orderno%lu",i+1];
    
        [button setImage:[UIImage imageNamed:picname] forState:UIControlStateNormal];
        
        
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        //[button setImageEdgeInsets:UIEdgeInsetsMake(0, 17.5, 25, 0)];
        //[button setTitleEdgeInsets:UIEdgeInsetsMake(15, -15, 0, 0)];
        button.tag = i;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBackView addSubview:button];
        
        XRBadgeButton *badgeButton = [XRBadgeButton buttonWithType:UIButtonTypeCustom];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        
        
//        [button addSubview:badgeButton];
        [buttons addObject:button];
    }
    _buttons = [buttons mutableCopy];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _topBackView.width = self.width;
    _topBackView.height = 35;
    _topBackView.x = 0;
    _topBackView.y = 0;
    
    _titleLabel.width = 60;
    _titleLabel.height = 15;
    _titleLabel.x = 15;
    _titleLabel.centerY = _topBackView.height/2;
    
    _tipLabel.width = 100;
    _tipLabel.height = 15;
    _tipLabel.x = _topBackView.width - _tipLabel.width - 15;
    _tipLabel.centerY = _titleLabel.centerY;
    
    _bottomBackView.width = _topBackView.width;
    _bottomBackView.height = 70;
    _bottomBackView.x = _topBackView.x;
    _bottomBackView.y = CGRectGetMaxY(_topBackView.frame) + 1;
    
    for (NSUInteger i = 0; i < _buttons.count; i ++) {
        UIButton *button = _buttons[i];
        
        button.width = _bottomBackView.width / _buttons.count;
        button.height = button.width > 54 ? 54 : button.width;
        
        button.x = i * button.width;
        button.centerY = _bottomBackView.height/2;
        
        for (UIView *badgeButton in button.subviews) {
            if ([badgeButton isKindOfClass:[XRBadgeButton class]]) {
                CGFloat badgeY = 5;
                CGFloat badgeX = button.frame.size.width - badgeButton.frame.size.width - 10;
                CGRect badgeFrame = badgeButton.frame;
                badgeFrame.origin.x = badgeX;
                badgeFrame.origin.y = badgeY;
                badgeButton.frame = badgeFrame;
            }
        }
        
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:6];
        
        button.imageView.contentMode =  UIViewContentModeScaleToFill;

    }
    
}

- (void)buttonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(meOrderCell:didSelectedTpyeAtIndex:)]) {
        [self.delegate meOrderCell:self didSelectedTpyeAtIndex:sender.tag];
    }
}

- (void)setBadges:(NSArray *)badges
{
    _badges = badges;
    
    for (NSUInteger i = 0; i < _buttons.count; i ++) {
        UIButton *button = _buttons[i];
        
        for (UIView *badgeButton in button.subviews) {
            if ([badgeButton isKindOfClass:[XRBadgeButton class]]) {
                
                XRBadgeButton *bButton = (XRBadgeButton *)badgeButton;
                bButton.badgeValue = badges[i];
                
            }
        }
    }

}

@end

//
//  GoodSortCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodSortCell.h"



@interface tagImageView : UIImageView

@property (nonatomic,assign) BOOL isUp;

@end

@implementation tagImageView



@end

@interface GoodSortCell()

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIButton *selectedButton;
@property (nonatomic, strong)UIButton *defaultButton;
@property (nonatomic, strong)UIButton *sVolumeButton;
@property (nonatomic, strong)UIButton *priceButton;
@property (nonatomic, strong)UIButton *timeButton;
@property (nonatomic, assign)BOOL isIncrease;

@end

@implementation GoodSortCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"GoodSortCell";
    GoodSortCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GoodSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    // 绘制按钮
    self.isIncrease = NO;
    [self setupItems];
    
    
    self.selectedButton = self.defaultButton;
    self.selectedButton.selected = YES;
}

- (void)setupItems
{
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    self.defaultButton = [self createItemWithTitle:@"综合" showArror:NO tag:GoodSortTypeDefault];
    self.sVolumeButton = [self createItemWithTitle:@"销量" showArror:YES tag:GoodSortTypeSVolume];
    self.priceButton = [self createItemWithTitle:@"价格" showArror:YES tag:GoodSortTypePrice];
    self.timeButton = [self createItemWithTitle:@"时间" showArror:YES tag:GoodSortTypeTime];
    
}

- (UIButton *)createItemWithTitle:(NSString *)title showArror:(BOOL)isShowArror tag:(NSInteger)sortType
{
    UIImage *image = [UIImage imageNamed:@""];
    UIImage *selectedImage = [UIImage imageNamed:@""];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:Navi_Background_Color] forState:UIControlStateSelected];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = sortType;
    [_backView addSubview:button];
    
    if (isShowArror) {
        tagImageView *arrow = [[tagImageView alloc] initWithImage:[UIImage imageNamed:@"sortDown"]];
        [button addSubview:arrow];
    }
    
    return button;
}

- (void)buttonPressed:(UIButton *)sender
{
    
    tagImageView *  tagimageView;
    
    for (UIView *imageView in sender.subviews) {
        if ([imageView isKindOfClass:[tagImageView class]] && ![imageView clipsToBounds]) {
            tagimageView = (tagImageView *)imageView;
        }
    }
    if (self.selectedButton == sender) {
    
        tagimageView.isUp = !tagimageView.isUp;
        if (tagimageView.isUp) {
            tagimageView.image = [UIImage imageNamed:@"sortUp"];
        }else{
            tagimageView.image = [UIImage imageNamed:@"sortDown"];
        }
    }
    self.selectedButton.selected = NO;
    self.selectedButton = sender;
    sender.selected = YES;
    
    BOOL sort = !tagimageView.isUp;
    if (sender.tag ==GoodSortTypeDefault) {
        sort = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectSegmentAtIndex:increase:)]) {
        
        [self.delegate didSelectSegmentAtIndex:(GoodSortType)sender.tag increase:sort];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _backView.width = self.width;
    _backView.height = self.height - 2;
    _backView.x = 0;
    _backView.y = 0;
    
    for (NSUInteger i = 0; i < self.backView.subviews.count; i ++)
    {
        UIButton *button = self.backView.subviews[i];
        button.width = _backView.width / 4;
        button.height = _backView.height;
        button.x = i * button.width;
        button.y = 0;
        
        for (UIView *imageView in button.subviews) {
            if ([imageView isKindOfClass:[UIImageView class]]) {
                imageView.frame = CGRectMake(CGRectGetMaxX(button.titleLabel.frame) + 5, button.height / 2 - 4, 12, 8);
            }
        }
        
    }
}


@end

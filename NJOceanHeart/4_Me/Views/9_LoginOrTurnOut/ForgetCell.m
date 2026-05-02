//
//  ForgetCell.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/17.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "ForgetCell.h"

@interface ForgetCell ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation ForgetCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"ForgetCell";
    ForgetCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[ForgetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupControls];
    }
    return self;
}

-(void)setupControls{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
    self.button.layer.cornerRadius = 5.f;
    self.button.layer.masksToBounds = YES;
    [self.contentView addSubview:self.button];
    
    [self.button addTarget:self action:@selector(fun) forControlEvents:UIControlEventTouchUpInside];
}

//20220418 remark，下一步执行此处，“注册”和“忘记密码”共用该界面
- (void)fun {
    [self.delegate didNextStep:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat SH = 400.f*screen_Width/750.f;
    
    CGFloat btnX = 45.f/750.f*screen_Width;
    CGFloat btnY = 160.f/400.f*SH;
    CGFloat btnW = 660.f/750.f*screen_Width;
    CGFloat btnH = 100.f/400.f*SH;
    self.button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
}

- (void)setIsForget:(BOOL)isForget {
    _isForget = isForget;
    
    [_button setTitle:isForget ? @"下一步" : @"完成" forState:UIControlStateNormal];
    
}

@end

//
//  RegistCell0.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/14.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "RegistCell0.h"

@interface RegistCell0 ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *button0;
@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *lastButton;

@end

@implementation RegistCell0

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"RegistCell0";
    RegistCell0 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[RegistCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"车辆属性:";
    self.label.textColor = [UIColor colorWithWhite:0.071 alpha:1.000];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label];
    
    self.button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button0 setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [self.button0 setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
    [self.button0 setTitle:@"  自有车辆" forState:UIControlStateNormal];
    [self.button0 setTitleColor:[UIColor colorWithWhite:0.071 alpha:1.000] forState:UIControlStateNormal];
    self.button0.titleLabel.font = [UIFont systemFontOfSize:15];
    self.button0.selected = YES;
    [self.contentView addSubview:self.button0];
    
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button1 setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [self.button1 setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
    [self.button1 setTitle:@"  社会车辆" forState:UIControlStateNormal];
    self.button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button1 setTitleColor:[UIColor colorWithWhite:0.071 alpha:1.000] forState:UIControlStateNormal];
    self.button0.selected = NO;
    [self.contentView addSubview:self.button1];
    
    self.lastButton = self.button0;
    self.lastButton.selected = YES;
    
    [self.button0 addTarget:self action:@selector(fun:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self action:@selector(fun:) forControlEvents:UIControlEventTouchUpInside];
    
    self.button0.tag = 1000;
    self.button1.tag = 1001;
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor colorWithWhite:0.894 alpha:1.000];
    [self.contentView addSubview:self.line];
    
}

- (void)fun:(UIButton *)sender {
    
    if (sender != self.lastButton) {
        sender.selected = YES;
        self.lastButton.selected = NO;
        self.lastButton = sender;
        
        [self.delegate didSelectCar:self  withIndex:sender.tag];
        
        
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleS = [StringSizeModel sizeWithText:_label.text font:[UIFont systemFontOfSize:15]];
    
    CGFloat PLX = 45.f/750.f*screen_Width;
    CGFloat PLY = 0;
    CGFloat PLW = titleS.width;
    CGFloat PLH = 118.f*screen_Width/750.f;
    self.label.frame = CGRectMake(PLX, PLY, PLW, PLH);
    
    CGFloat btnX = self.label.right + 10.f/750.f*screen_Width;
    CGFloat btnY = 40.f*screen_Width/750.f;
    CGFloat btnW = 250.f/750.f*screen_Width;
    CGFloat btnH = 38.f*screen_Width/750.f;
    self.button0.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    self.button1.frame = CGRectMake(self.button0.right, btnY, btnW, btnH);
    
    self.line.frame = CGRectMake(PLX, self.label.bottom, 660.f/750.f*screen_Width, 1);
    
    
}

@end

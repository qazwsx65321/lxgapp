//
//  RegistCell1.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/17.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "RegistCell1.h"


@interface RegistCell1 ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *button;

@end

@implementation RegistCell1

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"RegistCell1";
    RegistCell1 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[RegistCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    NSString *str = @"《用户服务协议》";
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"多点物流%@",str]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:str].location, [[noteStr string] rangeOfString:str].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:Navi_Background_Color] range:redRange];
    
    
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor colorWithWhite:0.071 alpha:1.000];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.label setAttributedText:noteStr];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.button setTitle:@"注册" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
    self.button.layer.cornerRadius = 5.f;
    self.button.layer.masksToBounds = YES;
    [self.contentView addSubview:self.button];
    
    [self.button addTarget:self action:@selector(fun) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)fun {
    [self.delegate didRegist:self];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat SH = 400.f*screen_Width/750.f;
    
    CGFloat labelX = 0;
    CGFloat labelY = 110.f/400.f*SH;
    CGFloat labelW = screen_Width;
    CGFloat labelH = 65.f/400.f*SH;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat btnX = 45.f/750.f*screen_Width;
    CGFloat btnY = self.label.bottom;
    CGFloat btnW = 660.f/750.f*screen_Width;
    CGFloat btnH = 100.f/400.f*SH;
    self.button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    
}

@end

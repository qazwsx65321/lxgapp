//
//  Ocean_ProfessionCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ProfessionCell.h"

@interface Ocean_ProfessionCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *valueLabel;

@end

@implementation Ocean_ProfessionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ProfessionCell";
    Ocean_ProfessionCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ProfessionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithRed:0.592 green:0.588 blue:0.596 alpha:1.000];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.titleLabel];
    
    self.valueLabel = [[UILabel alloc] init];
    self.valueLabel.textColor = [UIColor colorWithRed:0.592 green:0.588 blue:0.596 alpha:1.000];
    self.valueLabel.font = [UIFont systemFontOfSize:15];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.valueLabel];
}

- (void)setType:(NSInteger)type {
    _type = type;
    
    
    if (type == 0) {
        _titleLabel.attributedText = [self getLabelAttributeText:@"单位名称" withChangeText:@"*"];
        _valueLabel.text = [Ocean_UserInfo sharedOcean_UserInfo].m_company;
    }else {
        _titleLabel.attributedText = [self getLabelAttributeText:@"职位/职务" withChangeText:@"*"];
        _valueLabel.text = [Ocean_UserInfo sharedOcean_UserInfo].m_jobname;
    }
    
    
}


- (NSMutableAttributedString *)getLabelAttributeText:(NSString *)text withChangeText:(NSString *)changetext {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",changetext,text]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:changetext].location, [[noteStr string] rangeOfString:changetext].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    return noteStr;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat SH = 100.f*screen_Width/750.f;
    
    CGFloat bgX = 0;
    CGFloat bgY = 0;
    CGFloat bgW = screen_Width;
    CGFloat bgH = SH;
    self.bgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGSize titleS = [StringSizeModel sizeWithText:@"证件有效期至" font:[UIFont systemFontOfSize:15]];
    CGFloat laX = 25.f/750.f*screen_Width;
    CGFloat laY = 0;
    CGFloat laW = titleS.width;
    CGFloat laH = SH;
    self.titleLabel.frame = CGRectMake(laX, laY, laW, laH);
    
    self.valueLabel.frame = CGRectMake(self.titleLabel.right, laY, screen_Width - self.titleLabel.right - 10, laH);
    
}

@end

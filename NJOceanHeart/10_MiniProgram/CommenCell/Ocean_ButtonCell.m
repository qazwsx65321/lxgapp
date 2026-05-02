//
//  Ocean_ButtonCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ButtonCell.h"

@interface Ocean_ButtonCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIButton *inquiryButton;

@end

@implementation Ocean_ButtonCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ButtonCell";
    Ocean_ButtonCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.inquiryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.inquiryButton.backgroundColor = [UIColor redColor];
    self.inquiryButton.layer.cornerRadius = 5.f;
    self.inquiryButton.layer.masksToBounds = YES;
    [self.inquiryButton setTitle:@"查询" forState:UIControlStateNormal];
    self.inquiryButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.inquiryButton];
    [self.inquiryButton addTarget:self action:@selector(inquiryClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)inquiryClick {
    
    if ([self.delegate respondsToSelector:@selector(didInquiry:)]) {
        [self.delegate didInquiry:self];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 60);
    self.inquiryButton.frame = CGRectMake(20, 10, screen_Width - 40, 40);
    
}

@end

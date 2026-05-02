//
//  Ocean_RoundCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_RoundCell.h"

@interface Ocean_RoundCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIButton *roundImage;
@property (nonatomic,strong) UIView *qiview;
@property (nonatomic,strong) UILabel *label;

@end

@implementation Ocean_RoundCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_RoundCell";
    Ocean_RoundCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_RoundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    
    
    self.roundImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.roundImage setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [self.roundImage setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
    [self.bgView addSubview:self.roundImage];
    
    self.qiview = [[UIView alloc] init];
    [self.bgView addSubview:self.qiview];
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"只看高铁动车";
    self.label.textColor = [UIColor blueColor];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.label];
    
}

- (void)setIshigh:(NSString *)ishigh {
    _ishigh = ishigh;
    
    _roundImage.selected = [ishigh isEqualToString:@"0"] ? NO : YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 40);
    self.roundImage.frame = CGRectMake(15, 10, 20, 20);
    self.qiview.frame = CGRectMake(15, 10, 20, 20);
    self.label.frame = CGRectMake(40, 0, screen_Width - 65, 40);
    
}

@end

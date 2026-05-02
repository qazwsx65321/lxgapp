//
//  Ocean_MyCardCell1.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MyCardCell1.h"

@interface Ocean_MyCardCell1 ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *numLabel;

@end

@implementation Ocean_MyCardCell1

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_MyCardCell1";
    Ocean_MyCardCell1 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_MyCardCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.bgView.backgroundColor = [UIColor colorWithRed:0.082 green:0.059 blue:0.463 alpha:1.000];
    [self.contentView addSubview:self.bgView];
    
    self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiao_bank"]];
    [self.bgView addSubview:self.picImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"交通银行";
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    [self.bgView addSubview:self.nameLabel];
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.text = @"储蓄卡";
    self.stateLabel.textColor = [UIColor whiteColor];
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.stateLabel];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.text = @"****    ****    ****    2456";
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.numLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat SH = 230.f*screen_Width/750.f;
    
    self.bgView.x = 35.f/750.f*screen_Width;
    self.bgView.y = 30.f/230.f*SH;
    self.bgView.width = 680.f/750.f*screen_Width;
    self.bgView.height = 200.f/230.f*SH;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask = maskLayer;
    self.bgView.layer.masksToBounds = YES;
    
    self.picImageView.x = 40.f/680.f*self.bgView.width;
    self.picImageView.y = 25.f/200.f*self.bgView.height;
    self.picImageView.width = 80.f/680.f*self.bgView.width;
    self.picImageView.height = 80.f/200.f*self.bgView.height;
    
    self.nameLabel.x = self.picImageView.right + 30.f/680.f*self.bgView.width;
    self.nameLabel.y = 25.f/200.f*self.bgView.height;
    self.nameLabel.width = 500.f/680.f*self.bgView.width;
    self.nameLabel.height = 30.f/200.f*self.bgView.height;
    
    self.stateLabel.x = self.nameLabel.x;
    self.stateLabel.y = self.nameLabel.bottom + 30.f/200.f*self.bgView.height;
    self.stateLabel.width = 500.f/680.f*self.bgView.width;
    self.stateLabel.height = 30.f/200.f*self.bgView.height;
    
    self.numLabel.x = self.nameLabel.x;
    self.numLabel.y = self.stateLabel.bottom + 30.f/200.f*self.bgView.height;
    self.numLabel.width = 500.f/680.f*self.bgView.width;
    self.numLabel.height = 30.f/200.f*self.bgView.height;
    
}

@end

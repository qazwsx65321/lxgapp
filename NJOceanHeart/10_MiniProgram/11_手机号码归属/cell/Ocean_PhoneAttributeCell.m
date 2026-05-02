//
//  Ocean_PhoneAttributeCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_PhoneAttributeCell.h"

@interface Ocean_PhoneAttributeCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *yunyingLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end

@implementation Ocean_PhoneAttributeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_PhoneAttributeCell";
    Ocean_PhoneAttributeCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_PhoneAttributeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.typeLabel];
    
    self.yunyingLabel = [[UILabel alloc] init];
    self.yunyingLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.yunyingLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.addressLabel];
    
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    _typeLabel.text = [NSString stringWithFormat:@"卡类型: %@",dic[@"cardtype"]];
    _yunyingLabel.text = [NSString stringWithFormat:@"运营商: %@",dic[@"company"]];
    _addressLabel.text = [NSString stringWithFormat:@"地址: %@%@",dic[@"province"],dic[@"city"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 100);
    self.typeLabel.frame = CGRectMake(10, 10, screen_Width - 20, 20);
    self.yunyingLabel.frame = CGRectMake(10, 40, screen_Width - 20, 20);
    self.addressLabel.frame = CGRectMake(10, 70, screen_Width - 20, 20);
    
}

@end

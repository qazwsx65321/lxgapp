//
//  Ocean_IDCardCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_IDCardCell.h"

@interface Ocean_IDCardCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *idLabel;
@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) UILabel *birthLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *infoLabel;

@end

@implementation Ocean_IDCardCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_IDCardCell";
    Ocean_IDCardCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_IDCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
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
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
//    self.nameLabel.text = @"姓名: 张先生";
    [self.contentView addSubview:self.nameLabel];
    
    self.idLabel = [[UILabel alloc] init];
    self.idLabel.font = [UIFont systemFontOfSize:13];
//    self.idLabel.text = @"身份证: 330903198904215735";
    [self.contentView addSubview:self.idLabel];
    
    self.sexLabel = [[UILabel alloc] init];
    self.sexLabel.font = [UIFont systemFontOfSize:13];
//    self.sexLabel.text = @"性别: 男";
    [self.contentView addSubview:self.sexLabel];
    
    self.birthLabel = [[UILabel alloc] init];
    self.birthLabel.font = [UIFont systemFontOfSize:13];
//    self.birthLabel.text = @"生日: 1989年04月21日";
    [self.contentView addSubview:self.birthLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:13];
//    self.addressLabel.text = @"地址: 浙江省舟山市普陀区";
    [self.contentView addSubview:self.addressLabel];
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.font = [UIFont systemFontOfSize:13];
//    self.stateLabel.text = @"认证状态: 认证不一致";
    [self.contentView addSubview:self.stateLabel];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.font = [UIFont systemFontOfSize:13];
//    self.infoLabel.text = @"认证信息: 抱歉，身份证校验不一致！";
    [self.contentView addSubview:self.infoLabel];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    _nameLabel.text = [NSString stringWithFormat:@"姓名: %@",dic[@"realname"]];
    _idLabel.text = [NSString stringWithFormat:@"身份证: %@",dic[@"idcard"]];
    _sexLabel.text = [NSString stringWithFormat:@"性别: %@",dic[@"sex"]];
    _birthLabel.text = [NSString stringWithFormat:@"生日: %@",dic[@"birth"]];
    _addressLabel.text = [NSString stringWithFormat:@"地址: %@%@%@",dic[@"province"],dic[@"city"],dic[@"town"]];
    _stateLabel.text = [NSString stringWithFormat:@"认证状态: %@",[@"0" isEqualToString:dic[@"verifystatus"]] ? @"认证一致" : @"认证不一致"];
    _infoLabel.text = [NSString stringWithFormat:@"认证信息: %@",dic[@"verifymsg"]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.frame = CGRectMake(10, 10, screen_Width - 20, 20);
    self.idLabel.frame = CGRectMake(10, 40, screen_Width - 20, 20);
    self.sexLabel.frame = CGRectMake(10, 70, screen_Width - 20, 20);
    self.birthLabel.frame = CGRectMake(10, 100, screen_Width - 20, 20);
    self.addressLabel.frame = CGRectMake(10, 130, screen_Width - 20, 20);
    self.stateLabel.frame = CGRectMake(10, 160, screen_Width - 20, 20);
    self.infoLabel.frame = CGRectMake(10, 190, screen_Width - 20, 20);
    
}

@end

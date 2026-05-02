//
//  Ocean_IPAddressCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_IPAddressCell.h"

@interface Ocean_IPAddressCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end

@implementation Ocean_IPAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_IPAddressCell";
    Ocean_IPAddressCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_IPAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.addressLabel];
    
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    _typeLabel.text = [NSString stringWithFormat:@"类型: %@",dic[@"type"]];
    _addressLabel.text = [NSString stringWithFormat:@"地址: %@",dic[@"area"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 100);
    self.typeLabel.frame = CGRectMake(10, 10, screen_Width - 20, 20);
    self.addressLabel.frame = CGRectMake(10, 40, screen_Width - 20, 20);
    
}

@end

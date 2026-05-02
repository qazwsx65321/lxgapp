//
//  Ocean_ShopAddressCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ShopAddressCell.h"
#import "Ocean_AddressModel.h"

@interface Ocean_ShopAddressCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *palceLabel;

@end

@implementation Ocean_ShopAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ShopAddressCell";
    Ocean_ShopAddressCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ShopAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    self.titleLabel.text = @"收货地址";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.titleLabel];
    
    self.palceLabel = [[UILabel alloc] init];
    self.palceLabel.text = @"点击选择地址";
    self.palceLabel.textColor = [UIColor colorWithRed:0.573 green:0.576 blue:0.580 alpha:1.000];
    self.palceLabel.font = [UIFont systemFontOfSize:15];
    self.palceLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.palceLabel];
    
}

- (void)setModel:(ShopAddressModel *)model {
    _model = model;
    
    _palceLabel.text = model.m_pro ? [NSString stringWithFormat:@"%@%@%@",model.m_city,model.m_area,model.m_address] : @"点击选择地址";
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 40);
    self.titleLabel.frame = CGRectMake(10, 10, 100, 20);
    self.palceLabel.frame = CGRectMake(self.titleLabel.right, 10, screen_Width - 140, 20);
    
}

@end

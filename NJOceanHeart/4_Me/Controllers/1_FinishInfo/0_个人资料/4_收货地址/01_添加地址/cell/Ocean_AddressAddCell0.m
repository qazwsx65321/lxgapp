//
//  Ocean_AddressAddCell0.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AddressAddCell0.h"
#import "Ocean_AddressModel.h"

@interface Ocean_AddressAddCell0 ()

@property (nonatomic,strong) UILabel *label0;
@property (nonatomic,strong) UILabel *label1;

@end

@implementation Ocean_AddressAddCell0

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_AddressAddCell0";
    Ocean_AddressAddCell0 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_AddressAddCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    self.label0 = [[UILabel alloc] init];
    self.label0.text = @"所在地区";
    self.label0.textColor = [UIColor colorWithWhite:0.235 alpha:1.000];
    self.label0.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label0];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"请选择";
    self.label1.textColor = [UIColor lightGrayColor];
    self.label1.font = [UIFont systemFontOfSize:15];
    self.label1.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.label1];
}

- (void)setModel:(AddAddressModel *)model {
    _model = model;
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@",model.m_pro,model.m_city,model.m_area];
    
    _label1.text = model.m_pro ? str : @"请选择";
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label0.x = 30.f/750.f*screen_Width;
    self.label0.y = 0;
    self.label0.width = 150.f/750.f*screen_Width;
    self.label0.height = 40;
    
    self.label1.x = self.label0.right + 15.f/750.f*screen_Width;
    self.label1.y = 0;
    self.label1.width = 450.f/750.f*screen_Width;
    self.label1.height = 40;
    
}

@end

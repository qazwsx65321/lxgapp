//
//  Ocean_AddressAddCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AddressAddCell.h"
#import "Ocean_AddressModel.h"

@interface Ocean_AddressAddCell ()

@property (nonatomic,strong) UILabel *label0;
@property (nonatomic,strong) UILabel *label1;

@end

@implementation Ocean_AddressAddCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_AddressAddCell";
    Ocean_AddressAddCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_AddressAddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.label0 = [[UILabel alloc] init];
    self.label0.text = @"收货人";
    self.label0.textColor = [UIColor colorWithWhite:0.235 alpha:1.000];
    self.label0.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label0];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"联系电话";
    self.label1.textColor = [UIColor colorWithWhite:0.235 alpha:1.000];
    self.label1.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label1];
    
    self.textFiled0 = [[UITextField alloc] init];
    self.textFiled0.placeholder = @"请输入姓名";
    self.textFiled0.textColor = [UIColor lightGrayColor];
    self.textFiled0.font = [UIFont systemFontOfSize:15];
    self.textFiled0.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:self.textFiled0];
    
    self.textFiled1 = [[UITextField alloc] init];
    self.textFiled1.placeholder = @"请输入联系电话";
    self.textFiled1.textColor = [UIColor lightGrayColor];
    self.textFiled1.font = [UIFont systemFontOfSize:15];
    self.textFiled1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:self.textFiled1];
    
}

- (void)setModel:(AddAddressModel *)model {
    _model = model;
    
    if (model.m_linkname) {
        _textFiled0.text = model.m_linkname;
    }
    
    if (model.m_linktel) {
        _textFiled1.text = model.m_linktel;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label0.x = 30.f/750.f*screen_Width;
    self.label0.y = 0;
    self.label0.width = 150.f/750.f*screen_Width;
    self.label0.height = 40;
    
    self.textFiled0.x = self.label0.right + 15.f/750.f*screen_Width;
    self.textFiled0.y = 0;
    self.textFiled0.width = 550.f/750.f*screen_Width;
    self.textFiled0.height = 40;
    
    self.label1.x = 30.f/750.f*screen_Width;
    self.label1.y = 40;
    self.label1.width = 150.f/750.f*screen_Width;
    self.label1.height = 40;
    
    self.textFiled1.x = self.label0.right + 15.f/750.f*screen_Width;
    self.textFiled1.y = 40;
    self.textFiled1.width = 550.f/750.f*screen_Width;
    self.textFiled1.height = 40;
    
}

@end

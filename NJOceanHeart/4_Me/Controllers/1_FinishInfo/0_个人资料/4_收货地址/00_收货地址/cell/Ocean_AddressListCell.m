//
//  Ocean_AddressListCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AddressListCell.h"

#import "Ocean_AddressModel.h"

@interface Ocean_AddressListCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *deleteBtn;

@end

@implementation Ocean_AddressListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_AddressListCell";
    Ocean_AddressListCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_AddressListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"王晓峰";
    self.nameLabel.textColor = [UIColor colorWithWhite:0.373 alpha:1.000];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.text = @"13656002312";
    self.phoneLabel.textColor = [UIColor colorWithWhite:0.373 alpha:1.000];
    self.phoneLabel.font = [UIFont systemFontOfSize:14];
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.phoneLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"江苏省南京市雨花台区南浦路210号5街区50栋3#123";
    self.addressLabel.textColor = [UIColor colorWithWhite:0.373 alpha:1.000];
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.addressLabel];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
    [self.selectBtn setTitle:@"  默认地址" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor colorWithWhite:0.373 alpha:1.000] forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor colorWithRed:0.925 green:0.494 blue:0.000 alpha:1.000] forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.selectBtn];
    
    [self.selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[UIColor colorWithWhite:0.373 alpha:1.000] forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.editBtn];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor colorWithWhite:0.373 alpha:1.000] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.deleteBtn];
    
    [self.editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)selectClick {
    //_selectBtn.selected = !_selectBtn.selected;
    
    if ([self.delegate respondsToSelector:@selector(didDefaultAddress:)]) {
        [self.delegate didDefaultAddress:self];
    }
}

- (void)editClick {
    if ([self.delegate respondsToSelector:@selector(didEditAddress:)]) {
        [self.delegate didEditAddress:self];
    }
}

- (void)deleteClick {
    if ([self.delegate respondsToSelector:@selector(didDeleteAddress:)]) {
        [self.delegate didDeleteAddress:self];
    }
}

- (void)setCellFrame:(Ocean_AddressListFrame *)cellFrame {
    
    _cellFrame = cellFrame;
    
    _bgView.frame = cellFrame.bgViewF;
    _nameLabel.frame = cellFrame.nameLabelF;
    _phoneLabel.frame = cellFrame.phoneLabelF;
    _addressLabel.frame = cellFrame.addressLabelF;
    _selectBtn.frame = cellFrame.selectBtnF;
    _editBtn.frame = cellFrame.editBtnF;
    _deleteBtn.frame = cellFrame.deleteBtnF;
    
    _nameLabel.text = cellFrame.model.m_linkname;
    _phoneLabel.text = cellFrame.model.m_telphone;
    _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",cellFrame.model.m_pro,cellFrame.model.m_city,cellFrame.model.m_area,cellFrame.model.m_address];
    
    _selectBtn.selected = [@"0" isEqualToString:cellFrame.model.m_flag] ? NO : YES;
    
}


@end


@implementation Ocean_AddressListFrame

- (void)setModel:(MyAddressModel *)model {
    _model = model;
    
    CGFloat SH = 230.f*screen_Width/750.f;
    
    CGFloat bgX = 0;
    CGFloat bgY = 0;
    CGFloat bgW = screen_Width;
    CGFloat bgH = SH;
    _bgViewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat nameX = 25.f/750.f*screen_Width;
    CGFloat nameY = 30.f/230.f*SH;
    CGFloat nameW = 300.f/750.f*screen_Width;
    CGFloat nameH = 35.f/230.f*SH;
    _nameLabelF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat phoneX = 450.f/750.f*screen_Width;
    CGFloat phoneY = nameY;
    CGFloat phoneW = 275.f/750.f*screen_Width;
    CGFloat phoneH = nameH;
    _phoneLabelF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    CGSize addressS = [StringSizeModel sizeWithText:[NSString stringWithFormat:@"%@%@%@%@",model.m_pro,model.m_city,model.m_area,model.m_address] font:[UIFont systemFontOfSize:14] maxW:700.f/750.f*screen_Width];
    CGFloat addressX = nameX;
    CGFloat addressY = CGRectGetMaxY(_nameLabelF) + 30.f/230.f*SH;
    CGFloat addressW = 700.f/750.f*screen_Width;
    CGFloat addressH = addressS.height;
    _addressLabelF = CGRectMake(addressX, addressY, addressW, addressH);
    
    CGFloat btnX = nameX;
    CGFloat btnY = CGRectGetMaxY(_addressLabelF) + 40.f/230.f*SH;
    CGFloat btnW = 200.f/750.f*screen_Width;
    CGFloat btnH = nameH;
    _selectBtnF = CGRectMake(btnX, btnY, btnW, btnH);
    
    _editBtnF = CGRectMake(550.f/750.f*screen_Width, btnY, 80.f/750.f*screen_Width, btnH);
    
    _deleteBtnF = CGRectMake(660.f/750.f*screen_Width, btnY, 80.f/750.f*screen_Width, btnH);
    
    _bgViewF = CGRectMake(bgX, bgY, bgW, CGRectGetMaxY(_deleteBtnF)+10);
    
    _cellHeight = CGRectGetMaxY(_bgViewF)+5;
    
}

@end


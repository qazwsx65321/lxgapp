//
//  Ocean_AddressAddCell1.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AddressAddCell1.h"
#import "XDTextView.h"
#import "Ocean_AddressModel.h"

@interface Ocean_AddressAddCell1 ()

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *roundBtn;
@property (nonatomic,strong) UIButton *bgButton;

@end

@implementation Ocean_AddressAddCell1

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_AddressAddCell1";
    Ocean_AddressAddCell1 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_AddressAddCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.textView = [[XDTextView alloc] init];
    self.textView.XD_placehodel = @"详情注意填写的地址中要有路名，以方便系统自动为你推荐就近的服务站点。";
    self.textView.XD_placehodelColor = [UIColor colorWithRed:0.961 green:0.314 blue:0.671 alpha:1.000];
    self.textView.XD_font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.textView];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor colorWithWhite:0.976 alpha:1.000];
    [self.contentView addSubview:self.line];
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"设为默认地址";
    self.label.textColor = [UIColor colorWithWhite:0.235 alpha:1.000];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label];
    
    self.roundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.roundBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [self.roundBtn setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
    [self.roundBtn addTarget:self action:@selector(fun) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.roundBtn];
    
    
    self.bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.bgButton];
    
}



- (void)setModel:(AddAddressModel *)model {
    _model = model;
    
    
    if (model.m_address) {
        _textView.XD_text = model.m_address;
    }
    
}

- (void)buttonClick {
    
    if (self.isEdit) {
        
        if ([self.delegate respondsToSelector:@selector(didDeleteAddress:)]) {
            [self.delegate didDeleteAddress:self];
        }
        
    }else {
        self.roundBtn.selected = !self.roundBtn.selected;
        
        if (self.roundBtn.selected == YES) {
            self.model.m_flag = @"1";
        }else {
            self.model.m_flag = @"0";
        }
    }
    
}

- (void)fun {
    self.roundBtn.selected = !self.roundBtn.selected;
    if (self.roundBtn.selected == YES) {
        self.model.m_flag = @"1";
    }else {
        self.model.m_flag = @"0";
    }
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    
    if (isEdit) {
        _label.text = @"删除地址";
        _label.textColor = [UIColor colorWithRed:0.894 green:0.329 blue:0.365 alpha:1.000];
        _roundBtn.hidden = YES;
    }else {
        _label.text = @"设为默认地址";
        _label.textColor = [UIColor colorWithWhite:0.235 alpha:1.000];
        _roundBtn.hidden = NO;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.x = 15.f/750.f*screen_Width;
    self.textView.y = 0;
    self.textView.width = 720.f/750.f*screen_Width;
    self.textView.height = 100;
    
    self.line.x = 0;
    self.line.y = self.textView.bottom;
    self.line.width = screen_Width;
    self.line.height = 5;
    
    self.label.x = 30.f/750.f*screen_Width;
    self.label.y = self.line.bottom;
    self.label.width = 400.f/750.f*screen_Width;
    self.label.height = 40;
    
    self.roundBtn.x = 690.f/750.f*screen_Width;
    self.roundBtn.width = 40.f/750.f*screen_Width;
    self.roundBtn.height = self.roundBtn.width;
    self.roundBtn.centerY = self.label.centerY;
    
    self.bgButton.frame = CGRectMake(0, self.line.bottom, screen_Width, 40);
    
}

@end

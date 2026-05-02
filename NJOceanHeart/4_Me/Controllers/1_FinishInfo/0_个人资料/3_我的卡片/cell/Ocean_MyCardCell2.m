//
//  Ocean_MyCardCell2.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MyCardCell2.h"

#import "Ocean_MyCardModel.h"

@interface Ocean_MyCardCell2 ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *bankLabel;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;

@end

@implementation Ocean_MyCardCell2

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_MyCardCell2";
    Ocean_MyCardCell2 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_MyCardCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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

- (void)setModel:(Ocean_MyCardModel *)model {
    _model = model;
    
    
    _numLabel.text = [NSString stringWithFormat:@"银行卡号: %@",model.m_bankno];
    _bankLabel.text = [NSString stringWithFormat:@"开户行/支行: %@",model.m_bankname];
    
}

-(void)setupControls{
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.text = @"银行卡号:";
    self.numLabel.textColor = [UIColor colorWithWhite:0.239 alpha:1.000];
    self.numLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.numLabel];
    
    self.line0 = [[UIView alloc] init];
    self.line0.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    [self.bgView addSubview:self.line0];
    
    self.bankLabel = [[UILabel alloc] init];
    self.bankLabel.text = @"开户行/支行:";
    self.bankLabel.textColor = [UIColor colorWithWhite:0.239 alpha:1.000];
    self.bankLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.bankLabel];
    
    self.line1 = [[UIView alloc] init];
    self.line1.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    [self.bgView addSubview:self.line1];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 82);
    self.numLabel.frame = CGRectMake(10, 0, screen_Width - 20, 40);
    self.line0.frame = CGRectMake(0, self.numLabel.bottom, screen_Width, 1);
    self.bankLabel.frame = CGRectMake(10, self.line0.bottom, screen_Width - 20, 40);
    self.line1.frame = CGRectMake(0, self.bankLabel.bottom, screen_Width, 1);
    
}

@end

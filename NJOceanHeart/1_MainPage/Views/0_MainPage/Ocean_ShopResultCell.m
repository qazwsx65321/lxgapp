//
//  Ocean_ShopResultCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ShopResultCell.h"
@interface Ocean_ShopResultCell()

@property (nonatomic, strong)UIView *backView;

@property (nonatomic, strong)UIImageView *imageview;

@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *numberLabel;

@property (nonatomic, strong)UILabel *enterLabel;

@end

@implementation Ocean_ShopResultCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ShopResultCell";
    Ocean_ShopResultCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ShopResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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

    _backView = [[UIView alloc] init];
    [self.contentView addSubview:_backView];
    
    _imageview = [[UIImageView alloc] init];
    [_backView addSubview:_imageview];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:_nameLabel];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.textColor = [UIColor lightGrayColor];
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:_numberLabel];
    
    _enterLabel = [[UILabel alloc] init];
    _enterLabel.textColor = [UIColor redColor];
    _enterLabel.textAlignment = NSTextAlignmentCenter;
    _enterLabel.font = [UIFont systemFontOfSize:14];
    _enterLabel.layer.borderColor = [UIColor redColor].CGColor;
    _enterLabel.layer.borderWidth = 1.0;
    _enterLabel.height = 20;
    _enterLabel.layer.cornerRadius = _enterLabel.height/2.f;
    [_backView addSubview:_enterLabel];
    
}
-(void)setModel:(Ocean_ShopResultModel *)model
{
    _model = model;
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.m_logo]];
    _nameLabel.text = model.m_bname;
    _numberLabel.text = [NSString stringWithFormat:@"销量%d 共%d件商品",model.m_soldallnum,model.m_allnum];
    _enterLabel.text = @"进店";
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backView).with.offset(10);
        make.centerY.mas_equalTo(_backView);
        make.top.mas_equalTo(_backView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 70));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_backView.mas_centerY).with.offset(-5);
        make.left.mas_equalTo(_imageview.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_centerY).with.offset(5);
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [_enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backView).with.offset(-10);
        make.centerY.mas_equalTo(_backView);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    }
@end

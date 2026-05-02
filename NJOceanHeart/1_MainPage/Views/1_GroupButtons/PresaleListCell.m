//
//  PresaleListCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/30.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "PresaleListCell.h"
#import "PresaleBody.h"

@interface PresaleListCell()

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIImageView *thumbImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *countLabel;

@end

@implementation PresaleListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"PresaleListCell";
    PresaleListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PresaleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        // 绘制底图
        [self setupCellView];
        
    }
    return self;
}

- (void)setupCellView
{
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    _thumbImageView = [[UIImageView alloc] init];
    [_backView addSubview:_thumbImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [_backView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_priceLabel];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.textColor = [UIColor grayColor];
    _countLabel.font = [UIFont systemFontOfSize:10];
    [_backView addSubview:_countLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backView.width = self.width;
    _backView.height = self.height - 2;
    _backView.x = 0;
    _backView.y = 0;
    
    _thumbImageView.width = 44;
    _thumbImageView.height = 44;
    _thumbImageView.x = 15;
    _thumbImageView.y = 8;
    
    _nameLabel.x = CGRectGetMaxX(_thumbImageView.frame) + 15;
    _nameLabel.y = _thumbImageView.y;
    _nameLabel.width = _backView.width - _nameLabel.x - 15;
    _nameLabel.height = 15;
    
    _priceLabel.x = _nameLabel.x;
    _priceLabel.y = CGRectGetMaxY(_nameLabel.frame);
    _priceLabel.width = _nameLabel.width;
    _priceLabel.height = 20;
    
    _countLabel.x = _nameLabel.x;
    _countLabel.y = CGRectGetMaxY(_priceLabel.frame);
    _countLabel.width = _nameLabel.width;
    _countLabel.height = 10;
}

- (void)setGood:(PresaleModel *)good
{
    _good = good;
    
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:good.m_listpic]];
    _nameLabel.text = good.m_title;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@", good.m_price];
    _countLabel.text = [NSString stringWithFormat:@"已预订：%@", good.m_salescount];
}


@end

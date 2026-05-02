//
//  Ocean_GoodsResultCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_HotListCell.h"
#import "Ocean_HotGoodsModel.h"
@interface Ocean_HotListCell()


@property (nonatomic, strong)UIImageView *imageview;

@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *priceLabel;

@property (nonatomic, strong)UILabel *numberLabel;


@end
@implementation Ocean_HotListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_HotListCell";
    Ocean_HotListCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_HotListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self setupControls];
    }
    return self;
}

-(void)setupControls{
    
    
    _imageview = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageview];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [_nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_priceLabel];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.textColor = [UIColor lightGrayColor];
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    _numberLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_numberLabel];
}
- (void)setGood:(Ocean_HotGoodsModel *)good
{
    _good = good;
    [_imageview sd_setImageWithURL:[NSURL URLWithString:good.m_picture]];
    _nameLabel.text = good.m_title;
    _priceLabel.text = [NSString stringWithFormat:@"¥:%@",good.m_price];
    _numberLabel.text = [NSString stringWithFormat:@"销量:%@",good.m_soldnum];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.left.mas_equalTo(self.contentView).offset(5);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.left.mas_equalTo(_imageview.mas_right).offset(5);
        make.right.mas_equalTo(self.contentView).offset(-5);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_imageview.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.right.mas_equalTo(self.contentView).offset(5);
    }];
    
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_priceLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_imageview.mas_right).offset(5);
        make.right.mas_equalTo(self.contentView).offset(5);
        make.bottom.mas_equalTo(self.contentView).offset(-5);
    }];
    
}
@end

//
//  RightTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "RightTableViewCell.h"
#import "Ocean_CategoryRightFramModel.h"

@interface RightTableViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *countLb;
@property (nonatomic, strong) UILabel *baseLb;

@end

@implementation RightTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [self.contentView addSubview:self.imageV];

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.numberOfLines = 0;
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 15)];
        self.priceLabel.font = [UIFont systemFontOfSize:15];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        
        self.countLb = [[UILabel alloc] init];
        self.countLb.font = [UIFont systemFontOfSize:13];
        self.countLb.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.countLb];
        
        self.baseLb = [[UILabel alloc] init];
        self.baseLb.font = [UIFont systemFontOfSize:13];
        self.baseLb.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.baseLb];
    }
    return self;
}

-(void)setFramModel:(Ocean_CategoryRightFramModel *)framModel{
    _framModel = framModel;
    self.imageV.frame = framModel.ImageFram;
    self.nameLabel.frame = framModel.titleFram;
    self.countLb.frame = framModel.saleFram;
    self.baseLb.frame = framModel.baseFram;
    self.priceLabel.frame = framModel.priceFram;
    [self setModel:framModel.m_foodModel];
}

- (void)setModel:(FoodModel *)model
{
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.m_pic]];
    self.nameLabel.text = model.m_title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.m_price];
    self.countLb.text = [NSString stringWithFormat:@"已售%@件",model.m_count];
    self.baseLb.text = [NSString stringWithFormat:@"库存%@件",model.m_BaseCount];

}
-(void)layoutSubviews{
    [super layoutSubviews];


}




@end

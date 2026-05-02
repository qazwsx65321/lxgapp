//
//  Ocean_cardInfoCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_cardInfoCell.h"
#import "Ocean_PersonageInfoModel.h"
#import "Ocean_CarInfoModel.h"
@interface Ocean_cardInfoCell()

@property (nonatomic,weak) UIButton * p_button;
@property (nonatomic,weak) UIImageView * p_imagV;

@end

@implementation Ocean_cardInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_cardInfoCell";
    Ocean_cardInfoCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_cardInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
     
        UIImageView *ImageV= [[UIImageView alloc]init];
        [self.contentView addSubview:ImageV];
        self.p_imagV = ImageV;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateSelected];
        self.p_button = button;
        button.userInteractionEnabled = NO;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
    }
    return self;
}




-(void)setCardinfoModel:(Ocean_CarInfoModel *)cardinfoModel{
    _cardinfoModel = cardinfoModel;
    [self.p_imagV sd_setImageWithURL:[NSURL URLWithString:cardinfoModel.m_zpic ] placeholderImage:[UIImage imageNamed:@""]];
    self.p_button.selected = cardinfoModel.isSelect;
    if (cardinfoModel.isSelect) {
        self.infoModel.m_cardid = self.cardinfoModel.m_cid;
    }
    [self.p_button setTitle:cardinfoModel.m_name forState:UIControlStateNormal];
    [self setNeedsDisplay];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.p_imagV.x = 10;
    self.p_imagV.width = self.width - 2*self.p_imagV.x;
    self.p_imagV.y = 15;
    self.p_imagV.height = self.p_imagV.width *300/450;
    self.p_button.width = 100;
    self.p_button.height = 30;
    self.p_button.right = self.p_imagV.right;
    self.p_button.y = self.p_imagV.bottom +5;
    self.separatorInset = UIEdgeInsetsMake(0, screen_Width, 0, 0);
    
}

@end

//
//  Ocean_GoodsDetailCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GoodsDetailCell.h"
#import "SDCycleScrollView.h"
@interface Ocean_GoodsDetailCell()
{
    SDCycleScrollView *imageScrollView;
    UILabel *goodnameLabel;
    UILabel *goodpriceLabel;
    UILabel *goodsalesLabel;

}
@end
@implementation Ocean_GoodsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"GoodsDetailCell";
    Ocean_GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Ocean_GoodsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        // 绘制底图
        [self setupCellView];
        
    }
    return self;
}

- (void)setupCellView
{
    imageScrollView = [[SDCycleScrollView alloc] init];
    [self.contentView addSubview:imageScrollView];
    
    goodnameLabel = [[UILabel alloc] init];
    goodnameLabel.textColor = [UIColor blackColor];
    goodnameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:goodnameLabel];
    goodnameLabel.numberOfLines = 0;
    
    goodpriceLabel = [[UILabel alloc] init];
    goodpriceLabel.textColor = [UIColor redColor];
    goodpriceLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:goodpriceLabel];
    goodsalesLabel = [[UILabel alloc] init];
    goodsalesLabel.textColor = [UIColor lightGrayColor];
    goodsalesLabel.font = [UIFont systemFontOfSize:14];
    goodsalesLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:goodsalesLabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
-(void)setModel:(Ocean_GoodsDetailModel *)model
{
    _model = model;
    imageScrollView.localizationImageNamesGroup = model.m_winlistpic;
    goodnameLabel.text = model.m_title;
//    goodnameLabel.preferredMaxLayoutWidth = (screen_Width - 10.0 * 2);
//    [goodnameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    goodnameLabel.numberOfLines = 0;
    goodpriceLabel.text = [NSString stringWithFormat:@"¥%@",model.m_price];
    goodsalesLabel.text = [NSString stringWithFormat:@"销量:%@",model.m_soldnum];

    [imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(screen_Width, screen_Width*3/4));
    }];
    [goodnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageScrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).with.offset(-5);
    }];
    [goodpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodnameLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(screen_Width/2, 30));
        make.bottom.mas_equalTo(self.contentView);
    }];
    [goodsalesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodnameLabel.mas_bottom);
        make.right.mas_equalTo(self.contentView).offset(-5);
        make.size.mas_equalTo(CGSizeMake( screen_Width/2-5, 30));
        make.bottom.mas_equalTo(self.contentView);
        
    }];

    
}
@end

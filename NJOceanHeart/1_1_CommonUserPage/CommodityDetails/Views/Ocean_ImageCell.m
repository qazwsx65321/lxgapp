//
//  Ocean_ImageCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ImageCell.h"
@interface Ocean_ImageCell()
{
    UIImageView *imageView;
}
@end
@implementation Ocean_ImageCell

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
    static NSString *cellIdentifier = @"ImageCell";
    Ocean_ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Ocean_ImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor clearColor];
//        // 绘制底图
//        [self setupCellView];
        
    }
    return self;
}
- (void)setupCellView
{
//    imageView = [[UIImageView alloc] init];
//    [self.contentView addSubview:imageView];
}
//- (void)setUrl:(NSString *)url
//{
//    _url = url;
//    [imageView sd_setImageWithURL:[NSURL URLWithString:_url]];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.contentView);
//    }];
//}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;

}


@end

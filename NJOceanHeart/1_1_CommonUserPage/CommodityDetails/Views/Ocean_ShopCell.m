//
//  Ocean_ShopCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/31.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ShopCell.h"
@interface Ocean_ShopCell()
{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *infoLabel;
    UILabel *enterLabel;

}

@property (nonatomic,weak) UIView * p_topLineV;
@property (nonatomic,weak) UIView * p_bottomLineV;
@property (nonatomic,weak) UILabel * p_zytypeLb;
@end
@implementation Ocean_ShopCell

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
    static NSString *cellIdentifier = @"ShopCell";
    Ocean_ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Ocean_ShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        
        self.p_topLineV = [self creatLineView];
        
        self.p_bottomLineV = [self creatLineView];

        
        
    }
    return self;
}

-(UIView *)creatLineView{
    UIView *lineV =[[UIView alloc]init];
    lineV.size = CGSizeMake(screen_Width, 5);
    lineV.backgroundColor = RGB(240, 240, 240);
    [self.contentView addSubview:lineV];
    return lineV;
}


- (void)setupCellView
{
    imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    
    infoLabel = [[UILabel alloc] init];
    infoLabel.textColor = [UIColor lightGrayColor];
    infoLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:infoLabel];
    
    enterLabel = [[UILabel alloc] init];
    enterLabel.textColor = [UIColor blackColor];
    enterLabel.layer.cornerRadius = 15;
    enterLabel.layer.masksToBounds = YES;
    enterLabel.textAlignment = NSTextAlignmentCenter;
    enterLabel.layer.borderColor = BackgroundColors(1).CGColor;
    enterLabel.textColor = BackgroundColors(1);
    enterLabel.layer.borderWidth = .8;
    enterLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:enterLabel];
    
    
    self.p_zytypeLb = [self creatLb:[UIFont systemFontOfSize:15] :[UIColor lightGrayColor] :NSTextAlignmentCenter];
    self.p_zytypeLb.layer.cornerRadius = 2;
    self.p_zytypeLb.text = @"自营";
    self.p_zytypeLb.textColor = BackgroundColors(1);
    self.p_zytypeLb.layer.masksToBounds = YES;
    self.p_zytypeLb.layer.borderColor = BackgroundColors(1).CGColor;
    self.p_zytypeLb.layer.borderWidth = 1;
    
    
 }
- (void)layoutSubviews
{
    [super layoutSubviews];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(55, 55));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView.centerY);
        make.right.mas_equalTo(self.contentView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
  
    
    
    if ([@"1" isEqualToString:self.model.m_zytype]) {
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).with.offset(20);
            make.left.mas_equalTo(imageView.mas_right).offset(10);
            make.right.mas_equalTo(enterLabel.mas_left);
        }];
        
        [self.p_zytypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(imageView.mas_right).offset(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(@16);
        }];
        
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.p_zytypeLb.mas_bottom).offset(5);
            make.left.mas_equalTo(imageView.mas_right).offset(10);
            make.right.mas_equalTo(enterLabel);
        }];
        
    }else if([@"2" isEqualToString:self.model.m_zytype]){
    
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView).with.offset(5);
            make.left.mas_equalTo(imageView.mas_right).offset(10);
            make.right.mas_equalTo(enterLabel.mas_left);
        }];
        
        [self.p_zytypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(imageView.mas_right).offset(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(@16);
        }];
        
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(imageView.mas_bottom).offset(-5);
            make.left.mas_equalTo(imageView.mas_right).offset(10);
            make.right.mas_equalTo(enterLabel);
        }];
    
    }
    
   
  
    
   
    
    
    
    self.p_topLineV.y = 0;
    self.p_bottomLineV.bottom = self.height;
}



-(UILabel *)creatLb:(UIFont *)font :(UIColor *)textColor :(NSTextAlignment)textAlignment{
    UILabel *lable = [[UILabel alloc]init];
    lable.font = font;
    lable.textColor = textColor;
    lable.textAlignment = textAlignment;
    //    lable.numberOfLines = 0;
    [self.contentView addSubview:lable];
    return lable;
}



-(void)setModel:(Ocean_GoodsDetailModel *)model
{
    _model = model;
    
    if ([@"1" isEqualToString:model.m_zytype]) {
        self.p_zytypeLb.hidden = NO;
    }else{
        self.p_zytypeLb.hidden = YES;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.m_listpic]];
    nameLabel.text = model.m_name;
    infoLabel.text = [NSString stringWithFormat:@"销量%d 共%d件商品",model.m_soldallnum,model.m_allnum];
    enterLabel.text = @"进店";
}
@end

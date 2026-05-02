//
//  Ocean_FindMeListCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/26.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FindMeListCell.h"
#import "Ocean_FindMelistModel.h"

@interface Ocean_FindMeListCell()

@property (nonatomic,weak) UIImageView * p_headHeadImageView;
@property (nonatomic,weak) UIImageView * p_locaitonImageView;
@property (nonatomic,weak) UILabel * p_titleLb;
@property (nonatomic,weak) UILabel * p_locationLb;
@property (nonatomic,weak) UILabel * p_countLb;
@property (nonatomic,weak) UILabel * p_areLb;
@property (nonatomic,weak) UILabel * p_distanceLb;

@property (nonatomic,weak) UILabel * p_zytypeLb;

@property (nonatomic,weak) UILabel * p_cnameLb;


@end

@implementation Ocean_FindMeListCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        [self initConentView];
        
    }
    return self;
}

-(void)initConentView{
    UIImageView *headView = [[UIImageView alloc]init];
    self.p_headHeadImageView = headView;
    [self.contentView addSubview:headView];
    
    UIImageView *locationImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"point"]];
    self.p_locaitonImageView = locationImageV;
    [self.contentView addSubview:locationImageV];
    self.p_titleLb = [self creatLb:[UIFont systemFontOfSize:15] :[UIColor blackColor] :NSTextAlignmentLeft];
    self.p_locationLb = [self creatLb:[UIFont systemFontOfSize:14] :[UIColor lightGrayColor] :NSTextAlignmentLeft];
    self.p_countLb = [self creatLb:[UIFont systemFontOfSize:14] :[UIColor blackColor] :NSTextAlignmentLeft];
    self.p_areLb = [self creatLb:[UIFont systemFontOfSize:14] :[UIColor lightGrayColor] :NSTextAlignmentLeft];
    self.p_distanceLb = [self creatLb:[UIFont systemFontOfSize:14] :[UIColor lightGrayColor] :NSTextAlignmentRight];

    self.p_zytypeLb = [self creatLb:[UIFont systemFontOfSize:15] :[UIColor lightGrayColor] :NSTextAlignmentCenter];
    self.p_zytypeLb.layer.cornerRadius = 2;
    self.p_zytypeLb.text = @"自营";
    self.p_zytypeLb.textColor = BackgroundColors(1);
    self.p_zytypeLb.layer.masksToBounds = YES;
    self.p_zytypeLb.layer.borderColor = BackgroundColors(1).CGColor;
    self.p_zytypeLb.layer.borderWidth = 1;
    
}

-(void)setFlexbleLayout{
    [self.p_headHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(5);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(65);
    }];
    
    [self.p_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.p_headHeadImageView.mas_right).offset(5);
        make.top.equalTo(self.p_headHeadImageView);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    
    [self.p_locaitonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.p_titleLb);
        make.top.equalTo(self.p_titleLb.mas_bottom).offset(10);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(11);
    }];
    
    [self.p_locationLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.p_locaitonImageView.mas_right).offset(5);
        make.centerY.equalTo(self.p_locaitonImageView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    
    [self.p_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.p_locaitonImageView);
        make.top.equalTo(self.p_locaitonImageView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    
    [self.p_distanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(100);
    }];
    
    
    [self.p_areLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.p_locaitonImageView);
        make.top.equalTo(self.p_countLb.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    
    
//    [self.p_zytypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.right.equalTo(self.contentView).offset(-10);
//        make.centerY.equalTo(self.p_countLb.mas_centerY);
//        make.width.mas_equalTo(35);
//        make.height.mas_equalTo(@20);
//    }];
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


-(void)setModel:(Ocean_FindMelistModel *)model{
    _model = model;
    [self.p_headHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.m_listpic] placeholderImage:[UIImage imageNamed:@"errorImage"]];
    self.p_titleLb.text = model.m_name;
    self.p_locationLb.text = model.m_compaddress;
    
    NSString * saleNum = model.m_soldallnum;
    if ([saleNum isKindOfClass:[NSNull class]]) {
        saleNum = @"0";
    }else if (!saleNum.length){
        saleNum = @"0";
    }else if ([@"null" isEqualToString:saleNum]){
        saleNum = @"0";
    }
    
    self.p_countLb.text = [NSString stringWithFormat:@"销量:%@  共:%@件产品",saleNum,model.m_allnum];
    self.p_areLb.text = [NSString stringWithFormat:@"%@ %@",model.m_area,model.m_cname?model.m_cname:@""];
    self.p_distanceLb.text = [NSString stringWithFormat:@"%@%@",model.m_distance,model.m_unit];
    if ([@"1" isEqualToString:model.m_zytype]) {
        self.p_zytypeLb.hidden = NO;
    }else{
        self.p_zytypeLb.hidden = YES;
    }
    [self setFlexbleLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    NSString *arestr =  self.p_areLb.text;
    self.p_zytypeLb.width = 35;
    self.p_zytypeLb.height = 20;
    self.p_zytypeLb.centerY = self.p_areLb.centerY;
    CGSize size  = [StringSizeModel sizeWithText:arestr font:[UIFont systemFontOfSize:14]];
    self.p_zytypeLb.x = self.p_areLb.x + size.width +5;
    
    
}

@end

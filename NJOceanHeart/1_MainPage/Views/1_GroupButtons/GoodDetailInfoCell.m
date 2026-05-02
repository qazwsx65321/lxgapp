//
//  GoodDetailInfoCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodDetailInfoCell.h"
#import "GoodDetailBody.h"
#import "JCTagListView.h"

@interface GoodDetailInfoCell()

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *countLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic,strong) UIView * p_emptyView;



@end

@implementation GoodDetailInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
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
    [self.contentView addSubview:_backView];
    
    _p_emptyView = [[UIView alloc]init];
    [_backView addSubview:_p_emptyView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_titleLabel];
    _titleLabel.numberOfLines = 0;
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [_backView addSubview:_priceLabel];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.textColor = [UIColor grayColor];
    _countLabel.font = [UIFont systemFontOfSize:14];
    _countLabel.textAlignment = NSTextAlignmentRight;
    [_backView addSubview:_countLabel];
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.text = @" 选择规格";
    _tipLabel.backgroundColor = RGB(241, 241, 241);
//    _tipLabel.textColor = [UIColor grayColor];
    _tipLabel.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_tipLabel];
    
    
    
    

    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

- (void)setGoodDetail:(GoodDetailRespBody *)goodDetail
{
    if (_goodDetail !=goodDetail) {
        _goodDetail = goodDetail;
        
        _titleLabel.text = goodDetail.m_title;
        _priceLabel.text = [NSString stringWithFormat:@"¥ %@", goodDetail.m_price];
        _countLabel.text = [NSString stringWithFormat:@"销量：%@", goodDetail.m_soldallnum];
      
    
        
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
        }];
        
       
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_backView).offset(10);
            make.left.equalTo(_backView).offset(10);
            make.right.equalTo(_backView.mas_right).offset(-10);
            
        }];
        
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.left.equalTo(_titleLabel);
            make.width.equalTo(@150);
            make.height.equalTo(@15);
        }];
        
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.right.equalTo(_backView.mas_right).offset(-10);
            make.width.equalTo(@150);
            make.height.equalTo(@15);
        }];
        
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_priceLabel.mas_bottom).offset(10);
            make.right.equalTo(_backView.mas_right);
            make.left.equalTo(_backView);
            make.height.equalTo(@30);
            make.bottom.equalTo(_backView.mas_bottom);
        }];

    }
    
}


@end

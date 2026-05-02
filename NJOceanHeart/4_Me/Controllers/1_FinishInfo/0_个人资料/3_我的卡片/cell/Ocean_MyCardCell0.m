//
//  Ocean_MyCardCell0.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MyCardCell0.h"

#import "Ocean_MyCardModel.h"

@interface Ocean_MyCardCell0 ()

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UIImageView *headPicImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) Ocean_CardView *carView;
@end

@implementation Ocean_MyCardCell0

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_MyCardCell0";
    Ocean_MyCardCell0 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_MyCardCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.picImageView = [[UIImageView alloc] init];
    self.picImageView.layer.cornerRadius = 5.f;
    self.picImageView.layer.masksToBounds = YES;
//    [self.contentView addSubview:self.picImageView];

    self.headPicImage = [[UIImageView alloc] init];
//    [self.picImageView addSubview:self.headPicImage];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textColor = [UIColor colorWithRed:0.914 green:0.012 blue:0.169 alpha:1.000];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.picImageView addSubview:self.nameLabel];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"【 一卡通--银卡 】";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithRed:0.878 green:0.608 blue:0.259 alpha:1.000];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.titleLabel];
    
    
    
}

- (void)setModel:(Ocean_MyCardModel *)model {
    
    if (_model !=model) {
        _model = model;
        
        
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.m_zpic] placeholderImage:[UIImage imageNamed:@"broken"]];
        [_headPicImage sd_setImageWithURL:[NSURL URLWithString:[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang] placeholderImage:[UIImage imageNamed:@"broken"]];
        _titleLabel.text = [NSString stringWithFormat:@"【 一卡通--%@ 】",model.m_name];
        _nameLabel.text = [Ocean_UserInfo sharedOcean_UserInfo].m_name;
        
        
        
        NSString *backImage = @"";
        NSString *TopImage = @"card_businessicon";
        NSString *IconImage = [Ocean_UserInfo sharedOcean_UserInfo].m_touxiang;
        NSString *bottomImage = @"card_wangzhi";
        NSString *cardNameImage = @"";
        
        if (model.m_name.length>0) {
            
            if ([model.m_name containsString:@"金"]) {
                
                cardNameImage =@"card_jinkaName";
                backImage = @"card_jinkaBack";
                
                
            }else if ([model.m_name containsString:@"银"] ||[model.m_name containsString:@"普"]){
                cardNameImage =@"card_yinkaName";
                backImage = @"card_pukaBack";
                
            }else if ([model.m_name containsString:@"钻"]){
                cardNameImage =@"card_zuanshiName";
                backImage = @"card_zuanshiBack";
                
            }
            
        }
        
        CGFloat SH = 600.f*screen_Width/750.f;

        self.carView = [Ocean_CardView initWithBackImageName:backImage Frame:CGRectMake(50.f/750.f*screen_Width, SH, 650.f/750.f*screen_Width, 380.f/600.f*SH) TopImage:TopImage IconImage:IconImage bottomImage:bottomImage cardNameImage:cardNameImage];
        [self.contentView addSubview:self.carView];
        
        [self setNeedsDisplay];

    }
    
   
    
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat SH = 600.f*screen_Width/750.f;
    
    self.picImageView.x = 50.f/750.f*screen_Width;
    self.picImageView.y = 85.f/600.f*SH;
    self.picImageView.width = 650.f/750.f*screen_Width;
    self.picImageView.height = 380.f/600.f*SH;
    
    self.headPicImage.x = 50.f/650.f*self.picImageView.width;
    self.headPicImage.width = 150.f/650.f*self.picImageView.width;
    self.headPicImage.height = self.headPicImage.width;
    self.headPicImage.centerY = self.picImageView.height/2.f;
    
    self.carView.frame = self.picImageView.frame;
    
    
    self.nameLabel.frame = CGRectMake(self.headPicImage.x, self.headPicImage.bottom + 5, self.headPicImage.width, 20);
    
    self.titleLabel.x = 0.f;
    self.titleLabel.y = self.picImageView.bottom;
    self.titleLabel.width = screen_Width;
    self.titleLabel.height = 135.f/500.f*SH;
    
}

@end

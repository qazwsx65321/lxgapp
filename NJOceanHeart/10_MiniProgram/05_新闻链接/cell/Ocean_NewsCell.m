//
//  Ocean_NewsCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_NewsCell.h"

@interface Ocean_NewsCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *ima0;
@property (nonatomic,strong) UIImageView *ima1;
@property (nonatomic,strong) UIImageView *ima2;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation Ocean_NewsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_NewsCell";
    Ocean_NewsCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.numberOfLines = 0;
    [self.bgView addSubview:self.titleLabel];
    
    self.ima0 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.ima0];
    
    self.ima1 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.ima1];
    
    self.ima2 = [[UIImageView alloc] init];
    [self.bgView addSubview:self.ima2];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.timeLabel];
    
}

- (void)setCellframes:(Ocean_NewsFrame *)cellframes {
    _cellframes = cellframes;
    
    _bgView.frame = cellframes.bgViewF;
    _titleLabel.frame = cellframes.titleLabelF;
    _ima0.frame = cellframes.ima0F;
    _ima1.frame = cellframes.ima1F;
    _ima2.frame = cellframes.ima2F;
    _nameLabel.frame = cellframes.nameLabelF;
    _timeLabel.frame = cellframes.timeLabelF;
    
    
    _titleLabel.text = cellframes.model.title;
    [_ima0 sd_setImageWithURL:[NSURL URLWithString:cellframes.model.thumbnail_pic_s]];
    [_ima1 sd_setImageWithURL:[NSURL URLWithString:cellframes.model.thumbnail_pic_s02]];
    [_ima2 sd_setImageWithURL:[NSURL URLWithString:cellframes.model.thumbnail_pic_s03]];
    _nameLabel.text = cellframes.model.author_name;
    _timeLabel.text = cellframes.model.date;
    
}

@end


@implementation Ocean_NewsFrame

- (void)setModel:(Ocean_NewsBody *)model {
    
    _model = model;
    
    _bgViewF = CGRectMake(0, 0, screen_Width, 100);
    
    CGSize titleS = [StringSizeModel sizeWithText:model.title font:[UIFont systemFontOfSize:13] maxW:screen_Width - 20];
    _titleLabelF = CGRectMake(10, 10, screen_Width - 20, titleS.height);
    
    CGFloat picW = (screen_Width - 40)/3.f;
    _ima0F = CGRectMake(10, CGRectGetMaxY(_titleLabelF)+5, 0, picW*2.f/3.f);
    if (model.thumbnail_pic_s.length > 0) {
        _ima0F = CGRectMake(10, CGRectGetMaxY(_titleLabelF)+5, picW, picW*2.f/3.f);
    }
    
    if (model.thumbnail_pic_s02.length > 0) {
        _ima1F = CGRectMake(CGRectGetMaxX(_ima0F)+10, CGRectGetMaxY(_titleLabelF)+5, picW, picW*2.f/3.f);
    }
    
    if (model.thumbnail_pic_s03.length > 0) {
        _ima2F = CGRectMake(CGRectGetMaxX(_ima2F)+10, CGRectGetMaxY(_titleLabelF)+5, picW, picW*2.f/3.f);
    }
    
    if (model.thumbnail_pic_s.length > 0 || model.thumbnail_pic_s02.length > 0 || model.thumbnail_pic_s03.length > 0) {
        _nameLabelF = CGRectMake(10, CGRectGetMaxY(_ima0F) + 5, screen_Width / 2.f - 10, 20);
        
    }else {
        _nameLabelF = CGRectMake(10, CGRectGetMaxY(_titleLabelF) + 5, screen_Width / 2.f - 10, 20);
    }
    
    _timeLabelF = CGRectMake(screen_Width/2.f, _nameLabelF.origin.y, screen_Width / 2.f - 10, 20);
    
    _bgViewF.size.height = CGRectGetMaxY(_timeLabelF)+10;
    
}

@end

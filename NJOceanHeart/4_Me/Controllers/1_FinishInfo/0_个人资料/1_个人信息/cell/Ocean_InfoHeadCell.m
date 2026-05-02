//
//  Ocean_InfoHeadCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/25.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_InfoHeadCell.h"

@interface Ocean_InfoHeadCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *picImage;
@property (nonatomic,strong) UIView *line;

@end

@implementation Ocean_InfoHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_InfoHeadCell";
    Ocean_InfoHeadCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_InfoHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.picImage = [[UIImageView alloc] init];
    [self.bgView addSubview:self.picImage];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    [self.bgView addSubview:self.line];
    
}


- (void)setCardImage:(NSString *)cardImage {
    _cardImage = cardImage;
    [_picImage sd_setImageWithURL:[NSURL URLWithString:cardImage] placeholderImage:[UIImage imageNamed:@"me_user"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 100);
    self.picImage.frame = CGRectMake((screen_Width - 80)/2.f, 10, 80, 80);
    self.picImage.layer.cornerRadius = 40;
    self.picImage.layer.masksToBounds = YES;
    self.line.frame = CGRectMake(0, 99, screen_Width, 1);
    
}

@end

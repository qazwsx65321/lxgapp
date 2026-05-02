//
//  Ocean_PersonageInfoCell0.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_PersonageInfoCell0.h"

@interface Ocean_PersonageInfoCell0 ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *headButton;

@end

@implementation Ocean_PersonageInfoCell0

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_PersonageInfoCell0";
    Ocean_PersonageInfoCell0 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_PersonageInfoCell0 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"头像";
    self.label.textColor = [UIColor colorWithWhite:0.384 alpha:1.000];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.label];
    
    self.headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_user"]];
    [self.bgView addSubview:self.headImageView];
    
    self.headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.headButton];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat SH = 130.f*screen_Width/750.f;
    
    CGFloat bgX = 0;
    CGFloat bgY = 0;
    CGFloat bgW = screen_Width;
    CGFloat bgH = SH;
    self.bgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat laX = 25.f/750.f*screen_Width;
    CGFloat laY = 0;
    CGFloat laW = 130.f/750.f*screen_Width;
    CGFloat laH = SH;
    self.label.frame = CGRectMake(laX, laY, laW, laH);
    
    CGFloat picX = 640.f/750.f*screen_Width;
    CGFloat picW = 80.f/750.f*screen_Width;
    CGFloat picH = picW;
    CGFloat picY = (SH - picH) / 2.f;
    self.headImageView.frame = CGRectMake(picX, picY, picW, picH);
    self.headImageView.layer.cornerRadius = picW / 2.f;
    self.headImageView.layer.masksToBounds = YES;
    
    self.headButton.frame = CGRectMake(picX, picY, picW, picH);
    self.headButton.layer.cornerRadius = picW / 2.f;
    self.headButton.layer.masksToBounds = YES;
    
}

@end

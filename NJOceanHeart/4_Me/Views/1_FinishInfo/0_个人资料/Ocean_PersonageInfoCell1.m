//
//  Ocean_PersonageInfoCell1.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_PersonageInfoCell1.h"

@interface Ocean_PersonageInfoCell1 ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation Ocean_PersonageInfoCell1

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_PersonageInfoCell1";
    Ocean_PersonageInfoCell1 *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_PersonageInfoCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    self.label.textColor = [UIColor colorWithRed:0.286 green:0.290 blue:0.294 alpha:1.000];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.label];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor colorWithRed:0.553 green:0.557 blue:0.561 alpha:1.000];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.nameLabel];
}

-(void)setType:(NSInteger)type {
    _type = type;
    
    switch (type) {
        case 1:
        {
            _label.text = @"昵称";
            _nameLabel.hidden = NO;
            _nameLabel.text = [Ocean_UserInfo sharedOcean_UserInfo].m_nickname;
        }
            break;
        case 2:
        {
            _label.text = @"我的二维码";
            _nameLabel.hidden = YES;
        }
            break;
        case 3:
        {
            _label.text = @"个人信息";
            _nameLabel.hidden = YES;
        }
            break;
        case 4:
        {
            _label.text = @"职业信息";
            _nameLabel.hidden = YES;
        }
            break;
        case 5:
        {
            _label.text = @"我的卡片";
            _nameLabel.hidden = YES;
        }
            break;
        case 6:
        {
            _label.text = @"收货地址";
            _nameLabel.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}


- (void)setNameText:(NSString *)nameText {
    _nameText = nameText;
    
    _nameLabel.text = nameText;
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
    CGFloat laW = 200.f/750.f*screen_Width;
    CGFloat laH = SH;
    self.label.frame = CGRectMake(laX, laY, laW, laH);
    
    self.nameLabel.frame = CGRectMake(self.label.right, laY, screen_Width - 30 - self.label.right, laH);
    
}

@end

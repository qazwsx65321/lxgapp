//
//  Ocean_SearchFriendCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/20.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_SearchFriendCell.h"

#import "Ocean_SearchModel.h"

#import "ContactModel.h"

@interface Ocean_SearchFriendCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *buttonLabel;

@end

@implementation Ocean_SearchFriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_SearchFriendCell";
    Ocean_SearchFriendCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_SearchFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 50)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    self.picView.layer.cornerRadius = 20.f;
    self.picView.layer.masksToBounds = YES;
    [self.bgView addSubview:self.picView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.picView.right+10, 10, 100.f/320.f*screen_Width, 30)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.nameLabel];
    
    self.buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, 10, screen_Width - 20 - self.nameLabel.right, 30)];
    self.buttonLabel.text = @"添加";
    self.buttonLabel.font = [UIFont systemFontOfSize:15];
    self.buttonLabel.textColor = [UIColor colorWithRed:0.145 green:0.573 blue:0.357 alpha:1.000];
    self.buttonLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.buttonLabel];
    
}

- (void)setModel:(Ocean_SearchModel *)model {
    _model = model;
    
    [_picView sd_setImageWithURL:[NSURL URLWithString:model.m_headpic] placeholderImage:[UIImage imageNamed:@"HYZXIcon"]];
    _nameLabel.text = model.m_nickname;
    if ([@"0" isEqualToString:model.m_isfriend]) {
        _buttonLabel.text = @"添加";
    }else {
        _buttonLabel.text = @"好友";
    }
}



- (void)setContactmodel:(ContactModel *)contactmodel {
    _contactmodel = contactmodel;
    [_picView sd_setImageWithURL:[NSURL URLWithString:contactmodel.iconUrl] placeholderImage:[UIImage imageNamed:@"HYZXIcon"]];
    _nameLabel.text = contactmodel.name;
    if ([@"0" isEqualToString:contactmodel.type]) {
        _buttonLabel.text = @"";
    }else if ([@"1" isEqualToString:contactmodel.type]) {
        _buttonLabel.text = @"添加";
        _buttonLabel.textColor = [UIColor colorWithRed:0.145 green:0.573 blue:0.357 alpha:1.000];
    }else {
        _buttonLabel.text = @"已添加";
        _buttonLabel.textColor = [UIColor lightGrayColor];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end

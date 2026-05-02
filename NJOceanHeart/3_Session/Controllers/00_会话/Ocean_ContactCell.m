//
//  Ocean_ContactCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ContactCell.h"

#import "Ocean_FriendsModel.h"

@interface Ocean_ContactCell()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIButton *roundBtn;
@property (nonatomic,strong) UIImageView *headPic;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation Ocean_ContactCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ContactCell";
    Ocean_ContactCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell == nil) {
        cell  = [[Ocean_ContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.roundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.roundBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [self.roundBtn setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
    [self.bgView addSubview:self.roundBtn];
    
    self.headPic = [[UIImageView alloc] init];
    self.headPic.image = [UIImage imageNamed:@"user01"];
    [self.bgView addSubview:self.headPic];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"111111";
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.nameLabel];
}

- (void)setIsTongXun:(BOOL)isTongXun {
    _isTongXun = isTongXun;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, self.width, 60);
    
    if (_isTongXun == YES) {
        self.roundBtn.hidden = YES;
        self.roundBtn.frame = CGRectMake(0, 0, 0, 0);
        
        self.headPic.frame = CGRectMake(self.roundBtn.right + 10, 10, 40, 40);
        self.headPic.layer.cornerRadius = 20;
        self.headPic.layer.masksToBounds = YES;
        
        self.nameLabel.frame = CGRectMake(self.headPic.right + 10, 0, self.width - (self.headPic.right + 10), 60);
    }else {
        self.roundBtn.hidden = NO;
        self.roundBtn.frame = CGRectMake(20, 20, 20, 20);
        
        self.headPic.frame = CGRectMake(self.roundBtn.right + 10, 10, 40, 40);
        self.headPic.layer.cornerRadius = 20;
        self.headPic.layer.masksToBounds = YES;
        
        self.nameLabel.frame = CGRectMake(self.headPic.right + 10, 0, self.width - (self.headPic.right + 10), 60);
    }
    
    
    
}

- (void)setModel:(Ocean_FriendsModel *)model {
    _model = model;
    
    [_headPic sd_setImageWithURL:[NSURL URLWithString:model.m_headpic] placeholderImage:[UIImage imageNamed:@"me_user"]];
    _nameLabel.text = model.m_nickname;
}


- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    _roundBtn.selected = isSelect;
}

@end

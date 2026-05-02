//
//  Ocean_ContactsCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ContactsCell.h"

@interface Ocean_ContactsCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation Ocean_ContactsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ContactsCell";
    Ocean_ContactsCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell == nil) {
        cell  = [[Ocean_ContactsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.picImageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.picImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor colorWithRed:0.157 green:0.161 blue:0.165 alpha:1.000];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.nameLabel];
}

- (void)setType:(NSInteger)type {
    _type = type;
    
    switch (type) {
        case 0:
        {
            _picImageView.image = [UIImage imageNamed:@"lxr"];
            _nameLabel.text = @"本地联系人";
        }
            break;
        case 1:
        {
            _picImageView.image = [UIImage imageNamed:@"tlz"];
            _nameLabel.text = @"讨论组";
        }
            break;
        case 2:
        {
            _picImageView.image = [UIImage imageNamed:@"qz"];
            _nameLabel.text = @"群组";
        }
            break;
            
        default:
            break;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat bgX = 0;
    CGFloat bgY = 0;
    CGFloat bgW = screen_Width;
    CGFloat bgH = 60;
    self.bgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat imaX = 10;
    CGFloat imaY = 10;
    CGFloat imaW = 40;
    CGFloat imaH = 40;
    self.picImageView.frame = CGRectMake(imaX, imaY, imaW, imaH);
    
    CGFloat nameX = self.picImageView.right + 10;
    CGFloat nameY = 10;
    CGFloat nameW = screen_Width - nameX - 10;
    CGFloat nameH = 40;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
}

@end

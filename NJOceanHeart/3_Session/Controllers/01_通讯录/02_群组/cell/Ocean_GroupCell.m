//
//  Ocean_GroupCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupCell.h"

#import "Ocean_GroupModel.h"

@interface Ocean_GroupCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation Ocean_GroupCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_GroupCell";
    Ocean_GroupCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_GroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 60)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.picImageView.layer.cornerRadius = 20;
    self.picImageView.layer.masksToBounds = YES;
    [self.bgView addSubview:self.picImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, screen_Width - 70, 40)];
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.nameLabel];
    
    
}


- (void)setModel:(Ocean_GroupModel *)model {
    _model = model;
    
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.m_picture] placeholderImage:[UIImage imageNamed:@"actionbar_picture_icon"]];
    _nameLabel.text = model.m_name;
}


@end

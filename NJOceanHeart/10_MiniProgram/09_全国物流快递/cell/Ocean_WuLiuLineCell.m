//
//  Ocean_WuLiuLineCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_WuLiuLineCell.h"

#import "Ocean_DataModel.h"

@interface Ocean_WuLiuLineCell ()

@property (nonatomic,strong) UIImageView *roundView;
@property (nonatomic,strong) UIView *topline;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *bottomline;

@end

@implementation Ocean_WuLiuLineCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_WuLiuLineCell";
    Ocean_WuLiuLineCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_WuLiuLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
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
    
    self.topline = [[UIView alloc] init];
    self.topline.backgroundColor = [UIColor colorWithRed:0.957 green:0.345 blue:0.278 alpha:1.000];
    [self.contentView addSubview:self.topline];
    
    self.roundView = [[UIImageView alloc] init];
    self.roundView.image = [UIImage imageNamed:@"check_pre"];
    [self.contentView addSubview:self.roundView];
    
    self.bottomline = [[UIView alloc] init];
    self.bottomline.backgroundColor = [UIColor colorWithRed:0.957 green:0.345 blue:0.278 alpha:1.000];
    [self.contentView addSubview:self.bottomline];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = [UIColor lightGrayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    
}

- (void)setModel:(Ocean_WuLiuBody *)model {
    
    _model = model;
    
    _contentLabel.text = [NSString stringWithFormat:@"%@\n%@",model.status,model.time];
    
}

- (void)setCount:(NSInteger)count {
    _count = count;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    if (index == 0) {
        _topline.hidden = YES;
    }else {
        _topline.hidden = NO;
        
        if (index == _count) {
            _bottomline.hidden = YES;
        }else {
            _bottomline.hidden = NO;
        }
        
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.topline.frame = CGRectMake(15, 0, 1, 20);
    self.roundView.frame = CGRectMake(10, 20, 10, 10);
    self.roundView.layer.cornerRadius = 5.f;
    self.roundView.layer.masksToBounds = YES;
    self.bottomline.frame = CGRectMake(15, 30, 1, 20);
    self.contentLabel.frame = CGRectMake(30, 0, screen_Width - 40, 50);
    
    
}

@end

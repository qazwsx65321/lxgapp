//
//  Ocean_DriveCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DriveCell.h"

@interface Ocean_DriveCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *idLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *pointLabel;
@end

@implementation Ocean_DriveCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_DriveCell";
    Ocean_DriveCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_DriveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.idLabel = [[UILabel alloc] init];
//    self.idLabel.text = @"档案编号: 330000000000";
    self.idLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.idLabel];
    
    self.numLabel = [[UILabel alloc] init];
//    self.numLabel.text = @"驾驶证号: 412336111111111111";
    self.numLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.numLabel];
    
    self.pointLabel = [[UILabel alloc] init];
//    self.pointLabel.text = @"扣分: 0";
    self.pointLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.pointLabel];
}

- (void)setDic:(NSDictionary *)dic {
    
    _dic = dic;
    
    _idLabel.text = [NSString stringWithFormat:@"档案编号: %@",dic[@"licenseid"]];
    _numLabel.text = [NSString stringWithFormat:@"驾驶证号: %@",dic[@"licensenumber"]];
    _pointLabel.text = [NSString stringWithFormat:@"扣分: %@",dic[@"score"]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 100);
    self.idLabel.frame = CGRectMake(10, 10, screen_Width - 20, 20);
    self.numLabel.frame = CGRectMake(10, 40, screen_Width - 20, 20);
    self.pointLabel.frame = CGRectMake(10, 70, screen_Width - 20, 20);
    
}

@end

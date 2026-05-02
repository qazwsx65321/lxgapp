//
//  Ocean_TrainLineCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_TrainLineCell.h"

#import "Ocean_DataModel.h"

@interface Ocean_TrainLineCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *starLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,strong) UIView *sepline;

@end

@implementation Ocean_TrainLineCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_TrainLineCell";
    Ocean_TrainLineCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_TrainLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.starLabel = [[UILabel alloc] init];
    self.starLabel.text = @"00:03\n南京";
    self.starLabel.numberOfLines = 0;
    self.starLabel.font = [UIFont systemFontOfSize:11];
    [self.bgView addSubview:self.starLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"Z178\n-------->\n1时51分";
    self.timeLabel.numberOfLines = 0;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    [self.bgView addSubview:self.timeLabel];
    
    self.endLabel = [[UILabel alloc] init];
    self.endLabel.text = @"01:54\n无锡";
    self.endLabel.numberOfLines = 0;
    self.endLabel.font = [UIFont systemFontOfSize:11];
    self.endLabel.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.endLabel];
    
    self.sepline = [[UIView alloc] init];
    self.sepline.backgroundColor = [UIColor lightlightGrayColor];
    [self.bgView addSubview:self.sepline];
    
}

- (void)setModel:(Ocean_TrainModel *)model {
    
    
    _model = model;
    
    
    _starLabel.text = [NSString stringWithFormat:@"%@\n%@",model.departuretime,model.station];
    _timeLabel.text = [NSString stringWithFormat:@"%@\n-------->\n%@",model.trainno,model.costtime];
    _endLabel.text = [NSString stringWithFormat:@"%@\n%@",model.arrivaltime,model.endstation];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 60);
    self.starLabel.frame = CGRectMake(20, 0, (screen_Width - 40)/3.f, 50);
    self.timeLabel.frame = CGRectMake(self.starLabel.right, 0, (screen_Width - 40)/3.f, 50);
    self.endLabel.frame = CGRectMake(self.timeLabel.right, 0, (screen_Width - 40)/3.f, 50);
    self.sepline.frame = CGRectMake(10, 50, screen_Width - 20, 1);
    
}

@end

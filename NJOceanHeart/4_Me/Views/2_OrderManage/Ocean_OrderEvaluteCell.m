//
//  Ocean_OrderEvaluteCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_OrderEvaluteCell.h"
#import "XDTextView.h"
#import "MeStarRateView.h"
#import "Ocean_StoreModel.h"
#import "Ocean_OrderEvaluteModel.h"

@interface Ocean_OrderEvaluteCell ()<XDTextViewDelegate,MeStarRateViewDelegate>

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *starLabel;
@property (nonatomic,strong) MeStarRateView *starView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) XDTextView *textView;

@end

@implementation Ocean_OrderEvaluteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_OrderEvaluteCell";
    Ocean_OrderEvaluteCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_OrderEvaluteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 191)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.bgView addSubview:self.picImageView];
    
    self.starLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.picImageView.right + 10, 10, screen_Width - (self.picImageView.right + 10), 20)];
    self.starLabel.text = @"星级评价";
    self.starLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.starLabel];
    
    self.starView = [[MeStarRateView alloc] initWithFrame:CGRectMake(self.picImageView.right + 10, 40, 150, 20) numberOfStars:5 andLightStar:@"star_pre" andDarkStar:@"star"];
    self.starView.delegate = self;
    self.starView.scorePercent = 0.f;
    [self.bgView addSubview:self.starView];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, self.picImageView.bottom + 10, screen_Width, 1)];
    self.line.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    [self.bgView addSubview:self.line];
    
    self.textView = [[XDTextView alloc] initWithFrame:CGRectMake(0, self.line.bottom, screen_Width, 100)];
    self.textView.delegate = self;
    self.textView.XD_placehodel = @"来评价下商品吧";
    self.textView.XD_font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.textView];
    
}

- (void)setEvalutModel:(Ocean_OrderEvaluteModel *)evalutModel {
    _evalutModel = evalutModel;
 
}


- (void)didChangeXDText:(XDTextView *)textView {
    _evalutModel.m_content = textView.XD_text;
}

- (void)starRateView:(MeStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScrorePercent {
    
    _evalutModel.m_starnum = [NSString stringWithFormat:@"%zd",(int)(newScrorePercent*5)];
    
}

- (void)setModel:(Ocean_StoreCommodityModel *)model {
    _model = model;
    
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.m_pic] placeholderImage:[UIImage imageNamed:@"3"]];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end

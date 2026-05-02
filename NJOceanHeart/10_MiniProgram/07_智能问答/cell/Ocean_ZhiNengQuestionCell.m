//
//  Ocean_ZhiNengQuestionCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ZhiNengQuestionCell.h"

@interface Ocean_ZhiNengQuestionCell ()

@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UITextView *contentLabel;
@property (nonatomic,strong) UILabel *replyLabel;
@property (nonatomic,strong) UILabel *relquestionLabel;

@end

@implementation Ocean_ZhiNengQuestionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ZhiNengQuestionCell";
    Ocean_ZhiNengQuestionCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ZhiNengQuestionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.typeLabel];
    
    self.replyLabel = [[UILabel alloc] init];
    self.replyLabel.text = @"回复内容: ";
    self.replyLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.replyLabel];
    
    self.contentLabel = [[UITextView alloc] init];
    self.contentLabel.editable = NO;
    self.contentLabel.userInteractionEnabled = NO;
    self.contentLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.contentLabel];
    
    self.relquestionLabel = [[UILabel alloc] init];
    self.relquestionLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.relquestionLabel];
    
}

- (void)setCellframes:(Ocean_ZhiNengQuestionFrame *)cellframes {
    
    _cellframes = cellframes;
    
    _typeLabel.frame = cellframes.typeLabelF;
    _replyLabel.frame = cellframes.replyLabelF;
    _contentLabel.frame = cellframes.contentLabelF;
    _relquestionLabel.frame = cellframes.relquestionLabelF;
    
    _typeLabel.text = [NSString stringWithFormat:@"回复类型: %@",cellframes.dic[@"type"]];
    _contentLabel.text = cellframes.dic[@"content"];
    _relquestionLabel.text = [NSString stringWithFormat:@"相关问题: %@",cellframes.dic[@"relquestion"]];
    
}

@end


@implementation Ocean_ZhiNengQuestionFrame

- (void)setDic:(NSDictionary *)dic {
    
    _dic = dic;
    
    _typeLabelF = CGRectMake(10, 10, screen_Width - 20, 20);
    
    CGSize reoS = [StringSizeModel sizeWithText:@"回复内容: " font:[UIFont systemFontOfSize:13]];
    _replyLabelF = CGRectMake(10, CGRectGetMaxY(_typeLabelF)+10, reoS.width, [StringSizeModel sizeWithText:@"回复内容: " font:[UIFont systemFontOfSize:13]].height);
    
    
    CGSize conS = [StringSizeModel sizeWithText:dic[@"content"] font:[UIFont systemFontOfSize:13] maxW:screen_Width - CGRectGetMaxX(_replyLabelF) - 10];
    _contentLabelF = CGRectMake(CGRectGetMaxX(_replyLabelF), CGRectGetMaxY(_typeLabelF)+10, conS.width, conS.height);
    
    _relquestionLabelF = CGRectMake(10, CGRectGetMaxY(_contentLabelF) + 10, screen_Width - 20, 20);
    
    _cellhight = CGRectGetMaxY(_relquestionLabelF) + 10;
    
}

@end

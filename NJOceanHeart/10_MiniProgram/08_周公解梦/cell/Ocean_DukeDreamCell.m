//
//  Ocean_DukeDreamCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DukeDreamCell.h"
#import "XDLabel.h"

@interface Ocean_DukeDreamCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) XDLabel *explainLabel;

@end

@implementation Ocean_DukeDreamCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_DukeDreamCell";
    Ocean_DukeDreamCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_DukeDreamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.titleLabel];
    
    self.explainLabel = [[XDLabel alloc] init];
    self.explainLabel.font = [UIFont systemFontOfSize:13];
    self.explainLabel.numberOfLines = 0;
    [self.bgView addSubview:self.explainLabel];
    
}

- (void)setCellframes:(Ocean_DukeDreamFrame *)cellframes {
    _cellframes = cellframes;
    
    _bgView.frame = cellframes.bgViewF;
    _titleLabel.frame = cellframes.titleLabelF;
    _explainLabel.frame = cellframes.explainLabelF;
    
    _titleLabel.text = cellframes.model.name;
    _explainLabel.text = cellframes.XD_content;
    
    _explainLabel.XD_lineSpace = 4;
    [_explainLabel XD_setAttributeWithType:LINESPACE];
    
}

@end


@implementation Ocean_DukeDreamFrame

- (void)setModel:(Ocean_JieMengModel *)model {
    
    _model = model;
    
    _bgViewF = CGRectMake(0, 0, screen_Width, 100);
    
    _titleLabelF = CGRectMake(10, 10, screen_Width - 20, 20);
    
    _XD_content = model.content;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_XD_content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _XD_content = [NSString stringWithFormat:@"%@",attrStr];
    
    NSArray *array = [_XD_content componentsSeparatedByString:@"{"];
    _XD_content = array[0];
    
    CGSize conS = [StringSizeModel sizeWithText:_XD_content font:[UIFont systemFontOfSize:13] maxW:screen_Width - 20  withLineSpace:4];
    
    _explainLabelF = CGRectMake(10, 30, screen_Width - 20, conS.height);
    
    _bgViewF.size.height = CGRectGetMaxY(_explainLabelF);
    
}

@end

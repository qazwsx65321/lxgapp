//
//  GoodCommentCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodCommentCell.h"
#import "GoodDetailCommentBody.h"
#import "StarView.h"

@interface GoodCommentCell()

@property (nonatomic, strong)UIView *topBackView;
@property (nonatomic, strong)UIView *bottomBackView;
@property (nonatomic, strong)UIImageView *headImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)StarView *starView;
@property (nonatomic, strong)UILabel *contentLabel;

@end

@implementation GoodCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"GoodCommentCell";
    GoodCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GoodCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        // 绘制底图
        [self setupCellView];
        
    }
    return self;
}

- (void)setupCellView
{
    _topBackView = [[UIView alloc] init];
    _topBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topBackView];
    
    _headImageView = [[UIImageView alloc] init];
    [_topBackView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [_topBackView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [_topBackView addSubview:_timeLabel];
    
    _bottomBackView = [[UIView alloc] init];
    _bottomBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomBackView];
    
    _starView = [[StarView alloc] init];
    _starView.font_size = 20;
//    _starView.max_star = 5;
    _starView.canSelected = NO;
    [_bottomBackView addSubview:_starView];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    [_bottomBackView addSubview:_contentLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _topBackView.width = self.width;
    _topBackView.height = 35;
    _topBackView.x = 0;
    _topBackView.y = 0;
    
    _headImageView.width = _headImageView.height = 28;
    _headImageView.x = 15;
    _headImageView.y = 4;
    
    _nameLabel.width = 120;
    _nameLabel.height = _headImageView.height;
    _nameLabel.x = CGRectGetMaxX(_headImageView.frame) + 15;
    _nameLabel.y = _headImageView.y;
    
    _timeLabel.width = 140;
    _timeLabel.height = 10;
    _timeLabel.x = _topBackView.width - _timeLabel.width - 15;
    _timeLabel.y = 20;
    
    _bottomBackView.width = self.width;
    _bottomBackView.height = self.height - 40;
    _bottomBackView.x = 0;
    _bottomBackView.y = 36;
    
    _starView.width = 200;
    _starView.height = 24;
    _starView.x = 15;
    _starView.y = 10;
    
    _contentLabel.x = _starView.x;
    _contentLabel.y = CGRectGetMaxY(_starView.frame) + 10;
    _contentLabel.width = _bottomBackView.width - 2 * _contentLabel.x;
    _contentLabel.height = [StringSizeModel sizeWithText:_comment.m_content font:[UIFont systemFontOfSize:14] maxW:self.width - 2 * _contentLabel.x].height;

}

- (void)setComment:(GoodDetailCommentModel *)comment
{
    _comment = comment;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:comment.m_headpicture]];
    _nameLabel.text = comment.m_name;
    _timeLabel.text = [self convertTime:comment.m_buildtime];
    _contentLabel.text = comment.m_content;
    _starView.show_star = [comment.m_star integerValue] * 20;
}
- (NSString *)convertTime:(NSString *)string
{
    NSString *year = [string substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [string substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [string substringWithRange:NSMakeRange(6, 2)];
    NSString *hour = [string substringWithRange:NSMakeRange(8, 2)];
    NSString *minute = [string substringWithRange:NSMakeRange(10, 2)];
    NSString *second = [string substringWithRange:NSMakeRange(12, 2)];
    return [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@", year, month, day, hour, minute, second];
}

@end

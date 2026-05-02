//
//  UserCommentCell.m
//  Glad9TM
//
//  Created by 陈志伟 on 17/6/8.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "UserCommentCell.h"
#import "MeStarRateView.h"
#import "UserCommentModel.h"
#import "XRPhotoView.h"

@interface UserCommentCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *XD_headPic;
@property (nonatomic,strong) UILabel *XD_nameLabel;
@property (nonatomic,strong) UILabel *XD_timeLabel;
@property (nonatomic,strong) UILabel *XD_contentLabel;
@property (nonatomic,strong) XRPhotoView *photoView;
@property (nonatomic,strong) MeStarRateView *XD_starView;

@end

@implementation UserCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"UserCommentCell";
    UserCommentCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[UserCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    
    self.XD_headPic = [[UIImageView alloc] init];
    self.XD_headPic.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:self.XD_headPic];
    
    self.XD_nameLabel = [[UILabel alloc] init];
    self.XD_nameLabel.textColor = [UIColor colorWithWhite:0.286 alpha:1.000];
    self.XD_nameLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.XD_nameLabel];
    
    self.XD_timeLabel = [[UILabel alloc]init];
    self.XD_timeLabel.textColor = [UIColor colorWithWhite:0.729 alpha:1.000];
    self.XD_timeLabel.textAlignment = NSTextAlignmentRight;
    self.XD_timeLabel.font = [UIFont systemFontOfSize:11];
    [self.bgView addSubview:self.XD_timeLabel];
    
    self.photoView = [[XRPhotoView alloc] init];
    [self.bgView addSubview:self.photoView];
    
    self.XD_contentLabel = [[UILabel alloc]init];
    self.XD_contentLabel.textColor = [UIColor colorWithWhite:0.729 alpha:1.000];
    self.XD_contentLabel.font = [UIFont systemFontOfSize:11];
    self.XD_contentLabel.numberOfLines = 0;
    [self.bgView addSubview:self.XD_contentLabel];
}

- (void)setXD_frame:(UserCommentFrame *)XD_frame {
    
    if (_XD_frame != XD_frame) {
        _XD_frame = XD_frame;
        
        _bgView.frame = XD_frame.bgViewF;//alipay
        
        [_XD_headPic sd_setImageWithURL:[NSURL URLWithString:XD_frame.model.m_headpicture] placeholderImage:[UIImage imageNamed:@"header_img_03"]];
        _XD_headPic.frame = XD_frame.XD_headPicF;
        _XD_headPic.layer.cornerRadius = _XD_headPic.frame.size.width / 2.f;
        _XD_headPic.layer.masksToBounds = YES;
        
        _XD_nameLabel.text = XD_frame.model.m_name;
        _XD_nameLabel.frame = XD_frame.XD_nameLabelF;
        
        _XD_timeLabel.text = XD_frame.model.m_buildtime;
        _XD_timeLabel.frame = XD_frame.XD_timeLabelF;
        
        _photoView.frame = XD_frame.photoViewF;
        _photoView.images = XD_frame.model.m_picturedesc;
        
        _XD_starView = [[MeStarRateView alloc] initWithFrame:XD_frame.XD_starViewF numberOfStars:5 andLightStar:@"stars_pre" andDarkStar:@"stars-"];
        _XD_starView.scorePercent = [XD_frame.model.m_star floatValue] / 5.f;
        _XD_starView.allowIncompleteStar = YES;
        [self.bgView addSubview:_XD_starView];
        
        _XD_contentLabel.text = XD_frame.model.m_content;
        _XD_contentLabel.frame = XD_frame.XD_contentLabelF;
    }
    
}



@end


@implementation UserCommentFrame

- (void)setModel:(UserCommentModel *)model {
    _model = model;
    
    CGFloat SH = 375.f*screen_Width / 751.f;
    
    CGFloat bgX = 0;
    CGFloat bgY = 0;
    CGFloat bgW = screen_Width;
    CGFloat bgH = SH;
    _bgViewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat headX = 20.f/751.f*screen_Width;
    CGFloat headY = 30.f/375.f*SH;
    CGFloat headW = 80.f/751.f*screen_Width;
    CGFloat headH = headW;
    _XD_headPicF = CGRectMake(headX, headY, headW, headH);
    
    CGFloat nameX = CGRectGetMaxX(_XD_headPicF) + 32.f/751.f*screen_Width;
    CGFloat nameY = headY;
    CGFloat nameW = 450.f/751.f*screen_Width;
    CGFloat nameH = 24.f/375.f*SH;
    _XD_nameLabelF = CGRectMake(nameX, nameY, nameW, nameH);
    
    _XD_timeLabelF = CGRectMake(CGRectGetMaxX(_XD_nameLabelF), nameY, 150.f/751.f*screen_Width, nameH);
    
    CGFloat starX = nameX;
    CGFloat starY = CGRectGetMaxY(_XD_nameLabelF) + 15.f/375.f*SH;
    CGFloat starW = 190.f/751.f*screen_Width;
    CGFloat starH = 25.f/375.f*SH;
    _XD_starViewF = CGRectMake(starX, starY, starW, starH);
    
    CGSize conS = [StringSizeModel sizeWithText:model.m_content font:[UIFont systemFontOfSize:11] maxW:580.f/751.f*screen_Width];
    
    CGFloat conX = nameX;
    CGFloat conY = CGRectGetMaxY(_XD_starViewF) + 15.f/375.f*SH;
    CGFloat conW = 580.f/751.f*screen_Width;
    CGFloat conH = conS.height;
    _XD_contentLabelF = CGRectMake(conX, conY, conW, conH);
    
    _bgViewF = CGRectMake(bgX, bgY, bgW, CGRectGetMaxY(_XD_contentLabelF) + 5);
    
//    CGFloat picX = nameX;
//    CGFloat picY = CGRectGetMaxY(_XD_contentLabelF) + 15.f/375.f*SH;
//    CGFloat picW = 0.0f;
//    CGFloat picH = 0.0f;
//    
//    
//    if (model.m_picturedesc.count) {
//        CGSize imgSize = [XRPhotoView sizeWithImageCount:model.m_picturedesc.count];
//        picW = imgSize.width;
//        picH = imgSize.height;
//        self.photoViewF = CGRectMake(picX, picY, picW, picH);
//        
//        _bgViewF = CGRectMake(bgX, bgY, bgW, CGRectGetMaxY(_photoViewF) + 5);
//    }
    
    
    
    _cellHeight = CGRectGetMaxY(_bgViewF) + 1;
    
    
}

@end

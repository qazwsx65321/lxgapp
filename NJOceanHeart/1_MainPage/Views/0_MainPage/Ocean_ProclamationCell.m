//
//  Ocean_ProclamationCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ProclamationCell.h"
#import "Ocean_FIRSTPAGESHOWModel.h"
@interface Ocean_ProclamationCell()

@property (nonatomic,weak) UILabel * p_contentLb;
@property (nonatomic,weak) UILabel * p_timeLb;

@end

@implementation Ocean_ProclamationCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

        UILabel *conentLb = [[UILabel alloc]init];
        conentLb.font = [UIFont systemFontOfSize:15];
        self.p_contentLb = conentLb;
        conentLb.numberOfLines = 0;
        [self.contentView addSubview:conentLb];
        
        UILabel *timeLb = [[UILabel alloc]init];
        self.p_timeLb = timeLb;
        timeLb.textColor =[UIColor lightGrayColor];
        timeLb.font  = [UIFont systemFontOfSize:14];
        timeLb.numberOfLines = 0;
        [self.contentView addSubview:timeLb];
        
        [self.p_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        [self.p_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.p_contentLb.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
    }
    return self;
}

-(void)setModel:(announcementModel *)model{
    _model = model;
    self.p_contentLb.text = model.m_title;
    self.p_timeLb.text = model.m_buildtime;
  
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


@end

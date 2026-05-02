//
//  Ocean_GroupInfoCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupInfoCell.h"

#import "Ocean_GroupModel.h"

@interface Ocean_GroupInfoCell ()

@property (nonatomic,strong) UIImageView *picImageView;

@end

@implementation Ocean_GroupInfoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    
    CGFloat BW = (screen_Width - 60.f/320.f*screen_Width)/5.f;
    
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BW, BW)];
    self.picImageView.layer.cornerRadius = BW/2.f;
    self.picImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.picImageView];
    
}

- (void)setModel:(Ocean_GroupMemberModel *)model {
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.m_headpic] placeholderImage:[UIImage imageNamed:@"tlz"]];
}

- (void)setPicName:(NSString *)picName {
    _picName = picName;
    _picImageView.image = [UIImage imageNamed:picName];
}

@end

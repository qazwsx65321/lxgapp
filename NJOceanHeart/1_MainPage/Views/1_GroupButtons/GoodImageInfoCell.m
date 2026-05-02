//
//  GoodImageInfoCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodImageInfoCell.h"

@interface GoodImageInfoCell()

@property (nonatomic, strong)UIImageView *detailImageView;

@end

@implementation GoodImageInfoCell


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
    _detailImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_detailImageView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;

}



@end

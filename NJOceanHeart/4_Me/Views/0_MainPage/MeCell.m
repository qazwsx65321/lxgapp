//
//  MeCell.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/27.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "MeCell.h"

@interface MeCell()

@property (nonatomic, strong)UIView *backView;

@end

@implementation MeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"MeCell";
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 绘制底图
        [self setupCellView];
        
    }
    return self;
}

- (void)setupCellView
{
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    [self sendSubviewToBack:_backView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backView.width = self.width;
    _backView.height = self.height - 2;
    _backView.x = 0;
    _backView.y = 0;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.textLabel.text = title;
}

- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    self.imageView.image = [UIImage imageNamed:icon];
}

@end

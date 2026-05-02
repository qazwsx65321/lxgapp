//
//  Ocean_TextViewCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_TextViewCell.h"

@interface Ocean_TextViewCell ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *sepline;

@end

@implementation Ocean_TextViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_TextViewCell";
    Ocean_TextViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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

- (void)setXD_title:(NSString *)XD_title {
    _XD_title = XD_title;
    
    _titleLabel.attributedText = [self getLabelAttributeText:XD_title withChangeText:@"*"];
}

- (void)setXD_chooseTitle:(NSString *)XD_chooseTitle {
    _XD_chooseTitle = XD_chooseTitle;
    
    _titleLabel.attributedText = [self getLabelAttributeText:XD_chooseTitle withChangeText:@" "];
}

- (void)setXD_placehodel:(NSString *)XD_placehodel {
    _XD_placehodel = XD_placehodel;
    
    _textView.placeholder = XD_placehodel;
}

-(void)setupControls{
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithRed:0.220 green:0.224 blue:0.224 alpha:1.000];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.titleLabel];
    
    self.textView = [[UITextField alloc] init];
    self.textView.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.textView];
    
    self.sepline = [[UIView alloc] init];
    self.sepline.backgroundColor = [UIColor colorWithRed:0.220 green:0.224 blue:0.224 alpha:1.000];
    [self.bgView addSubview:self.sepline];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, screen_Width, 40);
    CGSize titleS = [StringSizeModel sizeWithText:_titleLabel.text font:[UIFont systemFontOfSize:15]];
    self.titleLabel.frame = CGRectMake(10, (40 - titleS.height)/2.f, titleS.width, titleS.height);
    self.textView.frame = CGRectMake(self.titleLabel.right + 10, (40 - titleS.height)/2.f, screen_Width - 20 - self.titleLabel.right, titleS.height);
    self.sepline.frame = CGRectMake(self.titleLabel.right + 10, self.textView.bottom, screen_Width - 20 - self.titleLabel.right, 1);
    
}


- (NSMutableAttributedString *)getLabelAttributeText:(NSString *)text withChangeText:(NSString *)changetext {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",changetext,text]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:changetext].location, [[noteStr string] rangeOfString:changetext].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    return noteStr;
}

@end

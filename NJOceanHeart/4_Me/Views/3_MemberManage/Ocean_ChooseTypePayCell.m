//
//  Ocean_ChooseTypePayCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ChooseTypePayCell.h"

@interface Ocean_ChooseTypePayCell()
@property (nonatomic,weak) UIButton * lasbtn;
@property (nonatomic,weak) UIButton * p_zhifuBtn;
@property (nonatomic,weak) UIButton * p_weixinBtn;

@end

@implementation Ocean_ChooseTypePayCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ChooseTypePayCell";
    Ocean_ChooseTypePayCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ChooseTypePayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.p_zhifuBtn = [self creatButton:@"支付宝" andTag:100];
        self.lasbtn = self.p_zhifuBtn;
        [self.lasbtn setBackgroundColor:BackgroundColors(1)];
        self.p_weixinBtn = [self creatButton:@"微信" andTag:200];
        
    }
    return self;
}

-(UIButton *)creatButton:(NSString *)title andTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:0];
    button.tag = tag;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds =YES;
    [button setBackgroundColor:[UIColor lightGrayColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.width = 90;
    button.height = 43;
    [self.contentView addSubview:button];
    [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)choose:(UIButton *)sender{
    if (self.lasbtn !=sender) {
        [sender setBackgroundColor:BackgroundColors(1)];
        [self.lasbtn setBackgroundColor:[UIColor lightGrayColor]];
        self.lasbtn = sender;
        [self.delegate Ocean_ChooseTypePayCellChoosePay:sender.tag];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.p_zhifuBtn.x = 10;
    self.p_zhifuBtn.centerY  =self.height/2;
    
    self.p_weixinBtn.x = self.p_zhifuBtn.right +15;
    self.p_weixinBtn.centerY = self.height/2;
}

@end

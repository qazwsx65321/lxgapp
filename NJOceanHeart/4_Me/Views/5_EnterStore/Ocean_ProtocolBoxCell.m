//
//  Ocean_ProtocolBoxCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ProtocolBoxCell.h"

@interface Ocean_ProtocolBoxCell()

@property (nonatomic,weak) UIButton * p_boxBtn;
@property (nonatomic,weak) UIButton * p_protolBtn;

@end

@implementation Ocean_ProtocolBoxCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_ProtocolBoxCell";
    Ocean_ProtocolBoxCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ProtocolBoxCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        self.p_boxBtn = button;
        [button setImage:[UIImage imageNamed:@"check"] forState:0];
        [button setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
        button.size = CGSizeMake(70, 25);
        [button setTitle:@"选中即表示已阅读并同意" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.selected = YES;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.tag = 100;
        
        UIButton *protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.p_protolBtn = protocolButton;
        protocolButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [protocolButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [protocolButton setTitle:@"<<渠道对接协议>>" forState:0];
        [self.contentView addSubview:protocolButton];
        protocolButton.tag = 200;
        [protocolButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.p_protolBtn sizeToFit];
        [self.p_boxBtn sizeToFit];
        self.p_boxBtn.width +=10;

    }
    return self;
}

-(void)click:(UIButton *)sender{
    if (sender.tag ==100) {
        sender.selected = ! sender.selected;
    }
    [self.delegate ProtocolBoxCellClickButton:sender];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.p_boxBtn.x = (self.width - (self.p_protolBtn.width+self.p_boxBtn.width))/2;
    self.p_protolBtn.x = self.p_boxBtn.right +5;
    self.p_boxBtn.centerY = self.p_protolBtn.centerY = self.height/2;
    
    self.separatorInset = UIEdgeInsetsMake(0, screen_Width, 0, 0);
    
}

@end

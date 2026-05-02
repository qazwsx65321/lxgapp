//
//  Ocean_WithDetailResultCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/24.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_WithDetailResultCell.h"

@interface  Ocean_WithDetailResultCell()

@property (nonatomic,weak) UIButton * resonButton;

@end

@implementation Ocean_WithDetailResultCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_WithDetailResultCell";
    Ocean_WithDetailResultCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_WithDetailResultCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)setM_dic:(NSDictionary *)m_dic{

    _m_dic = m_dic;
    
    self.textLabel.text = m_dic[@"title"];
    self.detailTextLabel.text = m_dic[@"detail"];
    
    NSString *state = m_dic[@"state"];
    if ([@"3" isEqualToString:state]) {
        self.resonButton.hidden = NO;
    }else{
        self.resonButton.hidden = YES;
    }
    
    

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.textColor = [UIColor blueColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"查看原因" forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:BackgroundColors(1) forState:0];
        [self.contentView addSubview:button];
        [button sizeToFit];
        [button addTarget:self action:@selector(goreson) forControlEvents:UIControlEventTouchUpInside];
        self.resonButton = button;
        
        
    }
    return self;
}


-(void)goreson{

    [self.delegate Ocean_WithDetailResultCellClickResonButton];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.x = 15;
    self.textLabel.height = 15;
    self.textLabel.centerY = self.height/2;
    [self.textLabel sizeToFit];
    
    self.detailTextLabel.x= self.textLabel.right +10;
    [self.detailTextLabel sizeToFit];
    self.detailTextLabel.centerY = self.height/2;

    self.resonButton.right = self.width - 10;
    self.resonButton.centerY = self.height/2;
    
}

@end

//
//  InfoCell0.m
//  WorkerPort
//
//  Created by 陈志伟 on 17/1/11.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "XRNextPreCell.h"

@interface XRNextPreCell()


@end

@implementation XRNextPreCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"XRRealNameWaringTitleCell";
    XRNextPreCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[XRNextPreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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

-(void)setNextTitle:(NSString *)nextTitle{
    _nextTitle = nextTitle;
    [self.p_nextButton setTitle:nextTitle forState:0];
}

-(void)setupControls{
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"下一步" forState:0];
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside
     ];
    [nextButton setBackgroundColor:[UIColor colorWithHexString:Navi_Background_Color]];
    nextButton.layer.cornerRadius = 5;
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    nextButton.layer.masksToBounds = YES;
    self.p_nextButton = nextButton;
    [self.contentView addSubview:nextButton];
}

-(void)next{
    [self.delegate clickNextbutton];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
   // 375/47
    self.p_nextButton.x = 25;
    self.p_nextButton.width = self.width - 2*self.p_nextButton.x;
    self.p_nextButton.height = self.p_nextButton.width *47/375.0;
    self.p_nextButton.y = (self.height - self.p_nextButton.height)/2;
    [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, self.width)];
}

@end

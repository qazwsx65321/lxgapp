//
//  Ocean_RecommandBodyCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_RecommandBodyCell.h"
@interface Ocean_RecommandBodyCell()
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UIView *sepLine;

@end


@implementation Ocean_RecommandBodyCell
@synthesize backView,nameLabel,phoneLabel,timeLabel,moneyLabel,sepLine;
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_RecommandBodyCell";
    Ocean_RecommandBodyCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_RecommandBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor
                            ];
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
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:nameLabel];
    
    phoneLabel = [[UILabel alloc] init];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:phoneLabel];

    sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:sepLine];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView);
        make.height.mas_equalTo(backView.mas_height);
        make.top.mas_equalTo(backView);
        make.width.mas_equalTo(screen_Width/2);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right);
        make.height.mas_equalTo(backView.mas_height);
        make.top.mas_equalTo(backView);
        make.width.mas_equalTo(nameLabel.mas_width);
    }];
}
-(void)setTitles:(NSArray *)titles
{
    nameLabel.text = titles[0];
    phoneLabel.text = titles[1];
}
-(void)setModel:(Ocean_RecommandBody *)model
{
    nameLabel.text = model.m_name;
    phoneLabel.text = model.m_phone;
    nameLabel.textColor = [UIColor blackColor];
    phoneLabel.textColor = [UIColor blackColor];
}
@end

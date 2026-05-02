//
//  Ocean_RecommandHeadCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_RecommandHeadCell.h"
@interface Ocean_RecommandHeadCell()
@property (strong, nonatomic)UIView *backView;
@property (strong, nonatomic)UIView *back1View;
@property (strong, nonatomic)UIView *back2View;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UILabel *nameLabel;
@property (strong, nonatomic)UILabel *phoneLabel;
@property (strong, nonatomic)UILabel *numberLabel;
@property (strong, nonatomic)UILabel *moneyLabel;

@end

@implementation Ocean_RecommandHeadCell
@synthesize backView,back1View,back2View,titleLabel,nameLabel,phoneLabel,numberLabel,moneyLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_RecommandHeadCell";
    Ocean_RecommandHeadCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_RecommandHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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

-(void)setupControls{
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];
    
    back1View = [[UIView alloc] init];
    back1View.backgroundColor = BackgroundColors(1);
    [backView addSubview:back1View];
    
    back2View = [[UIView alloc] init];
    back2View.backgroundColor = [UIColor lightTextColor];
    [backView addSubview:back2View];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [back1View addSubview:titleLabel];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [back1View addSubview:nameLabel];
    

    numberLabel = [[UILabel alloc] init];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.textColor = [UIColor blackColor];
    [back2View addSubview:numberLabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [back1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView);
        make.right.mas_equalTo(backView);
        make.top.mas_equalTo(backView);
        make.height.mas_equalTo(150);
    }];
    [back2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView);
        make.right.mas_equalTo(backView);
        make.top.mas_equalTo(back1View.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(back1View);
        make.top.mas_equalTo(back1View).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(back1View);
        make.top.mas_equalTo(titleLabel).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(300, 50));
    }];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(back2View).with.offset(10);
        make.top.mas_equalTo(back2View).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];

    
}
- (void)setModel:(Ocean_RecommandModel *)model
{
    titleLabel.text = @"我的上级";
    nameLabel.text = model.m_name;
    numberLabel.text = [NSString stringWithFormat:@"我的下级(%@)",model.m_num];
}
@end

//
//  Ocean_MemberManageContentCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MemberManageContentCell.h"
@interface Ocean_MemberManageContentCell()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@end
@implementation Ocean_MemberManageContentCell
@synthesize typeLabel,dateLabel,numberLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"Ocean_MemberManageContentCell";
    Ocean_MemberManageContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Ocean_MemberManageContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

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
    typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"账户充值";
    typeLabel.textColor = [UIColor blackColor];
    typeLabel.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:typeLabel];
    
    dateLabel = [[UILabel alloc] init];
    dateLabel.text = @"2017-7-3";
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:dateLabel];
    
    numberLabel = [[UILabel alloc] init];
    numberLabel.textColor = BackgroundColors(1);
    numberLabel.font = [UIFont boldSystemFontOfSize:13];
    numberLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:numberLabel];
}

-(void)setModel:(Ocean_memberManageModel *)model{
    _model = model;
    typeLabel.text = model.m_content;
    dateLabel.text = model.m_buildtime;
    if ([@"2" isEqualToString:model.m_type]) {
        numberLabel.textColor = BackgroundColors(1);
        numberLabel.text = [NSString stringWithFormat:@"+%@元",model.m_money];
    }else{
        numberLabel.textColor = [UIColor lightGrayColor];
        numberLabel.text = [NSString stringWithFormat:@"-%@元",model.m_money];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    typeLabel.x = 10;
    typeLabel.y = typeLabel.x;
    typeLabel.width = 80;
    typeLabel.height = 15;
    
    dateLabel.x = typeLabel.x;
    dateLabel.y = typeLabel.bottom+5;
    dateLabel.width = self.width/2;
    dateLabel.height = 15;
    
    numberLabel.width = self.width/2;
    numberLabel.height = 15;
    numberLabel.x = self.width - numberLabel.width -5;
    numberLabel.centerY = (typeLabel.centerY + dateLabel.centerY)/2;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  Ocean_MemberManageHeadCell.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MemberManageHeadCell.h"
@interface Ocean_MemberManageHeadCell()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *setupButton;
@property (nonatomic, strong) UILabel *remainLabel;

@property (nonatomic, strong) UIButton *rechargeButton;
@property (nonatomic, strong) UIButton *withdrawButton;


@end
@implementation Ocean_MemberManageHeadCell
@synthesize backView,backButton,titleLabel,setupButton,remainLabel,levelLabel,cashLabel,rechargeButton,withdrawButton;
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"Ocean_MemberManageHeadCell";
    Ocean_MemberManageHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Ocean_MemberManageHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    backView  = [[UIView alloc] init];
    backView.backgroundColor = BackgroundColors(1);
    [self addSubview:backView];
    //20220406 add
    //backView.hidden = YES;
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    backButton.userInteractionEnabled = YES;
    //20220406 add
    backButton.hidden = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"会员管理";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    //20220406 add
    titleLabel.hidden = YES;
    
    
//    setupButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [setupButton setTitle:@"setup" forState:UIControlStateNormal];
//    [setupButton addTarget:self action:@selector(setup) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:setupButton];
    
    remainLabel = [[UILabel alloc] init];
    remainLabel.text = @"账户余额（元）";
    remainLabel.textColor = [UIColor whiteColor];
    remainLabel.textAlignment = NSTextAlignmentLeft;
    remainLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:remainLabel];
    
    levelLabel = [[UILabel alloc] init];
    levelLabel.text = @"会员等级";
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:levelLabel];
    
    cashLabel = [[UILabel alloc] init];
    cashLabel.text = @"688.90";
    cashLabel.textColor = [UIColor whiteColor];
    cashLabel.textAlignment = NSTextAlignmentCenter;
    cashLabel.font = [UIFont boldSystemFontOfSize:50];
    cashLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:cashLabel];
    
    rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    rechargeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [rechargeButton addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    
    //20220406,解决ios14的问题
    //[self addSubview:rechargeButton];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 14.0) {
        [self addSubview:rechargeButton];
    } else {
        [self.contentView addSubview:rechargeButton];
    }
    
    withdrawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [withdrawButton setTitle:@"提现" forState:UIControlStateNormal];
    withdrawButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [withdrawButton addTarget:self action:@selector(withdraw) forControlEvents:UIControlEventTouchUpInside];
    
    //20220406,解决ios14的问题
    //[self addSubview:withdrawButton];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 14.0) {
        [self addSubview:withdrawButton];
    } else {
        [self.contentView addSubview:withdrawButton];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    backView.width = self.width;
    backView.height = self.height + 20;
    backView.x = 0;
    backView.y = -20;
    
    titleLabel.width = 100;
    titleLabel.height= 20;
    titleLabel.x = backView.width / 2.f - titleLabel.width / 2.f;
    titleLabel.y = 15;
    
    backButton.width = 20;
    backButton.height = 30;
    backButton.x = 15;
    backButton.centerY = titleLabel.centerY - 2;
    
    setupButton.width = 20;
    setupButton.height = 15;
    setupButton.x = self.width - setupButton.width - backButton.x;
    setupButton.centerY = titleLabel.centerY;
    
    
    
    //20220406 modify
    //remainLabel.x = 10;
    //remainLabel.y = titleLabel.bottom + 20;
    remainLabel.x = 10 + 10;
    remainLabel.y = titleLabel.bottom - 20;
    
    remainLabel.width = self.width - remainLabel.x;
    remainLabel.height = 20;
    
    
    
    levelLabel.x = 0;
    levelLabel.y = remainLabel.bottom +25;
    levelLabel.width = self.width;
    levelLabel.height = 15;
    
    cashLabel.x = 0;
    cashLabel.y = levelLabel.bottom +10;
    cashLabel.width = self.width;
    cashLabel.height = 40;
    
    withdrawButton.width = 70;
    withdrawButton.height = 25;
    withdrawButton.x =  (self.width - 2*withdrawButton.width -15)/2;
    withdrawButton.y = cashLabel.bottom +40;
    withdrawButton.layer.cornerRadius = withdrawButton.height/2;
    withdrawButton.layer.borderColor = [UIColor whiteColor].CGColor;
    withdrawButton.layer.borderWidth = 1;
    
    rechargeButton.width = withdrawButton.width;
    rechargeButton.height = withdrawButton.height;
    rechargeButton.x = withdrawButton.right +15;
    rechargeButton.y = withdrawButton.y;
    rechargeButton.layer.cornerRadius = withdrawButton.height/2;
    rechargeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    rechargeButton.layer.borderWidth = 1;
}

- (void)back
{
    [self.delegate manageDidBack];
}

- (void)setup
{
    [self.delegate manageDidSetup];
}

- (void)recharge
{
    NSLog(@"充值处理了");
    [self.delegate manageDidRecharge];
}

- (void)withdraw
{
    [self.delegate manageDidWithdraw];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  Ocean_InfoDetailCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_InfoDetailCell.h"

@interface Ocean_InfoDetailCell ()

@property (nonatomic,strong) NSArray *infoArray;
@property (nonatomic,strong) NSArray *detaiArray;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *label0;
@property (nonatomic,strong) UILabel *label1;

@end

@implementation Ocean_InfoDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_InfoDetailCell";
    Ocean_InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_InfoDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.label0 = [[UILabel alloc] init];
    self.label0.text = @"出生日期";
    self.label0.textColor = [UIColor colorWithRed:0.592 green:0.588 blue:0.596 alpha:1.000];
    self.label0.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.label0];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"";
    self.label1.textColor = [UIColor colorWithRed:0.592 green:0.588 blue:0.596 alpha:1.000];
    self.label1.font = [UIFont systemFontOfSize:15];
    self.label1.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.label1];
    
    self.infoArray = [NSArray array];
    self.infoArray = @[@"姓名",@"性别",@"出生日期",@"证件类型",@"证件号码",@"婚姻状况",
                       @"教育程度",@"住宅状况",@"住宅地址",@"手机号",@"邮箱"];
}

- (void)setType:(NSInteger)type {
    _type = type;
    

    
    _detaiArray = @[[Ocean_UserInfo sharedOcean_UserInfo].m_name.length?[Ocean_UserInfo sharedOcean_UserInfo].m_name:@"",
                    [self judgeSex],
                    [self changeBirthday],
                    [self judgeCardType],
                    [Ocean_UserInfo sharedOcean_UserInfo].m_cardno.length?[Ocean_UserInfo sharedOcean_UserInfo].m_cardno:@"请在完善资料页面填写",
                    [self judgeMarriage],
                    [self judgeEducationLevel],
                    [self judgeHouse],
                    [Ocean_UserInfo sharedOcean_UserInfo].m_houseaddress.length?[Ocean_UserInfo sharedOcean_UserInfo].m_houseaddress:@"",
                    [Ocean_UserInfo sharedOcean_UserInfo].m_phone?[Ocean_UserInfo sharedOcean_UserInfo].m_phone:@"",
                    [Ocean_UserInfo sharedOcean_UserInfo].m_qq_email?[Ocean_UserInfo sharedOcean_UserInfo].m_qq_email:@""];
    
    
    if (type == 10) {
        _label0.text = _infoArray[type];
    }else {
        _label0.attributedText = [self getLabelAttributeText:_infoArray[type] withChangeText:@"*"];
    }
    
    _label1.text = _detaiArray[type];
    
    
}


//修改日期格式
- (NSString *)changeBirthday {
    
    if ([Ocean_UserInfo sharedOcean_UserInfo].m_birthday.length &&[[Ocean_UserInfo sharedOcean_UserInfo].m_birthday containsString:@"-"]) {
        return [Ocean_UserInfo sharedOcean_UserInfo].m_birthday;
    }
    
    NSString *birthday = [NSString stringWithFormat:@"%@122344",[Ocean_UserInfo sharedOcean_UserInfo].m_birthday];
    birthday = [NSString stringWithDateFormater:@"yyyy-MM-dd" andTimeString:birthday];
    return birthday.length?birthday:@"";
}

//判断性别
- (NSString *)judgeSex {
    NSString *sex = @"";
    
    if ([@"M" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_sex]) {
        sex = @"男";
    }else if ([@"F" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_sex]){
        sex = @"女";
    }
    else {
        sex = @"请选择";
    }
    
    return sex;
}

//判断证件类型
- (NSString *)judgeCardType {
    
    NSString *cardtype = @"";
    
    if ([@"1" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_cardtype]) {
        cardtype = @"中国身份证";
    }else if ([@"2" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_cardtype]) {
        cardtype = @"护照";
    }else if ([@"3" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_cardtype]) {
        cardtype = @"港澳通行证";
    }else if ([@"4" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_cardtype]) {
        cardtype = @"港澳通行证";
    }else {
        cardtype = @"请在完善资料页面填写";
    }
    
    return cardtype;
    
}

//判断婚姻状况
- (NSString *)judgeMarriage {
    NSString *marriage = @"";
    if ([@"S" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_marriage]) {
        marriage = @"未婚";
    }else if ([@"M" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_marriage]) {
        marriage = @"已婚";
    }else {
        marriage = @"其他";
    }
    return marriage;
}

//判断教育程度
- (NSString *)judgeEducationLevel {
    NSString *education = @"";
    if ([@"M" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_edulevel]) {
        education = @"硕士或以上";
    }else if ([@"U" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_edulevel]) {
        education = @"本科";
    }else if ([@"P" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_edulevel]) {
        education = @"大专";
    }else if ([@"H" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_edulevel]) {
        education = @"高中/中专";
    }else if([@"S" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_edulevel]) {
        education = @"初中或以下";
    }else{
        education = @"请选择";
    }
    return education;
}

//判断住宅状态
- (NSString *)judgeHouse {
    
    NSString *house = @"";
    if ([@"S" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_house]) {
        house = @"自有无按揭";
    }else if ([@"M" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_house]) {
        house = @"按揭住宅";
    }else if ([@"Q" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_house]) {
        house = @"单位分配";
    }else if ([@"R" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_house]) {
        house = @"租房";
    }else if ([@"L" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_house]) {
        house = @"与父母同住";
    }else if([@"O" isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_house]){
        house = @"其他";
    }else{
        house = @"请选择";
    }
    return house;
    
}

- (NSMutableAttributedString *)getLabelAttributeText:(NSString *)text withChangeText:(NSString *)changetext {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",changetext,text]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:changetext].location, [[noteStr string] rangeOfString:changetext].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    return noteStr;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat SH = 100.f*screen_Width/750.f;
    
    CGFloat bgX = 0;
    CGFloat bgY = 0;
    CGFloat bgW = screen_Width;
    CGFloat bgH = SH;
    self.bgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGSize titleS = [StringSizeModel sizeWithText:@"证件有效期至" font:[UIFont systemFontOfSize:15]];
    CGFloat laX = 25.f/750.f*screen_Width;
    CGFloat laY = 0;
    CGFloat laW = titleS.width;
    CGFloat laH = SH;
    self.label0.frame = CGRectMake(laX, laY, laW, laH);
    
    self.label1.frame = CGRectMake(self.label0.right, laY, screen_Width - self.label0.right - 10, laH);
}

@end

//
//  RegistCell.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/14.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "RegistCell.h"

@interface RegistCell ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UIButton *yanBtn;
@property (nonatomic,strong) UIImageView *downImage;

@property (nonatomic,strong) UILabel *agreeLab;
@property (nonatomic,strong) UIButton *termsBtn;


@end

@implementation RegistCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"RegistCell";
    RegistCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[RegistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
    self.label = [[UILabel alloc] init];
    self.label.text = @"手机号:";
    self.label.textColor = [UIColor colorWithWhite:0.071 alpha:1.000];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label];
    
    self.textFiled = [[UITextField alloc] init];
    self.textFiled.placeholder = @"+86";
    self.textFiled.textColor = [UIColor colorWithWhite:0.792 alpha:1.000];
    self.textFiled.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.textFiled];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
    [self.contentView addSubview:self.line];
    
    self.yanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yanBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.yanBtn setTitleColor:[UIColor colorWithRed:0.204 green:0.522 blue:0.933 alpha:1.000] forState:UIControlStateNormal];
    self.yanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.yanBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.yanBtn];
    
    self.downImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
    [self.contentView addSubview:self.downImage];
    
    //20220418,增加隐私协议和服务条款的处理*************************************************begin
    self.agreeLab = [[UILabel alloc] init];
    self.agreeLab.font = [UIFont systemFontOfSize:13];
    self.agreeLab.text = @"《注册即表示您同意》";
    self.agreeLab.textColor = HEXCOLOR(0x9d9eab);
    [self.contentView addSubview:self.agreeLab];
    
        
    self.termsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.termsBtn setTitle:@"隐私条例和服务条款" forState:UIControlStateNormal];
    [self.termsBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:1.0 alpha:1] forState:UIControlStateNormal];
    self.termsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.termsBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.termsBtn];

    //20220418,增加隐私协议和服务条款的处理*************************************************end
}


-(void)sendAction:(UIButton *)button;
{
    NSLog(@"获取验证码");
    [self.delegate clickButtonPostCode:button];
}


- (void)setIndex:(NSInteger)index {
    _index = index;
    
    switch (index) {
        case 0:
        {
            _label.text = @"手机号:";
            _textFiled.placeholder = @"+86";
            _yanBtn.hidden = YES;
            _downImage.hidden = YES;
            
            //20220418 add
            _agreeLab.hidden = YES;
            _termsBtn.hidden = YES;
            
        }
            break;
        case 1:
        {
            _label.text = @"姓名:";
            _textFiled.placeholder = @"请输入姓名";
            _yanBtn.hidden = YES;
            _downImage.hidden = YES;
            
            //20220418 add
            _agreeLab.hidden = YES;
            _termsBtn.hidden = YES;
        }
            break;
        case 2:
        {
            _label.text = @"验证码:";
            _textFiled.placeholder = @"请输入验证码";
            _yanBtn.hidden = NO;
            _downImage.hidden = YES;
            
            //20220418 add
            _agreeLab.hidden = NO;
            _termsBtn.hidden = NO;
        }
            break;
        case 3:
        {
            _label.text = @"设置密码:";
            _textFiled.placeholder = @"请设置密码";
            _yanBtn.hidden = YES;
            _downImage.hidden = YES;
            
            //20220418 add
            _agreeLab.hidden = YES;
            _termsBtn.hidden = YES;
        }
            break;
        case 4:
        {
            _label.text = @"确认密码:";
            _textFiled.placeholder = @"请确认密码";
            _yanBtn.hidden = YES;
            _downImage.hidden = YES;
            
            //20220418 add
            _agreeLab.hidden = YES;
            _termsBtn.hidden = YES;
        }
            break;
        case 6:
        {
            _label.text = @"物流公司:";
            _textFiled.placeholder = @"请选择物流公司";
            _yanBtn.hidden = YES;
            _downImage.hidden = NO;
            
            //20220418 add
            _agreeLab.hidden = YES;
            _termsBtn.hidden = YES;
        }
            break;
        case 7:
        {
            _label.text = @"邀请码:";
            _textFiled.placeholder = @"请输入邀请码";
            _yanBtn.hidden = YES;
            _downImage.hidden = YES;
            
            //20220418 add
            _agreeLab.hidden = YES;
            _termsBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
    
    
}

- (void)setIsShehui:(BOOL)isShehui {
    
    _isShehui = isShehui;
    
    if (isShehui) {
        switch (self.index) {
            case 0:
            {
                _label.text = @"手机号:";
                _textFiled.placeholder = @"+86";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 1:
            {
                _label.text = @"姓名:";
                _textFiled.placeholder = @"请输入姓名";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 2:
            {
                _label.text = @"验证码:";
                _textFiled.placeholder = @"请输入验证码";
                _yanBtn.hidden = NO;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 3:
            {
                _label.text = @"设置密码:";
                _textFiled.placeholder = @"请设置密码";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 4:
            {
                _label.text = @"确认密码:";
                _textFiled.placeholder = @"请确认密码";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 6:
            {
                _label.text = @"车型:";
                _textFiled.placeholder = @"请选择车型";
                _yanBtn.hidden = YES;
                _downImage.hidden = NO;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 7:
            {
                _label.text = @"车牌号:";
                _textFiled.placeholder = @"请填写车牌号";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 8:
            {
                _label.text = @"吨位:";
                _textFiled.placeholder = @"请填写吨位";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 9:
            {
                _label.text = @"物流公司:";
                _textFiled.placeholder = @"请选择物流公司";
                _yanBtn.hidden = YES;
                _downImage.hidden = NO;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
                
            default:
                break;
        }
    }else {
        switch (self.index) {
            case 0:
            {
                _label.text = @"手机号:";
                _textFiled.placeholder = @"+86";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 1:
            {
                _label.text = @"姓名:";
                _textFiled.placeholder = @"请输入姓名";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 2:
            {
                _label.text = @"验证码:";
                _textFiled.placeholder = @"请输入验证码";
                _yanBtn.hidden = NO;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 3:
            {
                _label.text = @"设置密码:";
                _textFiled.placeholder = @"请设置密码";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 4:
            {
                _label.text = @"确认密码:";
                _textFiled.placeholder = @"请确认密码";
                _yanBtn.hidden = YES;
                _downImage.hidden = YES;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
            case 6:
            {
                _label.text = @"物流公司:";
                _textFiled.placeholder = @"请选择物流公司";
                _yanBtn.hidden = YES;
                _downImage.hidden = NO;
                
                //20220418 add
                _agreeLab.hidden = YES;
                _termsBtn.hidden = YES;
            }
                break;
                
            default:
                break;
        }
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleS = [StringSizeModel sizeWithText:_label.text font:[UIFont systemFontOfSize:15]];
    
    CGFloat PLX = 45.f/750.f*screen_Width;
    CGFloat PLY = 0;
    CGFloat PLW = titleS.width;
    CGFloat PLH = 118.f*screen_Width/750.f;
    self.label.frame = CGRectMake(PLX, PLY, PLW, PLH);
    
    self.line.frame = CGRectMake(PLX, self.label.bottom, 660.f/750.f*screen_Width, 1);
    
    CGFloat psLX = self.label.right + 10.f/750.f*screen_Width;
    CGFloat psLY = PLY;
    CGFloat psLW = 650.f/750.f*screen_Width - psLX;
    CGFloat psLH = PLH;
    self.textFiled.frame = CGRectMake(psLX, psLY, psLW, psLH);
    
    CGSize textS = [StringSizeModel sizeWithText:@"获取验证码" font:[UIFont systemFontOfSize:15]];
    
    CGFloat btnX = 705.f/750.f*screen_Width - textS.width;
    CGFloat btnY = psLY;
    CGFloat btnW = textS.width;
    CGFloat btnH = psLH;
    self.yanBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    
    CGFloat imaW = 30.f/750.f*screen_Width;
    CGFloat imaH = 18.f/750.f*screen_Width;
    CGFloat imaX = 695.f/750.f*screen_Width - imaW;
    CGFloat imaY = (PLH - imaH)/2.f;
    self.downImage.frame = CGRectMake(imaX, imaY, imaW, imaH);
    
    CGFloat PLH1 = 118.f*screen_Width/750.f;
    CGFloat imaH1 = 18.f/750.f*screen_Width;
    //CGFloat imaY1 = (PLH1 - imaH1)/2.f + 50;
    CGFloat imaY1 = -30;
    
    CGSize sizeT = [StringSizeModel sizeWithText:@"《注册即表示您同意》" font:[UIFont systemFontOfSize:13]];
    CGSize sizeA = [self.agreeLab.text sizeWithAttributes:@{NSFontAttributeName:self.agreeLab.font}];
    
    self.agreeLab.frame = CGRectMake((screen_Width-sizeA.width-sizeT.width-15)/2+10, imaY1, sizeA.width, sizeA.height);
    self.termsBtn.frame = CGRectMake(CGRectGetMaxX(self.agreeLab.frame), imaY1, sizeT.width, sizeT.height);
    
}

-(void)dealloc{

    NSLog(@"销毁了");
}

//20220418
- (void)didAgree {
    ;
}
- (void)checkTerms:(UIButton *)button {
    NSLog(@"打开用户注册协议-1");
    [self.delegate OpenUserAgreeMent];
}

@end

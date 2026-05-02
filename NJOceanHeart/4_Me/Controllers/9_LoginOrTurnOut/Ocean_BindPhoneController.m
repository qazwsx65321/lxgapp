//
//  Ocean_BindPhoneController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_BindPhoneController.h"
#import "ForgetPassWordController.h"
@interface Ocean_BindPhoneController ()

@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *phoneTF;
@property (nonatomic,strong) UILabel *pswLabel;
@property (nonatomic,strong) UITextField *pswTF;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,strong) UIButton *forgetBtn;
@property (nonatomic,strong) UIButton *registBtn;
@property (nonatomic,strong) UIView *line2;

@end


@implementation Ocean_BindPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定手机";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupControls];
    
}

- (void)setupControls {
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.text = @"账号:";
    self.phoneLabel.textColor = [UIColor colorWithWhite:0.071 alpha:1.000];
    self.phoneLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.phoneLabel];
    
    self.pswLabel = [[UILabel alloc] init];
    self.pswLabel.text = @"密码:";
    self.pswLabel.textColor = [UIColor colorWithWhite:0.071 alpha:1.000];
    self.pswLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.pswLabel];
    
    self.phoneTF = [[UITextField alloc] init];
    self.phoneTF.placeholder = @"+86";
    self.phoneTF.text = [Ocean_UserInfo sharedOcean_UserInfo].m_phone;
    
    self.phoneTF.textColor = [UIColor colorWithWhite:0.792 alpha:1.000];
    self.phoneTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.phoneTF];
    
    self.pswTF = [[UITextField alloc] init];
    self.pswTF.placeholder = @"请输入密码";
    self.pswTF.textColor = [UIColor colorWithWhite:0.792 alpha:1.000];
    self.pswTF.font = [UIFont systemFontOfSize:15];
    self.pswTF.secureTextEntry = YES;
    [self.view addSubview:self.pswTF];
    
    self.line0 = [[UIView alloc] init];
    self.line0.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
    [self.view addSubview:self.line0];
    
    self.line1 = [[UIView alloc] init];
    self.line1.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
    [self.view addSubview:self.line1];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.loginBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.loginBtn.layer.cornerRadius = 5.f;
    self.loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.loginBtn];
    
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:[UIColor colorWithWhite:0.702 alpha:1.000] forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.forgetBtn];
    
    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor colorWithRed:0.141 green:0.506 blue:0.929 alpha:1.000] forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.registBtn];
    
    self.line2 = [[UIView alloc] init];
    self.line2.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
    [self.view addSubview:self.line2];
    
    [self.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.registBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLayout];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}





-(void)cancel{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)loginClick {
    //绑定
    MJWeakSelf;
    
    NSString *name = self.phoneTF.text;
    NSString *pass = self.pswTF.text;
    if (name.length ==0 || ![name checkPhoneNo]) {
        [MBProgressHUD showErrorMessage:@"请输入正确的手机号码!"];
        return;
    }
    if (pass.length ==0) {
        [MBProgressHUD showErrorMessage:@"请输入密码!"];
    }
    NSString *sign = @"";
    
    if (self.user.platformType ==997) {
        //微信
        sign = @"0";
    }else{
        sign = @"1";
    }
    NSString * m_threeid  = self.user.uid;
    NSString * m_nickname  = self.user.nickname;
    NSString * m_headpic  = self.user.icon;


    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         name,@"m_phone",
                         sign,@"m_sign",
                         m_threeid,@"m_threeid",
                         m_nickname,@"m_nickname",
                         m_headpic,@"m_headpic",
                         pass,@"m_pwd",nil];
    
    
    [MBProgressHUD showActivityMessageInWindow:@""];
    
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"Lock_qq_weixin" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];

        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [weakSelf UserReg_qq_weixin:sign andThreeid:m_threeid];
                
            }else if ([respInfo[@"ERRORCODE"] isEqualToString:@"0001"]){
                
                UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"绑定的手机号暂未注册本平台" preferredStyle:UIAlertControllerStyleAlert];
                [alter addAction:[UIAlertAction actionWithTitle:@"去注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //手机号未注册、绑定失败
                    ForgetPassWordController *forgetVC = [[ForgetPassWordController alloc] init];
                    forgetVC.m_flag = @"1";
                    forgetVC.title = @"注册";
                    forgetVC.m_phoneNum =name;
                    [weakSelf.navigationController pushViewController:forgetVC animated:YES];
                }]];
                
                [alter addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
                
                [weakSelf presentViewController:alter animated:NO completion:nil];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];

}


-(void)UserReg_qq_weixin:(NSString *)m_sign andThreeid:(NSString *)threedid{
    [MBProgressHUD showActivityMessageInWindow:@""];

    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_sign":m_sign,
                                                   @"m_threeid":threedid
    } methodName:@"UserReg_qq_weixin" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"QSOtherBindPhoneLogin" object:respInfo];
                    
                });
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];

    
}


- (void)forgetClick {
    
    ForgetPassWordController *forgetVC = [[ForgetPassWordController alloc] init];
    forgetVC.m_flag = @"2";
    forgetVC.title = @"忘记密码";
    [self.navigationController pushViewController:forgetVC animated:YES];
    
    
}

- (void)registClick {
    
    ForgetPassWordController *forgetVC = [[ForgetPassWordController alloc] init];
    forgetVC.m_flag = @"1";
    forgetVC.title = @"注册";
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}

- (void)setLayout {
    
    CGFloat PLX = 45.f/750.f*screen_Width;
    CGFloat PLY = 200.f*screen_Width/750.f +30;
    CGFloat PLW = 135.f/750.f*screen_Width;
    CGFloat PLH = 80.f*screen_Width/750.f;
    self.phoneLabel.frame = CGRectMake(PLX, PLY, PLW, PLH);
    
    self.line0.frame = CGRectMake(PLX, self.phoneLabel.bottom, 660.f/750.f*screen_Width, 1);
    
    CGFloat psLX = self.phoneLabel.right;
    CGFloat psLY = PLY;
    CGFloat psLW = 505.f/750.f*screen_Width;
    CGFloat psLH = PLH;
    self.phoneTF.frame = CGRectMake(psLX, psLY, psLW, psLH);
    
    self.pswLabel.frame = CGRectMake(PLX, self.line0.bottom + 40.f*screen_Width/750.f, PLW, PLH);
    
    self.pswTF.frame = CGRectMake(psLX, self.line0.bottom + 40.f*screen_Width/750.f, psLW, psLH);
    
    self.line1.frame = CGRectMake(PLX, self.pswLabel.bottom, 660.f/750.f*screen_Width, 1);
    
    CGFloat btnX = PLX;
    CGFloat btnY = self.line1.bottom + 160.f/750.f*screen_Width;
    CGFloat btnW = 660.f/750.f*screen_Width;
    CGFloat btnH = 100.f*screen_Width/750.f;
    self.loginBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    CGFloat forX = 190.f/750.f*screen_Width;
    CGFloat forY = 1080.f*screen_Width/750.f;
    CGFloat forW = 150.f/750.f*screen_Width;
    CGFloat forH = 50.f*screen_Width/750.f;
    self.forgetBtn.frame = CGRectMake(forX, forY, forW, forH);
    
    self.line2.frame = CGRectMake(self.forgetBtn.right + 15.f/750.f*screen_Width, 1090.f*screen_Width/750.f, 1, 30.f*screen_Width/750.f);
    
    self.registBtn.frame = CGRectMake(self.line2.right + 15.f/750.f*screen_Width, forY, forW, forH);
    
    self.forgetBtn.bottom = self.view.height -30;
    self.registBtn.centerY = self.forgetBtn.centerY;
    self.line2.centerY = self.forgetBtn.centerY;
    
}









@end

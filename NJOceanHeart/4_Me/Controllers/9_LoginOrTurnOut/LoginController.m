//
//  LoginController.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/12.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "LoginController.h"

#import "RegisterController.h"

#import "ForgetPassWordController.h"

#import "Ocean_BindPhoneController.h"

#import <JPUSHService.h>

#import "Ocean_UserInfo.h"

#import "Ocean_XDTableObject.h"

#import "Ocean_SaveTableInfo.h"

typedef enum{
    QQLoginType,
    WeixinLoginType,
}LoginType;
#import "Ocean_XDConnectRongCloud.h"
#import "XRThreeLoginTool.h"

@interface LoginController ()

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

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupControls];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BindotherLogin:) name:@"QSOtherBindPhoneLogin" object:nil];
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
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
      
    
    UIButton *QQbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQbtn setBackgroundImage:[UIImage imageNamed:@"qq登录"] forState:UIControlStateNormal];
    QQbtn.y =self.loginBtn.bottom + screen_Height *104/781;
    QQbtn.width = QQbtn.height = 60;
    QQbtn.x = CGRectGetMaxX(self.view.frame)-self.view.width/2-30-QQbtn.width;
    QQbtn.tag = QQLoginType;
    [QQbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQbtn];
    
    UILabel *qqLb = [[UILabel alloc]init];
    qqLb.font = [UIFont systemFontOfSize:14];
    qqLb.text = @"qq登录";
    [qqLb sizeToFit];
    qqLb.y = QQbtn.bottom +10;
    qqLb.centerX  =QQbtn.centerX;
    [self.view addSubview:qqLb];
    
    UIButton *Weibtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Weibtn setBackgroundImage:[UIImage imageNamed:@"微信登录"] forState:UIControlStateNormal];
    Weibtn.tag = WeixinLoginType;
    [Weibtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
    Weibtn.y = QQbtn.y;
    Weibtn.width = Weibtn.height = 60;
    Weibtn.x = CGRectGetMaxX(self.view.frame)-self.view.width/2+30;
    [self.view addSubview:Weibtn];
    
    UILabel *WeiLb = [[UILabel alloc]init];
    WeiLb.font = [UIFont systemFontOfSize:14];
    WeiLb.text = @"微信登录";
    [WeiLb sizeToFit];
    WeiLb.y = Weibtn.bottom +10;
    WeiLb.centerX  =Weibtn.centerX;
    [self.view addSubview:WeiLb];

    
    UIView *linV =[[UIView alloc]init];
    linV.height = Weibtn.height/2;
    linV.width = 1;
    linV.backgroundColor = [UIColor lightGrayColor];
    linV.centerX = self.view.width/2;
    linV.centerY = Weibtn.centerY;
    [self.view addSubview:linV];
    
    //20220406，隐藏qq登录、微信登录
    QQbtn.hidden = YES;
    qqLb.hidden = YES;
    Weibtn.hidden = YES;
    WeiLb.hidden = YES;
    linV.hidden = YES;
    
    
    if (iphone4) {
        
        QQbtn.y =self.loginBtn.bottom +10;
        Weibtn.y = QQbtn.y;
        linV.centerY = Weibtn.centerY;
        qqLb.y = QQbtn.bottom +10;
        WeiLb.y = Weibtn.bottom +10;
    }
}

-(void)cancel{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginClick {
    NSString *name = self.phoneTF.text;
    NSString *pass = self.pswTF.text;
    if (name.length ==0 || ![name checkPhoneNo]) {
        [MBProgressHUD showErrorMessage:@"请输入正确的手机号码!"];
        return;
    }
    if (pass.length ==0) {
        [MBProgressHUD showErrorMessage:@"请输入密码!"];
    }
    
    [MBProgressHUD showActivityMessageInWindow:@""];
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:@{
                                                   @"m_name":name,
                                                   @"m_password":pass
                                                   } methodName:@"USER-LOGIN" completion:^(id respInfo, NSError *error) {
                                                       [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                Ocean_UserInfo *userInfo = [Ocean_UserInfo mj_objectWithKeyValues:respInfo];
                userInfo.isLogin = YES;
                [Ocean_UserInfo sharedOcean_UserInfo].m_registPhone = weakSelf.phoneTF.text;
                [userInfo setInfoData];
                [JPUSHService setAlias:respInfo[@"m_uid"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"----->%ld",iResCode);

                } seq:0];

                [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud]
                 connectToRongCloudWithUserName:[Ocean_UserInfo sharedOcean_UserInfo].m_nickname
                 withTouXiang:[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang
                 withToken:[Ocean_UserInfo sharedOcean_UserInfo].m_token];

                //登录成功之后调用数据库
                [Ocean_XDTableObject CreateTableObj];
                [Ocean_SaveTableInfo saveFriendsInfo];
                [Ocean_SaveTableInfo saveGroup];
                [weakSelf MYCARDS];
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            }else{
                
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
}

-(void)MYCARDS{
    
    if ([Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[Ocean_UserInfo sharedOcean_UserInfo].m_uid,@"m_uid",[Ocean_UserInfo sharedOcean_UserInfo].m_session,@"m_session",nil];
        
        [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"MYCARDS" completion:^(id respInfo, NSError *error) {
            if (!error) {
                if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                    
                    NSString *checkFlag = respInfo[@"m_checkflag"];
                    NSString *m_price = respInfo[@"m_price"];
                    NSString *name = respInfo[@"m_name"];
                    NSString *m_zpic = respInfo[@"m_zpic"];
                    NSString *m_cid = respInfo[@"m_cid"];
                    if (checkFlag) {
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:checkFlag forKey:@"m_checkflag"];
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_price forKey:@"m_cardPrice"];
                        
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_price forKey:@"m_cardPrice"];
                        
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:name forKey:@"m_cardname"];
                        
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_cid forKey:@"m_cardid"];
                        
                        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_zpic forKey:@"m_zcardpic"];
                        

                        [[NSNotificationCenter defaultCenter]postNotificationName:@"QSAlterViewFromCurrentVC" object:nil];
                        
                    }
                        
                }else if ([respInfo[@"ERRORCODE"] isEqualToString:@"0003"]){
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"QSAlterViewFromCurrentVC" object:nil];
                }else{
                }
            }else{
            }
        }];
        
        
    }
    
    
    
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
    
    //20220406 modify,适配iphone 11 max等大屏幕手机
    //CGFloat forY = 1080.f*screen_Width/750.f;
    CGFloat forY = btnY + 70.f;
    
    CGFloat forW = 150.f/750.f*screen_Width;
    CGFloat forH = 50.f*screen_Width/750.f;
    self.forgetBtn.frame = CGRectMake(forX, forY, forW, forH);
    
    self.line2.frame = CGRectMake(self.forgetBtn.right + 15.f/750.f*screen_Width, 1090.f*screen_Width/750.f, 1, 30.f*screen_Width/750.f);
    
    self.registBtn.frame = CGRectMake(self.line2.right + 15.f/750.f*screen_Width, forY, forW, forH);
    
    //20220406 remark,适配iphone 11 max等大屏幕手机
    //self.forgetBtn.bottom = self.view.height -30;
    
    self.registBtn.centerY = self.forgetBtn.centerY;
    self.line2.centerY = self.forgetBtn.centerY;
    
}

-(void)otherLogin:(UIButton *)sender{
    MJWeakSelf;
    SSDKPlatformType platformType;
    switch (sender.tag) {
        case WeixinLoginType:
        {
           platformType = SSDKPlatformTypeWechat;
        }
            break;
            
        default:
        {
            platformType = SSDKPlatformTypeQQ;
        }
            break;
    }
    
    [XRThreeLoginTool LoginFrom:platformType andCompletion:^(NSError *error, NSDictionary *respinfo,SSDKUser *user) {
        
        if (error) {
            
            [MBProgressHUD showInfoMessage:@"异常服务!"];
            
            return;
        }
        
        if ([respinfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
            
            [weakSelf disposeData:error andRespInfo:respinfo];
            
        }else if([respinfo[@"ERRORCODE"] isEqualToString:@"0001"]){
            //绑定手机号码
            [MBProgressHUD showTipMessageInWindow:respinfo[@"ERRORDESTRIPTION"]];
            Ocean_BindPhoneController *bindVC = [[Ocean_BindPhoneController alloc]init];
            bindVC.user = user;
            [self.navigationController pushViewController:bindVC animated:YES];
            
        }else{
            [MBProgressHUD showTipMessageInView:respinfo[@"ERRORDESTRIPTION"]];
        }
    }];
}

-(void)BindotherLogin:(NSNotification *)not{
    NSDictionary *respInfo = not.object;
    [self disposeData:nil andRespInfo:respInfo];
}

-(void)disposeData:(NSError *)error andRespInfo:(NSDictionary *)respInfo{
    if (!error) {
        if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
            Ocean_UserInfo *userInfo = [Ocean_UserInfo mj_objectWithKeyValues:respInfo];
            userInfo.isLogin = YES;
            [userInfo setInfoData];
            
            [Ocean_XDTableObject CreateTableObj];
            [Ocean_SaveTableInfo saveFriendsInfo];
            [Ocean_SaveTableInfo saveGroup];
            
            [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud]
             connectToRongCloudWithUserName:[Ocean_UserInfo sharedOcean_UserInfo].m_nickname
             withTouXiang:[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang
             withToken:[Ocean_UserInfo sharedOcean_UserInfo].m_token];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            
            [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
        }
    }else{
        [MBProgressHUD showErrorMessage:@"网路问题..."];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

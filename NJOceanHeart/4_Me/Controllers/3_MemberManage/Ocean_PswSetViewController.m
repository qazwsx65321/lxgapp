//
//  Ocean_PswSetViewController.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_PswSetViewController.h"
#import "TPPasswordTextView.h"
@interface Ocean_PswSetViewController ()
@property (nonatomic, strong) TPPasswordTextView *pswView;
@property (nonatomic, strong) UILabel *indicatorLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) NSString *psw;


@end

@implementation Ocean_PswSetViewController
@synthesize pswView,indicatorLabel,confirmButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.type isEqualToString:@"set"]) {
        self.title = @"设置支付密码";
    }
    if ([self.type isEqualToString:@"modify"]) {
        self.title = @"修改支付密码";
    }
    [self setView];
}
- (void)setView{
    indicatorLabel = [[UILabel alloc] init];
    indicatorLabel.text = @"设置6位支付密码:";
    indicatorLabel.textColor = [UIColor lightGrayColor];
    indicatorLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:indicatorLabel];
    
    pswView = [[TPPasswordTextView alloc] init];
    pswView.elementCount = 6;
    pswView.passwordDidChangeBlock = ^(NSString *password) {
        if (password.length == 6) {
            confirmButton.backgroundColor = BackgroundColors(1);
            _psw = password;
        }
        else
        {
            confirmButton.backgroundColor = [UIColor lightGrayColor];
            _psw = password;
        }
    };
    pswView.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:pswView];
    
    confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(SetPayPwd) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:confirmButton];
    
    [self setLayout];
}
- (void)setLayout{
    indicatorLabel.x = 10;
    indicatorLabel.y = 2*indicatorLabel.x;
    indicatorLabel.width = 150;
    indicatorLabel.height = 20;
    
    pswView.width = 250;
    pswView.height = 44;
    pswView.x = (self.view.width-pswView.width)/2;
    pswView.y = indicatorLabel.bottom + 50;
    
    confirmButton.width = 300;
    confirmButton.height = 30;
    confirmButton.x = (self.view.width-confirmButton.width)/2;
    confirmButton.y = pswView.bottom +80;
    confirmButton.layer.cornerRadius = 5;
}


- (void)SetPayPwd {
    if (_psw.length == 6) {
        if ([self.type isEqualToString:@"set"]) {
            NSDictionary *dic = @{
                                  @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                                  @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                                  @"m_password":_psw
                                  };
            
            [HttpRequestTools requestUserInfoWithData:dic methodName:@"SETPAYPWD" completion:^(id respInfo, NSError *error) {
                if (!error) {
                    
                    if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                        [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                        [self.navigationController popViewControllerAnimated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetPasswordSuccess" object:nil];
                    }else {
                        [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                    }
                    
                }else {
                    [MBProgressHUD showErrorMessage:@"服务器异常!"];
                }
                
            }];
        }
        else if ([self.type isEqualToString:@"modify"])
        {
            NSDictionary *dic = @{
                                  @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                                  @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                                  @"m_oldpassword":@"",
                                  @"m_newpassword":_psw
                                  };
            
            [HttpRequestTools requestUserInfoWithData:dic methodName:@"UPDATEPAYPWD" completion:^(id respInfo, NSError *error) {
                if (!error) {
                    
                    if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                        [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else {
                        [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                    }
                    
                }else {
                    [MBProgressHUD showErrorMessage:@"服务器异常!"];
                }
                
            }];
        }
    }
    else
    {
        [MBProgressHUD showInfoMessage:@"请输入六位密码"];
    }
    
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

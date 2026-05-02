//
//  Ocean_PswSetAndModifyViewController.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ChangePhoneController.h"
//#import "Ocean_PswSetViewController.h"
@interface Ocean_ChangePhoneController ()<UITextFieldDelegate>

{
    NSString *randompassword;
    NSInteger _count;
    
}

@property (nonatomic, strong) UILabel *indicatorLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *pinLabel;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *pinField;
@property (nonatomic, strong) UIView *splitView;
@property (nonatomic, strong) UIButton *getPinButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic,strong) NSString * p_sendPhone;
@property (nonatomic,strong) NSTimer * p_timer;
@end


@implementation Ocean_ChangePhoneController
@synthesize indicatorLabel,phoneLabel,pinLabel,phoneField,pinField,getPinButton,nextButton,splitView;
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([@"0"isEqualToString:self.m_type]) {
        self.title = @"更换手机号";
    }else if ([@"1"isEqualToString:self.m_type]){
        self.title = @"更换手机号";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupView
{
    indicatorLabel = [[UILabel alloc] init];
    indicatorLabel.text = @"验证手机号:";
    indicatorLabel.textColor = [UIColor lightGrayColor];
    indicatorLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:indicatorLabel];
    
    phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号:";
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:phoneLabel];
    
    pinLabel = [[UILabel alloc] init];
    pinLabel.text = @"验证码:";
    pinLabel.textColor = [UIColor blackColor];
    pinLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:pinLabel];
    
    phoneField = [[UITextField alloc] init];
    phoneField.placeholder = @"请输入手机号";
    phoneField.textColor = [UIColor lightGrayColor];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:phoneField];
    
    
    pinField = [[UITextField alloc] init];
    pinField.placeholder = @"请输入验证码";
    pinField.textColor = [UIColor lightGrayColor];
    pinField.keyboardType = UIKeyboardTypeNumberPad;
    pinField.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:pinField];
    
    splitView = [[UIView alloc] init];
    splitView.backgroundColor = [UIColor lightlightGrayColor];
    [self.view addSubview:splitView];
    
    getPinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [getPinButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getPinButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [getPinButton addTarget:self action:@selector(sendCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [getPinButton setTitleColor:BackgroundColors(1) forState:UIControlStateNormal];
    [self.view addSubview:getPinButton];
    
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
  
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setBackgroundColor:BackgroundColors(1)];
    [self.view addSubview:nextButton];
    
    if ([@"0"isEqualToString:self.m_type]) {
        [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        indicatorLabel.text = @"验证手机号:";
        phoneField.text = [Ocean_UserInfo sharedOcean_UserInfo].m_registPhone;
        phoneField.userInteractionEnabled = NO;
    }else if ([@"1"isEqualToString:self.m_type]){
        [nextButton setTitle:@"更换" forState:UIControlStateNormal];
        indicatorLabel.text = @"绑定新手机号:";
    }
    
    
    [self setupLayout];
}
- (void)setupLayout
{
    indicatorLabel.x = 10;
    indicatorLabel.y = 2*indicatorLabel.x;
    indicatorLabel.width = 100;
    indicatorLabel.height = 20;
    
    phoneLabel.x = 50;
    phoneLabel.y = 100;
    phoneLabel.width = 80;
    phoneLabel.height = 20;
    
    phoneField.x = phoneLabel.x + phoneLabel.width;
    phoneField.y = phoneLabel.y;
    phoneField.width = 150;
    phoneField.height = phoneLabel.height;
    
    pinLabel.x = phoneLabel.x;
    pinLabel.y = phoneLabel.bottom+15;
    pinLabel.width = 80;
    pinLabel.height = 20;
    
    pinField.x = pinLabel.x + pinLabel.width;
    pinField.y = pinLabel.y;
    pinField.width = 150;
    pinField.height = phoneLabel.height;
    
    getPinButton.width = 80;
    getPinButton.height = 15;
    getPinButton.x = self.view.width -getPinButton.width - 20;
    getPinButton.centerY = pinField.centerY;
    
    splitView.height = 1;
    splitView.x = pinLabel.x;
    splitView.y = phoneLabel.bottom + (pinLabel.y-phoneLabel.bottom)/2 - 0.5;
    splitView.width = getPinButton.x + getPinButton.width - pinLabel.x;
    
    nextButton.width = 275;
    nextButton.height = 40;
    nextButton.x = (self.view.width-nextButton.width)/2;
    nextButton.y = pinField.bottom +100;
    nextButton.layer.cornerRadius = 5;
}


- (void)sendCodeClick {
    

    [self setupCode];
    [self GET_RegestSendYanCode];
    
}

- (void)next
{
    if ([randompassword isEqualToString:pinField.text]) {
       
        if ([@"0"isEqualToString:self.m_type]) {
            //验证旧手机成功
            Ocean_ChangePhoneController *changeVC =[[Ocean_ChangePhoneController alloc]init];
            changeVC.m_type = @"1";
            [self.navigationController pushViewController:changeVC animated:YES];
            
        }else if ([@"1"isEqualToString:self.m_type]){
            //调用修改手机号接口
            if (![self.p_sendPhone isEqualToString:phoneField.text]) {
                [MBProgressHUD showErrorMessage:@"验证码错误"];
                return;
            }
            
            
            [self UPDATEUSERINFO];
        }
        
    }
    else
    {
        [MBProgressHUD showInfoMessage:@"验证码错误"];
    }
    
}


- (void)GET_RegestSendYanCode {
    MJWeakSelf;
    NSDictionary *dic = @{
                          @"m_phoneno":phoneField.text,
                          @"m_code":randompassword,
                          @"m_flag":@"2",
                          };
    
    [MBProgressHUD showActivityMessageInWindow:@""];
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"REGESTSEND-YANCODE" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
                
                [weakSelf performSelector:@selector(sendAction) withObject:nil];
                
                weakSelf.p_sendPhone = weakSelf.phoneField.text;
                
            }else {
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
    }];
}


/**
 * 随机验证码
 */
-(void)setupCode
{
    NSTimeInterval random=[NSDate timeIntervalSinceReferenceDate];
    NSString *randomString = [NSString stringWithFormat:@"%.4f",random];
    randompassword = [[randomString componentsSeparatedByString:@"."]objectAtIndex:1];
    
    NSLog(@"%@",randomString);
}

/**
 * 调方法
 */
-(void)sendAction
{
    getPinButton.enabled = NO;
    _count = 60;
    [getPinButton setTitle:@"60秒" forState:UIControlStateDisabled];
    self.p_timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

-(void)dealloc{
    [self.p_timer invalidate];
    self.p_timer = nil;
}

/**
 * 验证码倒计时
 */
- (void)timerFired:(NSTimer *)_timer
{
    if (_count !=0) {
        _count -=1;
        NSString *str = [NSString stringWithFormat:@"%ld秒", (long)_count];
        [getPinButton setTitle:str forState:UIControlStateDisabled];
    }else{
        [_timer invalidate];
        getPinButton.enabled = YES;
        [getPinButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

-(void)UPDATEUSERINFO{

    MJWeakSelf;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneField.text,@"m_value",@"10",@"m_type",nil];
    
    
    
    [HttpRequestTools  requestUserInfoWithData:dic methodName:@"UPDATEUSERINFO" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [Ocean_UserInfo sharedOcean_UserInfo].m_phone = weakSelf.phoneField.text;
                [Ocean_UserInfo sharedOcean_UserInfo].m_registPhone = weakSelf.phoneField.text;

            [MBProgressHUD showSuccessMessage:respInfo[@"ERRORDESTRIPTION"]];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];



}



@end

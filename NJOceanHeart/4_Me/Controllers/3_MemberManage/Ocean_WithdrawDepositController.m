//
//  Ocean_WithdrawDepositController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_WithdrawDepositController.h"
#import "Ocean_WithMoneyView.h"
#import "Ocean_WithdrawDespositRecordController.h"
#import "WXRPayTool.h"
#import "DCPaymentView.h"
#import "Ocean_PswSetAndModifyViewController.h"
@interface Ocean_WithdrawDepositController ()<Ocean_WithMoneyViewdelegate>
{
    NSString *p_shouXu,*p_money;;
}

@property (nonatomic,weak) UILabel * p_leftTitleLb;
@property (nonatomic,weak) UILabel * p_leftContentLb;
@property (nonatomic,weak) UILabel * p_countLb;
@property (nonatomic,weak) UIButton * p_commitButton;
@property (nonatomic,weak) Ocean_WithMoneyView * p_inputView;

@end

@implementation Ocean_WithdrawDepositController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"提现";
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    
    UIButton *logbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logbutton setTitle:@"提现记录" forState:0];
    [logbutton setTitleColor:[UIColor blueColor] forState:0];
    logbutton.titleLabel.font = [UIFont systemFontOfSize:16];
    [logbutton addTarget:self action:@selector(logMethod) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:logbutton];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"提交" forState:0];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.layer.masksToBounds = YES;
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    nextBtn.userInteractionEnabled = NO;
    [nextBtn addTarget:self action:@selector(commitMethod) forControlEvents:UIControlEventTouchUpInside];

    [scroll addSubview:nextBtn];
    
    self.p_commitButton = nextBtn;
    
    
    self.p_leftTitleLb = [self creatLb:RGB(170, 170, 170) andFont:[UIFont systemFontOfSize:16] andPresentView:scroll andText:@"账户余额"];
    
    self.p_leftContentLb = [self creatLb:[UIColor blackColor] andFont:[UIFont systemFontOfSize:16] andPresentView:scroll andText:@"0.00"];
    self.p_leftContentLb.text = self.m_leftMoney;

    self.p_countLb = [self creatLb:RGB(170, 170, 170) andFont:[UIFont systemFontOfSize:16] andPresentView:scroll andText:@"提现金额(元)"];
    
    
    self.p_leftTitleLb.x = 10;
    self.p_leftTitleLb.y = 25;
    [self.p_leftTitleLb sizeToFit];

    [logbutton sizeToFit];
    logbutton.right = screen_Width - 10;
    logbutton.centerY = self.p_leftTitleLb.centerY;
    
    self.p_leftContentLb.x = self.p_leftTitleLb.x;
    self.p_leftContentLb.width = screen_Width -2 *self.p_leftContentLb.x;
    self.p_leftContentLb.height = 17;
    self.p_leftContentLb.y = self.p_leftTitleLb.bottom +15;
    
    
    self.p_countLb.x = self.p_leftTitleLb.x;
    [self.p_countLb sizeToFit];
    self.p_countLb.y = self.p_leftContentLb.bottom +15;
    
    Ocean_WithMoneyView *inputView = [[Ocean_WithMoneyView alloc]initWithFrame:CGRectMake(10, self.p_countLb.bottom +10, self.view.width - 20, 90)];
    inputView.delegate = self;
    self.p_inputView = inputView;
    [scroll addSubview:inputView];
    
    nextBtn.width = screen_Width *442/524;
    nextBtn.height = screen_Width *60/524;
    nextBtn.y = inputView.bottom +60;
    nextBtn.centerX = self.view.width/2;
    
    scroll.contentSize = CGSizeMake(screen_Width, screen_Height);
    
    [self CASHCOMMISSION];
}

//提现记录
-(void)logMethod{
    Ocean_WithdrawDespositRecordController *recordVC = [[Ocean_WithdrawDespositRecordController alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

//提交
-(void)commitMethod{
    [self JudgePayPwd];
}

-(void)judgeInputRight:(BOOL)isRight andText:(NSString *)money{
    self.p_commitButton.userInteractionEnabled = isRight;
    p_money = money;
    if (isRight) {
        [self.p_commitButton setBackgroundColor:BackgroundColors(1)];

        
    }else{
        [self.p_commitButton setBackgroundColor:[UIColor lightGrayColor]];

    }
    double moneysum =   2;
    [self.p_inputView setCommissionCharge:[NSString stringWithFormat:@"%.2lf",moneysum]];
}

-(UILabel *)creatLb:(UIColor *)color andFont:(UIFont *)font andPresentView:(UIView *)backView andText:(NSString *)text{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = color;
    label.font = font;
    label.text =text;
    [backView  addSubview:label];
    return label;
}
//99.提现手续费
-(void)CASHCOMMISSION{
//    MJWeakSelf;
//    [MBProgressHUD showActivityMessageInView:@""];
//    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"CASHCOMMISSION" completion:^(id respInfo, NSError *error) {
//        [MBProgressHUD hideHUD];
//        if (!error) {
//            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
//
//                p_shouXu = respInfo[@"m_content"];
//                return;
//            }else{
//                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
//
//            }
//        }else{
//            [MBProgressHUD showErrorMessage:@"网路问题..."];
//        }
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    }];

}







//100.提现申请

-(void)CASHMONEY{

    MJWeakSelf;
//    if (p_shouXu ==nil) {
//        [MBProgressHUD showWarnMessage:@"对不起,目前无法提现"];
//        return;
//    }
    float sum = [p_money doubleValue]-[self.p_inputView.p_lable2.text doubleValue];
    NSString *smoney = [NSString stringWithFormat:@"%.2lf",sum];
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:p_money,@"m_money",smoney,@"m_smoney", nil];
    
    [HttpRequestTools  requestUserInfoWithData:postDic methodName:@"CASHMONEY" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WithdrawDepositReload" object:nil userInfo:@{@"state":@"OK"}];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
}

- (void)JudgePayPwd {
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInWindow:@""];
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"JUDGEPAYPWD" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                //输入支付密码
                DCPaymentView *payAlert = [[DCPaymentView alloc]init];
                payAlert.title = @"请输入支付密码";
                payAlert.detail = @"提现";
                payAlert.amount= [p_money floatValue];
                [payAlert show];
                payAlert.completeHandle = ^(NSString *inputPwd) {
                    [weakSelf CHECKPAYPWD:inputPwd];
                    
                };
                
            }else {
                //未设置支付密码
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未设置支付密码，无法完成支付!" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    Ocean_PswSetAndModifyViewController *pswVC = [[Ocean_PswSetAndModifyViewController alloc] init];
                    pswVC.type = @"set";
                    [weakSelf.navigationController pushViewController:pswVC animated:YES];
                    
                }]];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil]];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            
        }else {
            
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
            
            
        }
    }];
}

-(void)CHECKPAYPWD:(NSString *)payKey{
    
    MJWeakSelf;
    
    [MBProgressHUD showActivityMessageInView:@""];
    
    [HttpRequestTools  requestUserInfoWithData:@{@"m_password":payKey} methodName:@"CHECKPAYPWD" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [weakSelf CASHMONEY];

                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
}

@end

//
//  Ocean_PayGoodsController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/4.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_PayGoodsController.h"

#import "Ocean_PswSetAndModifyViewController.h"

@interface Ocean_PayGoodsController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UILabel *nameTLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *orderTLabel;
@property (nonatomic,strong) UILabel *orderLabel;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIButton *payButton;
@property (nonatomic,strong) UITextField *textFiled;

@end

@implementation Ocean_PayGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    
}

- (void)initView {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, screen_Width, 20)];
    self.titleLabel.text = @"订单缴费";
    self.titleLabel.textColor = [UIColor colorWithRed:0.192 green:0.196 blue:0.200 alpha:1.000];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.titleLabel];
    
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + 10, screen_Width, 30)];
    self.moneyLabel.text = self.payPrice;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.moneyLabel];
    
    self.line0 = [[UIView alloc] initWithFrame:CGRectMake(0, self.moneyLabel.bottom + 20, screen_Width, 1)];
    self.line0.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
    [self.view addSubview:self.line0];
    
    self.nameTLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.line0.bottom + 20, 100, 20)];
    self.nameTLabel.text = @"收款方";
    self.nameTLabel.textColor = [UIColor colorWithRed:0.549 green:0.549 blue:0.557 alpha:1.000];
    self.nameTLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.nameTLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115 , self.line0.bottom + 20, screen_Width - 130, 20)];
    self.nameLabel.text = self.userName;
    self.nameLabel.textColor = [UIColor colorWithRed:0.204 green:0.208 blue:0.212 alpha:1.000];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.nameLabel];
    
    self.orderTLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.nameTLabel.bottom + 20, 100, 20)];
    self.orderTLabel.text = @"订单号";
    self.orderTLabel.textColor = [UIColor colorWithRed:0.549 green:0.549 blue:0.557 alpha:1.000];
    self.orderTLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.orderTLabel];
    
    self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(115 , self.nameTLabel.bottom + 20, screen_Width - 130, 20)];
    self.orderLabel.text = self.orderno;
    self.orderLabel.textColor = [UIColor colorWithRed:0.204 green:0.208 blue:0.212 alpha:1.000];
    self.orderLabel.textAlignment = NSTextAlignmentRight;
    self.orderLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.orderLabel];
    
    self.line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.orderTLabel.bottom + 20, screen_Width, 1)];
    self.line1.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
    [self.view addSubview:self.line1];
    
    self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payButton.frame = CGRectMake(30, self.line1.bottom + 40, screen_Width - 60, 40.f/460.f*screen_Height);
    self.payButton.backgroundColor = [UIColor colorWithRed:0.831 green:0.169 blue:0.196 alpha:1.000];
    [self.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payButton.layer.cornerRadius = 5;
    self.payButton.layer.masksToBounds = YES;
    [self.payButton addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payButton];
    
}

- (void)payClick {
    
    [self JudgePayPwd];
    
    
}


//判断是否设置过支付密码
- (void)JudgePayPwd {
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"JUDGEPAYPWD" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                //设置过支付密码
                
                /** 判断库存
                 *[self JudgeStockNum];
                 */
                MJWeakSelf
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入支付密码!" preferredStyle:UIAlertControllerStyleAlert];
                //                alert.sty
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"密码";
                    weakSelf.textFiled = textField;
                }];
                [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self ConfirmMonetPwdWithPassWord:weakSelf.textFiled.text];
                    
                }]];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            }else {
                //未设置支付密码
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未设置支付密码，无法完成支付!" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    Ocean_PswSetAndModifyViewController *pswVC = [[Ocean_PswSetAndModifyViewController alloc] init];
                    pswVC.type = @"set";
                    [self.navigationController pushViewController:pswVC animated:YES];
                    
                }]];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            
            
            
        }else {
          
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
            
            
        }
    }];
}


//判断库存
- (void)JudgeStockNum {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_orderno":self.orderno
                          };
    
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"JUDGESTOCKNUM" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                
                MJWeakSelf;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入支付密码!" preferredStyle:UIAlertControllerStyleAlert];
//                alert.sty
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"密码";
                    weakSelf.textFiled = textField;
                }];
                [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }]];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                
                
            }else {
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
    }];
    
}


//订单支付，验证支付密码
- (void)ConfirmMonetPwdWithPassWord:(NSString *)passWord {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_sign":self.isShopStore ? @"0" : @"1", // 0：一起支付 1：单个支付
                          @"m_orderno":self.orderno,  // m_sign = 0 时，为总单号 ；flag=1时，为子订单号
                          @"m_price":[self.payPrice substringFromIndex:1],
                          @"m_password":passWord
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"CONFIRMMONEYPWD" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                [MBProgressHUD showSuccessMessage:respInfo[@"ERRORDESTRIPTION"]];

                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CZWPayfinish" object:nil];
                
            }else {
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
    }];
    
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

//
//  Ocean_TransferAccountsController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_TransferAccountsController.h"
#import "Ocean_TAccountsView.h"
#import "Ocean_FriendInfoModel.h"
#import "DCPaymentView.h"
#import "Ocean_PswSetAndModifyViewController.h"
@interface Ocean_TransferAccountsController ()<Ocean_TAccountsViewDelegate>

@property (nonatomic,strong) NSString *m_money;


@end

@implementation Ocean_TransferAccountsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";
    Ocean_TAccountsView *showView = [[Ocean_TAccountsView alloc]initWithFrame:CGRectMake(15, 79, self.view.width -30, 306)];
    [showView setFriendPic:self.m_infoModel.m_headpic andNickName:self.m_infoModel.m_nickname];
    showView.delegate = self;
    self.view.backgroundColor = RGB(239, 239, 239);
    [self.view addSubview:showView];
    
    
    

}

-(void)Ocean_TAccountsViewClickTransferAccount:(NSString *)money{
    float moneynum = [money floatValue];
    if(moneynum >0){
        self.m_money = money;
        [self JudgePayPwd];
        //调用支付接口
        
    }else{
        [MBProgressHUD showErrorMessage:@"请输入合法字符"];
    }

}


//判断是否设置过支付密码
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
                payAlert.detail = @"转账";
                payAlert.amount= [weakSelf.m_money floatValue];;
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






-(void)CHECKPAYPWD:(NSString *)payKey{

    MJWeakSelf;
    
    [MBProgressHUD showActivityMessageInView:@""];
    
    [HttpRequestTools  requestUserInfoWithData:@{@"m_password":payKey} methodName:@"CHECKPAYPWD" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [weakSelf TRANSFERACCOUNTS];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];

}


-(void)TRANSFERACCOUNTS{

    MJWeakSelf;
    [MBProgressHUD showActivityMessageInView:@""];

    [HttpRequestTools  requestUserInfoWithData:@{
                                                 @"m_ruid":self.m_fuid,
                                                 @"m_price":self.m_money
                                                 } methodName:@"TRANSFERACCOUNTS" completion:^(id respInfo, NSError *error) {
                                                     [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                [MBProgressHUD showSuccessMessage:@"转账成功!"];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];


}



@end

//
//  Ocean_EditCardController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_EditCardController.h"

@interface Ocean_EditCardController ()

@property (nonatomic,strong) UILabel *numeLabel;
@property (nonatomic,strong) UITextField *numeText;

@property (nonatomic,strong) UILabel *bankLabel;
@property (nonatomic,strong) UITextField *bankText;

@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;

@end

@implementation Ocean_EditCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改银行卡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    [self initView];
    
}

- (void)saveClick {
    
    if (!self.numeText.text.length) {
        [MBProgressHUD showWarnMessage:@"请输入卡号!"];
        return;
    }
    
    if (!self.bankText.text.length) {
        [MBProgressHUD showWarnMessage:@"请输入开户行!"];
        return;
    }
    
    [self UpdateBankinfo];
    
}

- (void)initView {
    
    //20220406，适配大屏幕手机
    CGFloat SHH =  screen_Height>=812 ?64+30:64;
    
    CGSize numS = [StringSizeModel sizeWithText:@"银行卡号: " font:[UIFont systemFontOfSize:15]];
    
//    self.numeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, numS.width, 40)];
    self.numeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SHH, numS.width, 40)];
    
    self.numeLabel.text = @"银行卡号: ";
    self.numeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.numeLabel];
    
    
//    self.numeText = [[UITextField alloc] initWithFrame:CGRectMake(self.numeLabel.right, 64, screen_Width - 10 - self.numeLabel.right, 40)];
    self.numeText = [[UITextField alloc] initWithFrame:CGRectMake(self.numeLabel.right, SHH, screen_Width - 10 - self.numeLabel.right, 40)];
    
    self.numeText.placeholder = @"请填写绑定银行卡号";
    self.numeText.textColor = [UIColor lightGrayColor];
    self.numeText.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.numeText];
    
    self.line0 = [[UIView alloc] initWithFrame:CGRectMake(0, self.numeLabel.bottom, screen_Width, 1)];
    self.line0.backgroundColor = [UIColor lightlightGrayColor];
    [self.view addSubview:self.line0];
    
    
    CGSize bankS = [StringSizeModel sizeWithText:@"开户行/支行: " font:[UIFont systemFontOfSize:15]];
    self.bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.line0.bottom, bankS.width, 40)];
    self.bankLabel.text = @"开户行/支行: ";
    self.bankLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.bankLabel];
    
    
    self.bankText = [[UITextField alloc] initWithFrame:CGRectMake(self.bankLabel.right, self.line0.bottom, screen_Width - 10 - self.bankLabel.right, 40)];
    self.bankText.placeholder = @"请填写银行卡开户行";
    self.bankText.textColor = [UIColor lightGrayColor];
    self.bankText.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.bankText];
    
    self.line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.bankLabel.bottom, screen_Width, 1)];
    self.line1.backgroundColor = [UIColor lightlightGrayColor];
    [self.view addSubview:self.line1];
    
}


- (void)UpdateBankinfo {
    
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_type":@"14",
                          @"m_value":[NSString stringWithFormat:@"%@,%@",self.bankText.text,self.numeText.text]
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"UPDATEUSERINFO" completion:^(id respInfo, NSError *error) {
        if (!error) {
           
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"EditCardSuccess" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"网络异常!"];
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

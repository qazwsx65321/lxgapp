//
//  ForgetPassWordController.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/17.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "ForgetPassWordController.h"
#import "ResetPasswordController.h"

#import "RegistCell.h"
#import "ForgetCell.h"

@interface ForgetPassWordController ()<UITableViewDelegate,UITableViewDataSource,ForgetCellDelegate,RegistCellDelegate>
{
    NSInteger _count;
    NSInteger orgialNum;
    NSInteger seed;
    
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) UIButton * p_sendCodeButton;
@property (nonatomic,weak) UITextField * p_phoneTF;
@property (nonatomic,weak) UITextField * p_passWordTF;
@property (nonatomic,strong) NSTimer * p_timer;

@end

@implementation ForgetPassWordController



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"忘记密码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RegistCell *cell = [RegistCell cellWithTableView:tableView];
        cell.index = 0;
        self.p_phoneTF = cell.textFiled;
        self.p_phoneTF.text = self.m_phoneNum;
        return cell;
    }else if (indexPath.row == 1) {
        RegistCell *cell = [RegistCell cellWithTableView:tableView];
        cell.index = 2;
        cell.delegate = self;
        self.p_passWordTF = cell.textFiled;
        return cell;
    }else {
        ForgetCell *cell = [ForgetCell cellWithTableView:tableView];
        cell.isForget = YES;
        cell.delegate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 2 ? 400.f*screen_Width/750.f : 118.f*screen_Width/750.f;
}

- (void)didNextStep:(ForgetCell *)cell {
    NSString *pass = self.p_passWordTF.text;
    NSInteger org =  [pass integerValue];
    if (pass.length <4 || (org !=orgialNum)) {
        [MBProgressHUD showErrorMessage:@"请输入正确的验证码"];
        return;
    }
    ResetPasswordController *resetVC =[[ResetPasswordController alloc]init];
    resetVC.m_phone = self.p_phoneTF.text;
    int type = [self.m_flag intValue] -1;
    resetVC.m_type = [NSString stringWithFormat:@"%d",type];
    [self.navigationController pushViewController:resetVC animated:YES];
}

-(void)clickButtonPostCode:(UIButton *)sender{
    self.p_sendCodeButton  = sender;
    [self REGESTSEND_YANCODE];
}

-(void)REGESTSEND_YANCODE{

    MJWeakSelf;
    NSString *name = self.p_phoneTF.text;
    if (name.length ==0 || ![name checkPhoneNo]) {
        [MBProgressHUD showErrorMessage:@"请输入正确的手机号码!"];
        return;
    }
    
    NSInteger orgeNum = arc4random_uniform(10000);
    NSString *random = [NSString stringWithFormat:@"%04ld",orgeNum];
    NSLog(@"%@",random);
    [MBProgressHUD showActivityMessageInView:@""];
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_flag":self.m_flag,
                                                   @"m_code":random,
                                                   @"m_phoneno":name} methodName:@"REGESTSEND-YANCODE" completion:^(id respInfo, NSError *error) {
                                                       [MBProgressHUD hideHUD];

        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
                weakSelf.p_sendCodeButton.enabled = NO;
                _count = 60;
                [weakSelf.p_sendCodeButton setTitle:@"剩余60秒" forState:UIControlStateDisabled];
                weakSelf.p_phoneTF.userInteractionEnabled = NO;
               weakSelf.p_timer=  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
                orgialNum = orgeNum;
            

            }else{
                
                
                [MBProgressHUD showTipMessageInWindow:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
}



- (void)timerFired:(NSTimer *)_timer
{
    if (_count !=0) {
        _count -=1;
        NSString *str = [NSString stringWithFormat:@"剩余%ld秒", (long)_count];
        [self.p_sendCodeButton setTitle:str forState:UIControlStateDisabled];
    }else{
        [_timer invalidate];
        self.p_sendCodeButton.enabled = YES;
        self.p_phoneTF.userInteractionEnabled = YES;
        [self.p_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

-(void)dealloc{
    [self.p_timer invalidate];
    self.p_timer = nil;

}


@end

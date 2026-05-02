//
//  ResetPasswordController.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/17.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "ResetPasswordController.h"

#import "RegistCell.h"
#import "ForgetCell.h"
#import "Ocean_BindPhoneController.h"
@interface ResetPasswordController ()<UITableViewDelegate,UITableViewDataSource,ForgetCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,weak) UITextField * p_passTF;
@property (nonatomic,weak) UITextField * p_secondPassTF;
@property (nonatomic,weak) UITextField * p_InvitationTF;

@end

@implementation ResetPasswordController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置密码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([@"1" isEqualToString:self.m_type]) {
//        return 3;
//    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    if ([@"1" isEqualToString:self.m_type]) {

        
        if (indexPath.row == 0) {
            RegistCell *cell = [RegistCell cellWithTableView:tableView];
            cell.index = 3;
            self.p_passTF = cell.textFiled;
            return cell;
        }else if (indexPath.row == 1) {
            RegistCell *cell = [RegistCell cellWithTableView:tableView];
            self.p_secondPassTF = cell.textFiled;
            cell.index = 4;
            return cell;
        }else {
            ForgetCell *cell = [ForgetCell cellWithTableView:tableView];
            cell.delegate = self;
            cell.isForget = NO;
            return cell;
        }
}
    
    
    
    
//    
//    if (indexPath.row == 0) {
//        RegistCell *cell = [RegistCell cellWithTableView:tableView];
//        cell.index = 3;
//        self.p_passTF = cell.textFiled;
//        return cell;
//    }else if (indexPath.row == 1) {
//        RegistCell *cell = [RegistCell cellWithTableView:tableView];
//        self.p_secondPassTF = cell.textFiled;
//        cell.index = 4;
//        return cell;
//    }else if (indexPath.row == 2) {
//        RegistCell *cell = [RegistCell cellWithTableView:tableView];
//        self.p_InvitationTF = cell.textFiled;
//        cell.index = 7;
//        return cell;
//    }else {
//        ForgetCell *cell = [ForgetCell cellWithTableView:tableView];
//        cell.delegate = self;
//        cell.isForget = NO;
//        return cell;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([@"1" isEqualToString:self.m_type]) {
    
        return indexPath.row == 2 ? 400.f*screen_Width/750.f : 118.f*screen_Width/750.f;
    
//    }
    
//    return indexPath.row == 3 ? 400.f*screen_Width/750.f : 118.f*screen_Width/750.f;
}

-(void)MYCENTERREGISTER{

    MJWeakSelf;
    NSString *pass = self.p_passTF.text;
    NSString *secondPass = self.p_secondPassTF.text;
    if (pass.length<6) {
        [MBProgressHUD showErrorMessage:@"请输入>6位的密码!"];
        return;
    }
    if (![secondPass isEqualToString:pass]) {
        [MBProgressHUD showErrorMessage:@"两次输入的密码不一致!"];
        return;
    }
    NSString * invitecode = @"";
    [MBProgressHUD showActivityMessageInWindow:@""];
    [HttpRequestTools  requestUNUserInfoWithData:@{
                                                   @"m_phoneno":self.m_phone,
                                                   @"m_password":pass,
                                                   @"m_invitecode":invitecode,
                                                   @"m_type":self.m_type
                                                   } methodName:@"MYCENTERREGISTER" completion:^(id respInfo, NSError *error) {
                                                       [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    for (UIViewController *control in self.navigationController.childViewControllers) {
                        if ([control isKindOfClass:[Ocean_BindPhoneController class]]) {
                            [MBProgressHUD showSuccessMessage:@"设置成功!"];
                            [weakSelf.navigationController popToViewController:control animated:YES];
                            return;
                        }
                    }
                
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    [MBProgressHUD showSuccessMessage:@"设置成功!"];
                });
            }else{
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];

    


}

-(void)didNextStep:(ForgetCell *)cell{

    [self MYCENTERREGISTER];

}

@end

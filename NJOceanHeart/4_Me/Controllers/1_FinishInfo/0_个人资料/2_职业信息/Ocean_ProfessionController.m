//
//  Ocean_ProfessionController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ProfessionController.h"

#import "Ocean_ProfessionCell.h"

@interface Ocean_ProfessionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation Ocean_ProfessionController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"职业信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_ProfessionCell *cell = [Ocean_ProfessionCell cellWithTableView:tableView];
    cell.type = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f*screen_Width/750.f + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self showAlertViewWithTitie:@"单位名称" withFlag:@"12" withValue:[Ocean_UserInfo sharedOcean_UserInfo].m_company];
    }else {
        [self showAlertViewWithTitie:@"职位/职务" withFlag:@"13" withValue:[Ocean_UserInfo sharedOcean_UserInfo].m_jobname];
    }
    
}


//单位名称、职位
- (void)showAlertViewWithTitie:(NSString *)title withFlag:(NSString *)flag withValue:(NSString *)value {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    __block UITextField *tf = [[UITextField alloc] init];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        tf = textField;
        tf.text = value;
    }];
    MJWeakSelf;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf EDIT_UpdateUserinfoWithFlag:flag withText:tf.text];
        
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)EDIT_UpdateUserinfoWithFlag:(NSString *)flag withText:(NSString *)text {
    
    MJWeakSelf;
    NSDictionary *dic = @{
                          @"m_bid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_type":flag,   // 1姓名，2性别，3出生日期，4证件类型（不使用） 5.证件号码（不使用），6.婚姻状况，7.教育程度，8住宅情况，9住宅地址，10手机号（不使用），11，QQ邮箱（不使用），12.单位名称，13.职务
                          @"m_value":text,
                          };
    
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"UPDATEUSERINFO" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                if ([@"12" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_company"];
                }else {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_jobname"];
                }
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        
        [weakSelf.tableView reloadData];
    }];
    
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

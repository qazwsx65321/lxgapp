//
//  Ocean_MemberManageController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MemberManageController.h"
#import "Ocean_PswManageViewController.h"

#import "Ocean_MemberManageHeadCell.h"
#import "Ocean_MemberManageContentCell.h"
#import "Ocean_chooseRechargeController.h"
#import "WXRPayTool.h"
#import "Ocean_WithdrawDepositController.h"
@interface Ocean_MemberManageController ()<UITableViewDelegate,UITableViewDataSource,MemberHeadDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray * p_recoidArr;
@property (nonatomic,strong) NSString * p_totalMoney;
@end

@implementation Ocean_MemberManageController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //20220406 modify
//    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.alpha = 0;
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.alpha = 1;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.alpha = 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员管理";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payFinsh:) name:WXRPayToolFinishNotication object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadMoney) name:@"WithdrawDepositReload" object:nil];

    
    _p_totalMoney = @"";
    [self MEMBERMANAGE];
}

-(void)reloadMoney{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self MEMBERMANAGE];
    });

}

-(void)payFinsh:(NSNotification *)not{
    if ([not.userInfo[@"state"] isEqualToString:@"OK"]) {
        [self.navigationController popToViewController:self animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self MEMBERMANAGE];
        });
    }
}

- (void)manageDidWithdraw
{
    Ocean_WithdrawDepositController *WDVC = [[Ocean_WithdrawDepositController alloc]init];
    WDVC.m_leftMoney =  self.p_totalMoney;
    [self.navigationController pushViewController:WDVC animated:YES];
}
- (void)manageDidRecharge
{
    Ocean_chooseRechargeController *recharge = [[Ocean_chooseRechargeController alloc]init];
    [self.navigationController pushViewController:recharge animated:YES];
    
}
- (void)manageDidSetup
{
    Ocean_PswManageViewController *controller = [[Ocean_PswManageViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)manageDidBack
{
    [self.navigationController  popViewControllerAnimated:YES];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.p_recoidArr.count+2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 260;
    }
    else if (indexPath.row == 1)
    {
        return 45;
    }
    else
    {
        return 60;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Ocean_MemberManageHeadCell *head = [Ocean_MemberManageHeadCell cellWithTableView:self.tableView];
        head.delegate = self;
        
        head.levelLabel.text = [NSString stringWithFormat:@"%@会员",[Ocean_UserInfo sharedOcean_UserInfo].m_cardname];
        head.cashLabel.text = self.p_totalMoney;
        return head;
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
        cell.textLabel.text = @"明细";
        cell.backgroundColor = [UIColor lightlightGrayColor];
        return cell;
    }
    else
    {
        Ocean_memberManageModel *model = self.p_recoidArr[indexPath.row -2];
        Ocean_MemberManageContentCell *content = [Ocean_MemberManageContentCell cellWithTableView:self.tableView];
        content.model = model;
        return content;
    }
}

-(void)MEMBERMANAGE{
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInView:nil];
    [HttpRequestTools  requestUserInfoWithData:nil methodName:@"MEMBERMANAGE" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                weakSelf.p_recoidArr = [Ocean_memberManageModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_moneydetaillist"]];
                
                weakSelf.p_totalMoney = respInfo[@"m_money1"];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.tableView reloadData];
    }];


}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

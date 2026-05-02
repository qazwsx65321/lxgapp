//
//  MeViewController.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/3/24.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeaderCell.h"
#import "MeOrderCell.h"
#import "MeCell.h"
#import "MeOrderCountBody.h"
#import "Ocean_FinshingInfoController.h"
#import "Ocean_OrderController.h"
#import "Ocean_CancelOrderController.h"
#import "Ocean_EnterStorePayController.h"
#import "Ocean_XDConnectRongCloud.h"



@interface MeViewController ()<MeOrderDelegate>

@property (nonatomic, strong)NSArray *badges;
@property (nonatomic, copy)NSString *dotNum;
@property (nonatomic, strong)UIView *dot;
@property (nonatomic,strong) NSArray  * p_classArr;

@end

@implementation MeViewController


-(NSArray *)p_classArr{
    if (!_p_classArr) {
        _p_classArr = @[
                        @[
                            @{@"class":@"Ocean_PersonageInfoController",
                              @"isLogin":@"1",
                              }
                          ],
                        @[
                            @{@"class":@"Ocean_OrderController",@"isLogin":@"1"}
                          ],
                        @[
                            @{@"class":@"Ocean_SmallToolsController",@"isLogin":@"1"},

                                @{@"class":@"redPack",@"isLogin":@"1"}
                          ],
                        @[
                            @{@"class":@"Ocean_MemberManageController",@"isLogin":@"1"},
                            @{@"class":@"Ocean_MyRecommendController",@"isLogin":@"1"},
//                            @{@"class":@"Ocean_EnterStoreController",@"isLogin":@"0"},
                            @{@"class":@"Ocean_SecurityAccountController",@"isLogin":@"1"}
                            ],
                        @[
                            @{@"class":@"Ocean_MessageCenterController",@"isLogin":@"1"},
                            @{@"class":@"Ocean_ShareManageController",@"isLogin":@"0"},
                             @{@"class":@"Ocean_AboutOurController",@"isLogin":@"0"},
                            @{@"class":@"Ocean_CommitOpinionController",@"isLogin":@"0"},
                            ]
                        ];
    }
    return _p_classArr;
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self getOrderCount];
    [self getRedDot];
    NSLog(@"显示了");
//    self.navigationController.alpha = 0;
    [self.tableView reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
//    self.navigationController.alpha = 1;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _dot = [[UIView alloc] initWithFrame:CGRectMake(40, 305, 8, 8)];
////    _dot.layer.cornerRadius = 4;
////    _dot.backgroundColor = [UIColor redColor];
//    [self.tableView addSubview:_dot];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.backgroundColor = [UIColor lightlightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (screen_Height <667) {
        
        self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
        
    }
    
    if (screen_Height ==812) {
        self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);

    }

    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.p_classArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *sectionArr = self.p_classArr[section];
    return sectionArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MeHeaderCell *cell = [MeHeaderCell cellWithTableView:tableView];
        cell.name = [Ocean_UserInfo sharedOcean_UserInfo].isLogin? ([Ocean_UserInfo sharedOcean_UserInfo].m_nickname.length?[Ocean_UserInfo sharedOcean_UserInfo].m_nickname:@"未设置"):@"登录／注册" ;
        cell.headpicture =  [Ocean_UserInfo sharedOcean_UserInfo].isLogin? [Ocean_UserInfo sharedOcean_UserInfo].m_touxiang:@"";
        cell.messageLb.text =  [Ocean_UserInfo sharedOcean_UserInfo].isLogin?[NSString stringWithFormat:@"卡片等级: %@", [Ocean_UserInfo sharedOcean_UserInfo].m_cardname]:@"";
        return cell;
    } else if (indexPath.section == 1) {
        MeOrderCell *cell = [MeOrderCell cellWithTableView:tableView];
        cell.badges = _badges;
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 2) {
        MeCell *cell = [MeCell cellWithTableView:tableView];
        cell.icon = @[@"Me_card",@"Me_card"][indexPath.row];
        
        if (QSisCan) {
            cell.title = @[@"实用工具",@"我的钱包"][indexPath.row];
            
        }else{
            cell.title = @[@"",@"我的钱包"][indexPath.row];
        }
        
        //20210222 注释上面功能。20220406，注释我的钱包功能
        cell.hidden = YES;
        
        return cell;
    }else if (indexPath.section == 3) {
        MeCell *cell = [MeCell cellWithTableView:tableView];
        cell.icon = @[@"me_uselist", @"Me_card", @"shang", @"treat_pay"][indexPath.row];
        cell.title = @[ @"会员管理", @"营销团队", /*@"渠道对接",*/ @"安全账户"][indexPath.row];
        return cell;
    } else {
        MeCell *cell = [MeCell cellWithTableView:tableView];
        
        cell.icon = @[@"Me_news", @"share", @"about",@"opinion"][indexPath.row];
        cell.title = @[@"消息中心", @"分享", @"关于我们",@"意见反馈"][indexPath.row];
        
        //20220406，注释分享的功能
        if([cell.title isEqualToString:@"分享"]){
            cell.hidden = YES;
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.view.width *266/439;
    } else if (indexPath.section == 1) {
        return 100;
    }else if (indexPath.section == 2) {
        if (indexPath.row ==0 && !QSisCan) {
            return 0;
        }
        
        //2021022 modify
        //return 45;
        return 0;
    }else if (indexPath.section == 3) {
        return 45;
    } else {
        //20220406,隐藏分享
        if (indexPath.row ==1) {
            return 0;
        }
        
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 5)];
    view.backgroundColor = [UIColor lightlightGrayColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *dic = self.p_classArr[indexPath.section][indexPath.row];
    if ([dic[@"isLogin"] integerValue]&&(![Ocean_UserInfo sharedOcean_UserInfo].isLogin)) {
        [self presentViewController:LoginVC animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section==0 && indexPath.row==0) {
        UIViewController *VC = [[NSClassFromString(dic[@"class"]) alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    
    if (indexPath.section ==4 && indexPath.row ==0) {
        
        UIViewController *VC = [[NSClassFromString(dic[@"class"]) alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    
    
    if (![dic[@"isLogin"] integerValue]) {
            UIViewController *VC = [[NSClassFromString(dic[@"class"]) alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            if ([Ocean_JudgeAlterView alterViewFrom:self.tabBarController]) {
                if (indexPath.section == 2 && indexPath.row == 1) {
                    [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] openRongCloudRedPacket];
                    return;
                }
                UIViewController *VC = [[NSClassFromString(dic[@"class"]) alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
        }
    }

}
-(void)alterFromVC:(UIViewController *)pre alterVCtitle:(NSString *)VCTitle alterMessage:(NSString *)VCmessage activityAction:(NSString *)message cancelAction:(NSString *)cancelMessage toViewController:(UIViewController *)toVC{

    UIAlertController *alter = [UIAlertController alertControllerWithTitle:VCTitle message:VCmessage preferredStyle:UIAlertControllerStyleAlert];
    
    if (message) {
        [alter addAction:[UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (![toVC isKindOfClass:[Ocean_NavigationController class]]) {
                [self.navigationController pushViewController:toVC animated:YES];
            }else{
                [self presentViewController:toVC animated:YES completion:nil];
            }
        }]];
    }
    
    
    [alter addAction:[UIAlertAction actionWithTitle:cancelMessage style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alter animated:NO completion:nil];


}

- (void)meOrderCell:(MeOrderCell *)orderCell didSelectedTpyeAtIndex:(NSInteger)index
{
    
    if (![Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
        [self presentViewController:LoginVC animated:YES completion:nil];
        return;
    }
    
    
//    NSString *checkFlag = [Ocean_UserInfo sharedOcean_UserInfo].m_checkflag;
    
    if (![Ocean_JudgeAlterView alterViewFrom:self.tabBarController]) {
        return;
    }
    

    
    
    if (index == 4) {
        Ocean_CancelOrderController *orderVC = [[Ocean_CancelOrderController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }else {
        Ocean_OrderController *orderVC = [[Ocean_OrderController alloc] init];
        orderVC.index = [NSString stringWithFormat:@"%zd",index];
        [self.navigationController pushViewController:orderVC animated:YES];
    }
}

- (void)getOrderCount
{

}

- (void)getRedDot
{
   
}

@end

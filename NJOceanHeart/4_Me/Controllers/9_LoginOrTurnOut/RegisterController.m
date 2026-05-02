//
//  RegisterController.m
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/14.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import "RegisterController.h"

#import "RegistCell.h"
#import "RegistCell0.h"
#import "RegistCell1.h"
#import "XRCFWebViewController.h"

#define XRBackgroundColors  [UIColor colorWithHexString:@"4c4c4e" alpha:1]

@interface RegisterController ()<UITableViewDelegate,UITableViewDataSource,RegistCell0Delegate,RegistCell1Delegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) BOOL isShehuiCar;

@end

@implementation RegisterController

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
    
    self.isShehuiCar = NO;
    
    self.title = @"免费注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.isShehuiCar) {
            return 10;
        }else {
            return 7;
        }
    }else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9) {
            RegistCell *cell = [RegistCell cellWithTableView:tableView];
            cell.index = indexPath.row;
            cell.isShehui = self.isShehuiCar;
            return cell;
        }else {
            RegistCell0 *cell = [RegistCell0 cellWithTableView:tableView];
            cell.delegate = self;
            return cell;
        }
    }else {
        RegistCell1 *cell = [RegistCell1 cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 118.f*screen_Width/750.f : 400.f*screen_Width/750.f;
}


- (void)didSelectCar:(RegistCell0 *)cell withIndex:(NSInteger)index {
    if (index == 1000) {
        self.isShehuiCar = NO;
    }else {
        self.isShehuiCar = YES;
    }
    
    [self.tableView reloadData];
}

- (void)didRegist:(RegistCell1 *)cell {
    
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

//20220418,点击打开用户注册协议
-(void)OpenUserAgreeMent{
    NSLog(@"打开用户注册协议-2");
    XRCFWebViewController * web = [[XRCFWebViewController alloc]init];
    web.webUrl = [NSString stringWithFormat:@"%@",APPPAGREEMENTURL];
    web.title = @"用户协议";
    web.webBackColor = XRBackgroundColors;
    [self.navigationController pushViewController:web animated:YES];
}

@end

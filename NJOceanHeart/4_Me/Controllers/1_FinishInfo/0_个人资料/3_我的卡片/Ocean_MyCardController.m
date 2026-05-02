//
//  Ocean_MyCardController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MyCardController.h"

#import "Ocean_MyCardCell0.h"
#import "Ocean_MyCardCell1.h"
#import "Ocean_MyCardCell2.h"

#import "Ocean_MyCardModel.h"
#import "Ocean_EditCardController.h"

@interface Ocean_MyCardController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) Ocean_MyCardModel *cardModel;

@end

@implementation Ocean_MyCardController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
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
    self.title = @"我的卡片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    [self GET_MyCards];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReload) name:@"EditCardSuccess" object:nil];
}

- (void)tableViewReload {
    [self GET_MyCards];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buttonClick {
    
    Ocean_EditCardController *editVC = [[Ocean_EditCardController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section == 0 ? 1 : 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Ocean_MyCardCell0 *cell = [Ocean_MyCardCell0 cellWithTableView:tableView];
        cell.model = self.cardModel;
        return cell;
    }else {
        Ocean_MyCardCell2 *cell = [Ocean_MyCardCell2 cellWithTableView:tableView];
        cell.model = self.cardModel;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 40)];
        bgView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35.f/750.f*screen_Width, 0, 680.f/750.f*screen_Width, 40)];
        label.text = @"绑定的银行卡";
        label.textColor = [UIColor colorWithWhite:0.267 alpha:1.000];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:label];
        return bgView;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 600.f*screen_Width/750.f;
    }else {
        return 82;//230.f*screen_Width/750.f;
    }
}

- (void)GET_MyCards {
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInWindow:nil];
    [self.tableView reloadData];
    self.tableView.hidden = NO;
    [self.tableView hideBlankPageView];
    [self.tableView hideErrorPageView];
    self.cardModel = [[Ocean_MyCardModel alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[Ocean_UserInfo sharedOcean_UserInfo].m_uid,@"m_uid",
                         [Ocean_UserInfo sharedOcean_UserInfo].m_session,@"m_session",nil];
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"MYCARDS" completion:^(id respInfo, NSError *error) {
        
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                
                if ([@"Y" isEqualToString:respInfo[@"m_checkflag"]]) {
                    
                    weakSelf.cardModel = [Ocean_MyCardModel mj_objectWithKeyValues:respInfo];
                    
                    
                    
                }else if ([@"N" isEqualToString:respInfo[@"m_checkflag"]]) {
                    self.tableView.hidden = YES;
                    [weakSelf.view showBlankPageView:@"审核未通过" andImageName:@"commentEmpty"];
                }else {
                    self.tableView.hidden = YES;
                    [weakSelf.view showBlankPageView:@"审核中" andImageName:@"commentEmpty"];
                }
                
                
                
            }else{
                self.tableView.hidden = YES;
                [weakSelf.view showBlankPageView:respInfo[@"ERRORDESTRIPTION"] andImageName:@"commentEmpty"];
            }
        }else{
            self.tableView.hidden = YES;
            [weakSelf.view showErrorPageView];
        }
        [weakSelf.tableView reloadData];
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

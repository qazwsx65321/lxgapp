//
//  Ocean_MyRecommendController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MyRecommendController.h"
#import "Ocean_RecommandHeadCell.h"
#import "Ocean_RecommandBodyCell.h"
#import "Ocean_RecommandModel.h"
@interface Ocean_MyRecommendController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Ocean_RecommandModel *head;

@end

@implementation Ocean_MyRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =@"营销团队";
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    else
    {
        return 35;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 + self.head.m_list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Ocean_RecommandHeadCell *cell = [Ocean_RecommandHeadCell cellWithTableView:tableView];
        cell.model = self.head;
        return cell;
    }
    else
    {
        if (indexPath.row == 1) {
            Ocean_RecommandBodyCell *cell = [Ocean_RecommandBodyCell cellWithTableView:tableView];
            cell.titles = @[@"姓名",@"电话"];
            return cell;
        }
        else
        {
            Ocean_RecommandBodyCell *cell = [Ocean_RecommandBodyCell cellWithTableView:tableView];
            Ocean_RecommandBody *body = self.head.m_list[indexPath.row-2];
            cell.model = body;
            return cell;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData
{
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_page":@"1",
                          };
    self.head = [[Ocean_RecommandModel alloc] init];
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"GETRECOMMENDLIST" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                self.head = [Ocean_RecommandModel mj_objectWithKeyValues:respInfo];
              
            }else {
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        [self.head judgeObjectPropertyNull];
        [_tableView reloadData];
        
    }];
}


@end

//
//  Ocean_NewsLinkVC.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_NewsLinkVC.h"

#import "Ocean_NewsHeaderView.h"
#import "Ocean_NewsCell.h"
#import "Ocean_NewsDetailVC.h"

@interface Ocean_NewsLinkVC ()<Ocean_NewsHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) Ocean_NewsHeaderView *headerView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *infoArray;

@property (nonatomic,copy) NSString *tagStr;

@end

@implementation Ocean_NewsLinkVC

- (NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, screen_Width, screen_Height - 104) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor lightlightGrayColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (Ocean_NewsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[Ocean_NewsHeaderView alloc] initWithFrame:CGRectMake(0, 64, screen_Width, 40)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"新闻头条";
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.tableView];
    
    self.tagStr = @"top";
    
    [self didNewsWithType:@"top"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self didNewsWithType:self.tagStr];
    }];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_NewsCell *cell = [Ocean_NewsCell cellWithTableView:tableView];
    cell.cellframes = self.infoArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Ocean_NewsFrame *m = self.infoArray[indexPath.row];
    Ocean_NewsDetailVC *detailVC = [[Ocean_NewsDetailVC alloc] init];
    detailVC.urlString = m.model.url;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.infoArray.count) {
        Ocean_NewsFrame *frames = self.infoArray[indexPath.row];
        return frames.bgViewF.size.height + 1;
    }
    
    return 0;
}


- (void)didNewsWithType:(NSString *)type {
    
    self.tagStr = type;
    
    self.infoArray = [NSMutableArray array];
    
    [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    
    [Ocean_DataTools GetNewsWithType:type withBlock:^(id data) {
        
        NSArray *arr = [NSArray array];
        arr = data;
        
        for (int i = 0; i < arr.count; i ++ ) {
            Ocean_NewsFrame *frames = [[Ocean_NewsFrame alloc] init];
            frames.model = arr[i];
            [self.infoArray addObject:frames];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD hideHUD];
        });
    } withError:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showInfoMessage:@"暂无相关资讯!"];
            [self.tableView reloadData];
            
        });
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

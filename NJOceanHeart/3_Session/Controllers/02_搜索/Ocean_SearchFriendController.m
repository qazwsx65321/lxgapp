//
//  Ocean_SearchFriendController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/20.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_SearchFriendController.h"

#import "Ocean_SearchFriendCell.h"
#import "Ocean_SearchModel.h"
#import "Ocean_FriendsInfoController.h"

@interface Ocean_SearchFriendController ()<UITableViewDelegate,UITableViewDataSource>

{
    UISearchBar *searchView;
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *infoArray;

@end

@implementation Ocean_SearchFriendController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchView = [[UISearchBar alloc] init];
    searchView.width = 150.f/320.f*screen_Width;
    searchView.height = 20;
//    searchView.backgroundColor = [UIColor whiteColor];
    searchView.placeholder = @"请输入手机号或昵称";
    self.navigationItem.titleView = searchView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    [self.view addSubview:self.tableView];
    
}

- (void)searchClick {
    
    [self SearchFriends];
    [searchView endEditing:YES];
    
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
    Ocean_SearchFriendCell *cell = [Ocean_SearchFriendCell cellWithTableView:tableView];
    cell.model = self.infoArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Ocean_SearchModel *model = self.infoArray[indexPath.row];
    
    Ocean_FriendsInfoController *friendVC = [[Ocean_FriendsInfoController alloc] init];
    friendVC.friendid = model.m_uid;
    [self.navigationController pushViewController:friendVC animated:YES];
}

- (void)SearchFriends {
    
    
    if (!searchView.text.length) {
        [MBProgressHUD showWarnMessage:@"请输入关键字!"];
        return;
    }
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_keyword":searchView.text
                          };
    
    self.infoArray = [NSArray array];
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"SEARCHFRIENDS" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                Ocean_SearchHead *head = [Ocean_SearchHead mj_objectWithKeyValues:respInfo];
                self.infoArray = head.m_selectlist;
                
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"网络错误!"];
        }
        
        [self.tableView reloadData];
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

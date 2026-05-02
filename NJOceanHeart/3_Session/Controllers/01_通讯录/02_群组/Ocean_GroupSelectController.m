//
//  Ocean_GroupSelectController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/20.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupSelectController.h"

#import "Ocean_ContactCell.h"
#import "Ocean_FriendsModel.h"

#import "Ocean_GroupModel.h"

@interface Ocean_GroupSelectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *infoArray;
@property (nonatomic,strong) NSMutableArray *groupArray;
@property (nonatomic,strong) NSMutableArray *friendList;

@end

@implementation Ocean_GroupSelectController

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
    self.title = @"选择联系人";
    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
    
    self.friendList = [NSMutableArray array];
    
    self.groupArray = [NSMutableArray array];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(launchClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    if (_isAddFriend) {
        [self GET_GetFriendsInterface];
    }else {
        [self GetGroupMember];
    }
    
    
    [self.view addSubview:self.tableView];
}

- (void)launchClick {
    
    if (_isAddFriend) {
        [self JoinGroup];
    }else {
        [self DeleteGroupMember];
    }
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isAddFriend ? self.infoArray.count : self.groupArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_ContactCell *cell = [Ocean_ContactCell cellWithTableView:tableView];
    
    if (_isAddFriend) {
        cell.model = self.infoArray[indexPath.row];
    }else {
        cell.model = self.groupArray[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Ocean_ContactCell *cell = (Ocean_ContactCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isTongXun = NO;
    cell.isSelect = !cell.isSelect;
    
    NSDictionary *dic = @{
                          @"m_qid":self.groupid,
                          @"m_uid":cell.model.m_uid
                          };
    
    if (cell.isSelect == YES) {
        [self.friendList addObject:dic];
    }else {
        
        [self.friendList removeObject:dic];
    }
    
    
}

- (void)GET_GetFriendsInterface {
    
    
    MJWeakSelf;
    
    weakSelf.infoArray = [NSArray array];
    
    [HttpRequestTools requestUserInfoWithData:nil methodName:@"GETFRIENDS" completion:^(id respInfo, NSError *error) {
        
        if (!error) {
            
            Ocean_FriendsHead *head = [Ocean_FriendsHead mj_objectWithKeyValues:respInfo];
            
            if ([head.ERRORCODE isEqualToString:@"0000"]) {
                
                weakSelf.infoArray = head.m_myfriends;
                
            }else{
                [MBProgressHUD showTipMessageInView:head.ERRORDESTRIPTION];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        
        [self.tableView reloadData];
        
    }];
}


- (void)GetGroupMember {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_qid":self.groupid
                          };
    
    self.infoArray = [NSMutableArray array];
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"GETGROUPMEMBER" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            Ocean_GroupMemberHead *head = [Ocean_GroupMemberHead mj_objectWithKeyValues:respInfo];
            if ([@"0000" isEqualToString:head.ERRORCODE]) {
                
                
                for (int i = 0; i < head.m_myfriends.count; i ++) {
                    Ocean_GroupMemberModel *model = head.m_myfriends[i];
                    
                    
                    if (![@"1" isEqualToString:model.m_ismanager]) {
                        Ocean_FriendsModel *model0 = [[Ocean_FriendsModel alloc] init];
                        
                        model0.m_uid = model.m_uid;
                        model0.m_token = model.m_token;
                        model0.m_nickname = model.m_mark;
                        model0.m_headpic = model.m_headpic;
                        
                        [self.groupArray addObject:model0];
                    }
                    
                    
                }
                
            }else {
                [MBProgressHUD showInfoMessage:head.ERRORDESTRIPTION];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        
        [self.tableView reloadData];
        
    }];
    
}

- (void)DeleteGroupMember {
    if (self.friendList.count == 0 ) {
        [MBProgressHUD showWarnMessage:@"请选择好友!"];
        return;
    }
    
    NSDictionary *dic = @{
                          @"m_uuid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_sign":@"0",
                          @"m_userList":self.friendList
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"DELETEGROUPMEMBER" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"DealMemberSuccess" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
}


- (void)JoinGroup {
    
    if (self.friendList.count == 0 ) {
        [MBProgressHUD showWarnMessage:@"请选择好友!"];
        return;
    }
    
    NSDictionary *dic = @{
                          @"m_sign":@"0",
                          @"m_userList":self.friendList
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"JOINGROUPMANY" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"DealMemberSuccess" object:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
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

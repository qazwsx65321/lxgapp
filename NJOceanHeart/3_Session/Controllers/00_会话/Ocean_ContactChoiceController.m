//
//  Ocean_ContactChoiceController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ContactChoiceController.h"

#import "Ocean_ContactCell.h"
#import "Ocean_FriendsModel.h"

#import "Ocean_EditGroupController.h"

@interface Ocean_ContactChoiceController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *infoArray;
@property (nonatomic,strong) NSMutableArray *friendList;
@property (nonatomic,strong) NSMutableArray *selectedIds;

@end

@implementation Ocean_ContactChoiceController

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
    self.selectedIds = [NSMutableArray array];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(launchClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    [self GET_GetFriendsInterface];
    
    [self.view addSubview:self.tableView];
}

- (void)launchClick {
    
    if (self.isQunZu) {
        
        //群组聊天
        [self.selectedIds addObject:[Ocean_UserInfo sharedOcean_UserInfo].m_uid];
        Ocean_EditGroupController *editVC = [[Ocean_EditGroupController alloc] init];
        editVC.idsArray = [self.selectedIds mutableCopy];
        [self.navigationController pushViewController:editVC animated:YES];
        
        
    }else {
        if (self.friendList.count == 1) {
            
            Ocean_FriendsModel *model = self.friendList[0];
            
            RCConversationViewController *controller = [[RCConversationViewController alloc] init];
            controller.conversationType = ConversationType_PRIVATE;
            controller.targetId = model.m_uid;
            controller.title = model.m_nickname;
            [self.navigationController pushViewController:controller animated:YES];
        }else {
            
            NSString *groupName = [Ocean_UserInfo sharedOcean_UserInfo].m_nickname;
            for (int i = 0; i < self.friendList.count; i ++) {
                Ocean_FriendsModel *model = self.friendList[i];
                groupName = [NSString stringWithFormat:@"%@、%@",groupName,model.m_nickname];
            }
            
            [[RCIM sharedRCIM] createDiscussion:groupName userIdList:self.selectedIds success:^(RCDiscussion *discussion) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    RCConversationViewController *controller = [[RCConversationViewController alloc] init];
                    controller.conversationType = ConversationType_DISCUSSION;
                    controller.targetId = discussion.discussionId;
                    controller.title = discussion.discussionName;
                    [self.navigationController pushViewController:controller animated:YES];
                } );
                
            } error:^(RCErrorCode status) {
                
            }];
        }
    }
    
    
    
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
    Ocean_ContactCell *cell = [Ocean_ContactCell cellWithTableView:tableView];
    cell.model = self.infoArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Ocean_ContactCell *cell = (Ocean_ContactCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isTongXun = NO;
    cell.isSelect = !cell.isSelect;
    
    if (cell.isSelect == YES) {
        [self.friendList addObject:cell.model];
        [self.selectedIds addObject:cell.model.m_uid];
    }else {
        [self.friendList removeObject:cell.model];
        [self.selectedIds removeObject:cell.model.m_uid];
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

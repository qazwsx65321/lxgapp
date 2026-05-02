//
//  Ocean_GroupController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupController.h"

#import "Ocean_GroupModel.h"
#import "Ocean_GroupCell.h"
#import "Ocean_ContactChoiceController.h"
#import "Ocean_ConversationController.h"

@interface Ocean_GroupController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *infoArray;


@end

@implementation Ocean_GroupController

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
    
    
    self.title = @"群组";
    
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(createClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    
    [self GetGroupList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNoti) name:@"AddGroupSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNoti) name:@"QuitGroupSuccess" object:nil];
    
    [self.view addSubview:self.tableView];
    
}

- (void)reloadNoti {
    
    [self GetGroupList];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createClick {
    Ocean_ContactChoiceController *contactVC = [[Ocean_ContactChoiceController alloc] init];
    contactVC.isQunZu = YES;
    [self.navigationController pushViewController:contactVC animated:YES];
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
    Ocean_GroupCell *cell = [Ocean_GroupCell cellWithTableView:tableView];
    cell.model = self.infoArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Ocean_GroupModel *model = self.infoArray[indexPath.row];
    
    Ocean_ConversationController *controller = [[Ocean_ConversationController alloc] init];
    controller.conversationType = ConversationType_GROUP;
    controller.targetId = model.m_qid;
    controller.title = model.m_name;
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)GetGroupList {
    MJWeakSelf;
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    self.infoArray = [NSArray array];
    [self.tableView reloadData];
    [self.tableView hideBlankPageView];
    [self.tableView hideErrorPageView];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[Ocean_UserInfo sharedOcean_UserInfo].m_uid,@"m_uid",
                         [Ocean_UserInfo sharedOcean_UserInfo].m_session,@"m_session",
                         @"0",@"m_type",nil];
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"GETGROUPLIST" completion:^(id respInfo, NSError *error) {
        
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                Ocean_GroupHead *head = [Ocean_GroupHead mj_objectWithKeyValues:respInfo];
                
                
                for (int i = 0; i < head.m_myfriends.count; i ++) {
                    Ocean_GroupModel *model0 = head.m_myfriends[i];
                    
                    NSArray *result = J_Select(Ocean_GroupModel).Where([NSString stringWithFormat:@"m_qid = '%@'",model0.m_qid]).list;
                    
                    if (result.count == 0) {
                        J_Insert(model0).updateResult;
                    }
                    
                    
                    
                }
                
                weakSelf.infoArray = head.m_myfriends;
                
            }else{
                [weakSelf.tableView showBlankPageView:respInfo[@"ERRORDESTRIPTION"] andImageName:@"commentEmpty"];
            }
        }else{
            [weakSelf.tableView showErrorPageView];
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

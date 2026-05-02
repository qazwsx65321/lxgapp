//
//  Ocean_ContactsController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ContactsController.h"

#import "Ocean_ContactsCell.h"
#import "Ocean_ContactCell.h"
#import "Ocean_FriendsModel.h"
#import "Ocean_ContactChoiceController.h"

#import "Ocean_FriendsInfoController.h"

#import "Ocean_GroupController.h"

#import "Ocean_LocalAddressController.h"

@interface Ocean_ContactsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *infoArray;

@end

@implementation Ocean_ContactsController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height-104-49) style:UITableViewStylePlain];
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
    
    self.view.frame = CGRectMake(0, 104, screen_Width, screen_Height - 104 -49);
    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
//    [self GET_GetFriendsInterface];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti) name:@"DeleteFriendSuccess" object:nil];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
//    button.frame = CGRectMake(self.view.width - 100, self.view.height - 184 - 49, 80, 80);
//    [button addTarget:self action:@selector(addContact) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    
    [self GET_GetFriendsInterface];
    
}

- (void)noti {
    [self GET_GetFriendsInterface];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!QSisCan) {
        return  section==0?0:self.infoArray.count;
    }
    return section == 0 ? 3 : self.infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row != 1) {
            Ocean_ContactsCell *cell = [Ocean_ContactsCell cellWithTableView:tableView];
            cell.type = indexPath.row;
            return cell;
        }else {
            return [UITableViewCell new];
        }
        
        
    }else {
        Ocean_ContactCell *cell = [Ocean_ContactCell cellWithTableView:tableView];
        cell.isTongXun = YES;
        cell.model = self.infoArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            Ocean_LocalAddressController *localVC = [[Ocean_LocalAddressController alloc] init];
            [self.selfNav pushViewController:localVC animated:YES];
        }else if (indexPath.row == 2) {
            Ocean_GroupController *groupVC = [[Ocean_GroupController alloc] init];
            [self.selfNav pushViewController:groupVC animated:YES];
        }
        
    }else {
        
        Ocean_ContactCell *cell = (Ocean_ContactCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        Ocean_FriendsInfoController *friendVC = [[Ocean_FriendsInfoController alloc] init];
        friendVC.friendid = cell.model.m_uid;
        [self.selfNav pushViewController:friendVC animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 0;
    }else {
        return 61;
    }
    
    
}


//- (void)addContact
//{
//    Ocean_ContactChoiceController *contactVC = [[Ocean_ContactChoiceController alloc] init];
//    [self.selfNav pushViewController:contactVC animated:YES];
//}

- (void)GET_GetFriendsInterface {
    
    
    MJWeakSelf;
    
    weakSelf.infoArray = [NSArray array];
    
    [HttpRequestTools requestUserInfoWithData:nil methodName:@"GETFRIENDS" completion:^(id respInfo, NSError *error) {
         
         if (!error) {
             
             Ocean_FriendsHead *head = [Ocean_FriendsHead mj_objectWithKeyValues:respInfo];
             
             if ([head.ERRORCODE isEqualToString:@"0000"]) {
                 
                 weakSelf.infoArray = head.m_myfriends;
                 
                 
                 for (int i = 0; i < head.m_myfriends.count; i ++) {
                     Ocean_FriendsModel *model0 = head.m_myfriends[i];
                     
                     NSArray *result = J_Select(Ocean_FriendsModel).Where([NSString stringWithFormat:@"m_uid = '%@'",model0.m_uid]).list;
                     
                     if (result.count == 0) {
                         J_Insert(model0).updateResult;
                     }
                 }

                 
                 
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

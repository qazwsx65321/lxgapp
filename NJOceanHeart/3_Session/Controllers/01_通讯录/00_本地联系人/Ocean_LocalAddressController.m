//
//  Ocean_LocalAddressController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/20.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_LocalAddressController.h"

#import "Ocean_SearchFriendCell.h"
#import "Ocean_SearchModel.h"
#import "Ocean_FriendsInfoController.h"




#import "ContactModel.h"
#import "ChineseString.h"
#import <Contacts/Contacts.h>
//#import "ContactInfoViewController.h"
#import "UIImage+FTImageToolBox.h"
#import "GetContact.h"
//#import "ContactCell.h"
#import "matchAddressModel.h"
#import "SharTransverterConnect.h"
//#import "shareConditionController.h"

@interface Ocean_LocalAddressController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

{
    UISearchBar *searchView;
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *infoArray;

@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *sortedList;

@property (strong, nonatomic) NSMutableArray *searchList;
@property (strong, nonatomic) NSMutableArray *indexArray;
@property (strong, nonatomic) NSMutableArray *letters;

@end

@implementation Ocean_LocalAddressController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.searchController.searchBar.hidden = YES;
    [self.searchController.searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getAddressList];
}

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
    
    self.definesPresentationContext = YES;
    
    
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    _searchController.searchBar.placeholder = @"搜索联系人";
    
    self.title = @"本地联系人";
    
//    UIButton *nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    nextStep.size = CGSizeMake(52, 20);
//    
//    [nextStep setTitle:@"下一步" forState:0];
//    
//    nextStep.titleLabel.font = [UIFont systemFontOfSize:14];
//    
//    [nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:nextStep];
    
    
    UIImage* searchBarBg = [UIImage getImageWithColor:[UIColor lightlightGrayColor] andHeight:32.0];
    [_searchController.searchBar setBackgroundImage:searchBarBg];
    [_searchController.searchBar setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightlightGrayColor];
    
    
    [self.view addSubview:self.tableView];
    
}




-(void)getAddressList{
    
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //本地获取联系人
        
        NSArray *locationArr;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            locationArr = [GetContact getNativeContactPrevIOS10];
        } else {
            locationArr = [GetContact getNativeContact];
        }
        
        
        NSMutableArray *mutal = [NSMutableArray array];
        
        NSMutableArray *nameArr = [NSMutableArray array];
        
        for (ContactModel *tempContact in locationArr) {
            
            if (tempContact.name ==nil || tempContact.phone ==nil) {
                continue;
            }
            [mutal addObject:tempContact.phone];
            [nameArr addObject:tempContact.name];
        }
        
        //            //测试
        //
        //            [mutal removeAllObjects];
        //            [mutal addObject:@{@"username":@"郑中友",@"usernumber":@"15850792447"}];
        //            [mutal addObject:@{@"username":@"邱石",@"usernumber":@"18512547302"}];
        //            [mutal addObject:@{@"username":@"邱石",@"usernumber":@"18512547302"}];
        //            [mutal addObject:@{@"username":@"邱实在",@"usernumber":@"17626049428"}];
        //            [mutal addObject:@{@"username":@"邱实在",@"usernumber":@"17626049428"}];
        //            [mutal addObject:@{@"username":@"邱实在",@"usernumber":@"17626049428"}];
        //
        //            //测试
        
        
        
        NSDictionary *dic = @{
                              @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                              @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                              @"m_phones":mutal
                              };
        
        
        [HttpRequestTools requestUserInfoWithData:dic methodName:@"GETMAILLIST" completion:^(NSDictionary * respInfo, NSError *error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0001"]) {
                //数据格式错误
                
                
            }else if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]){
                //正确获取数据
                
                NSArray *arr = [matchAddressModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_phonelist"]] ;
                
                NSMutableArray * tempArr = [NSMutableArray array];
                
                for (int i = 0; i<arr.count; i++) {
                    matchAddressModel *model = arr[i];
                    
                    for (int j = 0; j < mutal.count; j ++) {
                        if ([model.m_phone isEqualToString:mutal[j]]) {
                            Ocean_SearchModel *mode = [[Ocean_SearchModel alloc] init];
                            mode.m_uid = model.m_uid;
                            mode.m_phone = model.m_phone;
                            mode.m_nickname = nameArr[j];
                            mode.m_token = @"";
                            mode.m_headpic = model.m_touxiang;
                            mode.m_isfriend = model.m_type;
                            [tempArr addObject:mode];
                        }
                    }
                    
                    
                    
                }
                
                [self clearUpData:tempArr];
                //获取完通讯录数据后整理通讯录
            }else{
                //数据错误or异常
                
            }
            
//            [MBProgressHUD hideHUDForView:self.view];
            
        }];
    
    });
    
    
    
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}


-(void)clearUpData:(NSArray *)tempArr{
    
    _dataList = [SharTransverterConnect AddressModelTransConnect:tempArr];
    
    self.indexArray = [ChineseString IndexArray:_dataList];
    self.letters = [ChineseString LetterSortArray:_dataList];
    NSMutableArray *mutalArr = [NSMutableArray array];
    for (int i = 0; i<self.letters.count; i++) {
        NSArray *ltterArr = self.letters[i];
        [mutalArr addObjectsFromArray:ltterArr];
    }
    self.dataList = mutalArr;
    self.searchController.searchBar.hidden = NO;
    [self.tableView reloadData];
    
    
}


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    for(id sousuo in [searchBar subviews])
    {
        for (id zz in [sousuo subviews])
        {
            if([zz isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton *)zz;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark - table view delegate and data source method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.searchController.active) {
        return 1  ;
    } else {
        return _indexArray.count;;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return _searchList.count  ;
    }else{
        return [self.letters[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Ocean_SearchFriendCell *cell = [Ocean_SearchFriendCell cellWithTableView:tableView];
    
    if (self.searchController.active) {
        cell.contactmodel = _searchList[indexPath.row];
    }else {
        cell.contactmodel = self.letters[indexPath.section][indexPath.row];
    }
    
    
    
    
//    if (self.searchController.active) {
//
//    } else {
//        NSArray *contacts = _letters[indexPath.section];
//        cell.contact = contacts[indexPath.row];
//    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.searchController.active) {
        return nil;
    } else {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 20, 20)];
        lab.backgroundColor = [UIColor lightlightGrayColor];
        lab.text = [NSString stringWithFormat:@"    %@", [_indexArray objectAtIndex:section]];
        lab.textColor = [UIColor grayColor];
        lab.font = [UIFont systemFontOfSize:10];
        return lab;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.searchController.active) {
        return 0;
    } else {
        return 20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.searchController.active) {
        
    }else {
        ContactModel *model = self.letters[indexPath.section][indexPath.row];
        
        if (![model.type isEqualToString:@"0"]) {
            Ocean_FriendsInfoController *friendVC = [[Ocean_FriendsInfoController alloc] init];
            friendVC.friendid = model.uid;
            [self.navigationController pushViewController:friendVC animated:YES];
        }
    }
    
    
}

#pragma mark - search delegate method
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    UIButton *canceLBtn = [_searchController.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    self.searchList= [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:preicate]];
    [self.tableView reloadData];
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

//
//  GoodListViewController.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodListViewController.h"
#import "GoodListBody.h"
#import "PresaleListCell.h"
#import "GoodDetailViewController.h"
#import "GoodSortCell.h"
#import "GoodListCell.h"
#import "SearchBody.h"
#import "Ocean_MainforceCommodityController.h"
@interface GoodListViewController ()<GoodSortDelegate>

@property (nonatomic, strong)NSArray *list;
@property (nonatomic, strong)NSArray *searchList;

@end

@implementation GoodListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        [self getGoodListWithFlag:@"0"];
//        [self getSearchGoodWithFlag:@"0"];
    
    if (!self.title) {
        self.title = @"商品列表";
    }
    
    self.tableView.backgroundColor = [UIColor lightlightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _list.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        GoodSortCell *cell = [GoodSortCell cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    } else {
        GoodListCell *cell = [GoodListCell cellWithTableView:tableView];
            GoodListModel *good = _list[indexPath.row-1];
            cell.good = good;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        Ocean_MainforceCommodityController *controller = [[Ocean_MainforceCommodityController alloc] init];

    GoodListModel *model = _list[indexPath.row -1];;
    controller.m_gid = model.m_gid;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    } else {
        return 80;
    }
}

- (void)getGoodListWithFlag:(NSString *)flag
{
    
    
    NSDictionary *postDic = @{
                              @"m_sign":self.type,
                              @"m_cid":self.classId,
                              @"m_flag":flag
                              };
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:postDic methodName:@"GOODSSHOW" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            GoodListRespBody *respBody = [GoodListRespBody mj_objectWithKeyValues:respInfo];
            
            if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
                
                _list = respBody.m_goodslist;
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.tableView reloadData];
    }];
    
    
    
    
//    GoodListReqBody *reqBody = [GoodListReqBody new];
//    reqBody.JUDGEMETHOD = @"YIKAOLAMART-GOODSINFO";
//    reqBody.m_classifyid = self.classId;
//    reqBody.m_sign = @"2";
//    reqBody.m_flag = flag;
//    [HessianRequest requestWithData:[reqBody mj_keyValues] completion:^(id respInfo, NSError *error) {
//        if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
//            _list = respBody.CLASSIFYGOODSINFO;
//            [self.tableView reloadData];
//        } else {
//            [MBProgressHUD showTip:respBody.ERRORDESTRIPTION];
//        }
//    }];
}

- (void)didSelectSegmentAtIndex:(GoodSortType)sortType increase:(BOOL)increase
{
        [self getGoodListWithFlag:[NSString stringWithFormat:@"%zd", sortType * 2 + increase - 1]];
}

- (void)getSearchGoodWithFlag:(NSString *)flag
{
    
    
    
    
    
//    SearchReqBody *reqBody = [SearchReqBody new];
//    reqBody.JUDGEMETHOD = @"GETHOTSEARCH-GOODSINFOLIST";
//    reqBody.m_content = _keyword;
//    reqBody.m_flag = flag;
//    [HessianRequest requestWithData:[reqBody mj_keyValues] completion:^(id respInfo, NSError *error) {
//        SearchRespBody *respBody = [SearchRespBody mj_objectWithKeyValues:respInfo];
//        if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
//            _searchList = respBody.GOODSINFO;
//            [self.tableView reloadData];
//        } else {
//            [MBProgressHUD showTip:respBody.ERRORDESTRIPTION];
//        }
//    }];
}

@end

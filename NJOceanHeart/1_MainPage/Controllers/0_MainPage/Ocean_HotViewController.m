//
//  GoodListViewController.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "Ocean_HotViewController.h"
#import "GoodListBody.h"
#import "PresaleListCell.h"
#import "GoodDetailViewController.h"
#import "Ocean_HotListCell.h"
#import "SearchBody.h"
#import "Ocean_MainforceCommodityController.h"
#import "Ocean_HotGoodsModel.h"
@interface Ocean_HotViewController ()

@property (nonatomic, strong)NSArray *list;

@end

@implementation Ocean_HotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getGoodListWithFlag:@"0"];
    //        [self getSearchGoodWithFlag:@"0"];
    self.title = @"热门商品";
    self.tableView.backgroundColor = [UIColor lightlightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[Ocean_HotListCell class] forCellReuseIdentifier:@"Ocean_HotListCell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        Ocean_HotListCell *cell = [Ocean_HotListCell cellWithTableView:tableView];
        Ocean_HotGoodsModel *good = _list[indexPath.row];
        cell.good = good;
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_MainforceCommodityController *controller = [[Ocean_MainforceCommodityController alloc] init];
    
    Ocean_HotGoodsModel *model = _list[indexPath.row];;
    controller.m_gid = model.m_gbid;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_HotGoodsModel *model = _list[indexPath.row];;
        return [tableView fd_heightForCellWithIdentifier:@"Ocean_HotListCell" cacheByIndexPath:indexPath configuration:^(Ocean_HotListCell *cell)
                {
                    cell.good = model;
                }];

}
- (void)getGoodListWithFlag:(NSString *)flag
{
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInWindow:@""];
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"FIRSTPAGESHOWMORE" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {

                weakSelf.list = [Ocean_HotGoodsModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_goodslist3"]];
                for (Ocean_HotGoodsModel *model in weakSelf.list) {
                    [model judgeObjectPropertyNull];
                }
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.tableView reloadData];
    }];
    
}


@end

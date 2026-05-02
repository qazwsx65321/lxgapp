//
//  Ocean_OrderDetailController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_OrderDetailController.h"

#import "Ocean_StoreModel.h"
#import "Ocean_OrderDetailCell.h"
#import "Ocean_OrderDetailModel.h"
#import "Ocean_storeCell.h"
#import "Ocean_WuliuWebController.h"
#import "Ocean_MainforceCommodityController.h"
#import "Ocean_MainStoreController.h"

@interface OrderDetailHeadView  : UITableViewHeaderFooterView


@end

@implementation OrderDetailHeadView



@end

@interface Ocean_OrderDetailController ()<UITableViewDelegate,UITableViewDataSource,Ocean_OrderDetailBodyCellDelegate,Ocean_OrderDetailFootCellDelegate>

{
    NSString *bulidTime;
    Ocean_OrderDetailHead *headModel;
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) Ocean_OrderDetailFrame *cellframe;
@property (nonatomic,strong) NSMutableArray *infoArray;

@end

@implementation Ocean_OrderDetailController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
    [self GET_OrderDetail];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[OrderDetailHeadView class] forHeaderFooterViewReuseIdentifier:@"OrderDetailHeadView"];
    
    MJWeakSelf;
    [self.tableView configReloadAction:^{
        
        [weakSelf GET_OrderDetail];
        
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : self.infoArray.count+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 6;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Ocean_OrderDetailCell *cell = [Ocean_OrderDetailCell cellWithTableView:tableView];
        cell.cellFrame = self.cellframe;
        cell.state = self.storeModel.m_state;
        return cell;
    }else {
        
        if (indexPath.row == 0) {
            Ocean_StoreHeadCell  *headcell = [Ocean_StoreHeadCell cellWithTableView:tableView];
            headcell.isHideState = YES;
            headcell.orderModel = self.storeModel;
            return headcell;
        }else if (indexPath.row == (self.infoArray.count+1)) {
            
            Ocean_OrderDetailFootCell  *footcell = [Ocean_OrderDetailFootCell cellWithTableView:tableView];
            footcell.total = [NSString stringWithFormat:@"共%zd件商品 合计:%@元(含运费0.0元)",self.infoArray.count,self.storeModel.m_fee];
            footcell.time = bulidTime;
            footcell.orderno = self.storeModel.m_orderno;
            footcell.model = headModel;
            footcell.delegate = self;
            return footcell;
            
        }else {
            Ocean_OrderDetailBodyCell  *bodycell = [Ocean_OrderDetailBodyCell cellWithTableView:tableView];
            bodycell.delegate = self;
            bodycell.cellFrame = self.infoArray[indexPath.row - 1];
            return bodycell;
        }
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailHeadView"];
    headView.backgroundColor = RGB(250, 246, 254);
    return headView;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            Ocean_MainStoreController *shopVC = [[Ocean_MainStoreController alloc] init];
            shopInfoModel *model = [shopInfoModel new];
            model.m_gbid = self.storeModel.m_bid;
            shopVC.m_shopInfo = model;
            [self.navigationController pushViewController:shopVC animated:YES];
        }else if (indexPath.row == (self.infoArray.count+1)) {
            
        }else {
            Ocean_MainforceCommodityController *forceVC = [[Ocean_MainforceCommodityController alloc] init];
            Ocean_OrderDetailBodyFrame *frameModel = self.infoArray[indexPath.row - 1];
            forceVC.m_gid = frameModel.model.m_goodsid;
            [self.navigationController pushViewController:forceVC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        return !self.cellframe ? 0.00 : self.cellframe.cellHeight;
        
    }else {
        
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == (self.infoArray.count+1)) {
            return 160;
        }else {
            Ocean_OrderDetailBodyFrame *cellframe = self.infoArray[indexPath.row - 1];
            return cellframe.cellHeight;
        }
        
        return 0;
        
    }
}

- (void)didQuitClick:(Ocean_OrderDetailBodyCell *)cell {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否申请退款?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self AfterMoneyCancelInterfaceWithOrderno:cell.cellFrame.model];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}



- (void)lookWuliu:(Ocean_OrderDetailFootCell *)cell {
    //测试
    cell.model.m_expressnumber = @"449023708483";
    //测试
    NSString *url = [NSString stringWithFormat:@"https://m.kuaidi100.com/index_all.html?type=%@&postid=%@",cell.model.m_expressname,cell.model.m_expressnumber];
    
    
    Ocean_WuliuWebController *wuliuVC = [[Ocean_WuliuWebController alloc] init];
    wuliuVC.urlStr = url;
    [self.navigationController pushViewController:wuliuVC animated:YES];
    
    
}


- (void)GET_OrderDetail {
    MJWeakSelf;
    [self.tableView reloadData];
    [self.tableView hideBlankPageView];
    [self.tableView hideErrorPageView];
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_orderno":self.storeModel.m_orderno
                          };
    
    self.cellframe = [[Ocean_OrderDetailFrame alloc] init];
    self.infoArray = [NSMutableArray array];
    
    headModel = [[Ocean_OrderDetailHead alloc] init];
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"ORDERDETAIL" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                Ocean_OrderDetailHead *head = [Ocean_OrderDetailHead mj_objectWithKeyValues:respInfo];
                [head judgeObjectPropertyNull];
                self.cellframe.model = head;
                bulidTime = head.m_buildtime;
                headModel = head;
                
                NSMutableArray *arr = [NSMutableArray array];
                for (int i = 0; i < head.m_goodslist.count; i ++) {
                    Ocean_StoreCommodityModel *m = self.storeModel.GOODINFO[i];
                    Ocean_OrderDetailModel *model = head.m_goodslist[i];
                    model.m_price = m.m_price;
                    model.m_orderno3 = m.m_orderno3;
                    [arr addObject:model];
                }
                
                head.m_goodslist = [arr mutableCopy];
                
                for (Ocean_OrderDetailModel *model in head.m_goodslist) {
                    model.m_state = head.m_state;
                    Ocean_OrderDetailBodyFrame *frames = [[Ocean_OrderDetailBodyFrame alloc] init];
                    frames.model = model;
                    [self.infoArray addObject:frames];
                }
                
            }else {
                [weakSelf.tableView showBlankPageView:respInfo[@"ERRORDESTRIPTION"] andImageName:@"commentEmpty"];
            }
            
        }else {
            [weakSelf.tableView showErrorPageView];
        }
        
        [weakSelf.tableView reloadData];
    }];
    
}



//退款
- (void)AfterMoneyCancelInterfaceWithOrderno:(Ocean_OrderDetailModel *)model {
    
    MJWeakSelf;
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_orderno":self.storeModel.m_orderno,
                          @"m_orderno3":model.m_orderno3
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"AFTERMONEYCANCEL" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
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

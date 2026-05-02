//
//  Ocean_CancelOrderController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_CancelOrderController.h"
#import "Ocean_StoreModel.h"
#import "Ocean_StoreCell.h"
#import "Ocean_OrderDetailController.h"
@interface orderCancelHeadView: UITableViewHeaderFooterView

@end

@implementation orderCancelHeadView

@end

@interface Ocean_CancelOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray * p_orderInfoArr;

@end

@implementation Ocean_CancelOrderController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"换货";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.tableView];
    [self ORDERLISTBYSTATE];
    
    [self.tableView registerClass:[orderCancelHeadView class] forHeaderFooterViewReuseIdentifier:@"orderCancelHeadView"];
    MJWeakSelf;
    [self.tableView configReloadAction:^{
        
        [weakSelf ORDERLISTBYSTATE];
        
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.p_orderInfoArr.count;;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[section];
    NSInteger rownum = OrderModelFram.bodyFramArr.count;
    rownum +=2;
    return rownum;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[indexPath.section];
    NSArray *rowArrFrame = OrderModelFram.bodyFramArr;
    if (indexPath.row==0) {
        Ocean_StoreHeadCell  *headcell = [Ocean_StoreHeadCell cellWithTableView:tableView];
        headcell.orderModel = OrderModelFram.model;
        return headcell;
    }else if (indexPath.row ==(rowArrFrame.count+1)){
        Ocean_StoreFootCell *footcell = [Ocean_StoreFootCell cellWithTableView:tableView];
        footcell.cellFrame = OrderModelFram;
        return footcell;
    }else{
        Ocean_StoreBodyCell *bodyCell = [Ocean_StoreBodyCell cellWithTableView:tableView];
        bodyCell.cellFrame = rowArrFrame[indexPath.row -1];
        return bodyCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[indexPath.section];
    
    if (indexPath.row==0) {
        return 40;
    }else if (indexPath.row ==(OrderModelFram.bodyFramArr.count+1)){
        return OrderModelFram.cellHeight;
    }else{
        Ocean_StoreBodyFrame *bodyFrame = OrderModelFram.bodyFramArr[indexPath.row -1];
        return bodyFrame.cellHeight;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Ocean_OrderDetailController *detailVC = [[Ocean_OrderDetailController alloc] init];
    Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[indexPath.section];
    detailVC.storeModel = OrderModelFram.model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [tableView dequeueReusableCellWithIdentifier:@"orderCancelHeadView"];
    headView.backgroundColor = RGB(250, 246, 254);
    return headView;
    
}


-(void)ORDERLISTBYSTATE{
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInWindow:nil];
    self.p_orderInfoArr = nil;
    [self.tableView reloadData];
    [self.tableView hideBlankPageView];
    [self.tableView hideErrorPageView];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[Ocean_UserInfo sharedOcean_UserInfo].m_uid,@"m_uid",
                         [Ocean_UserInfo sharedOcean_UserInfo].m_session,@"m_session",
                         @"6",@"m_state",nil];
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"ORDERLISTBYSTATE" completion:^(id respInfo, NSError *error) {
        
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                NSArray *orderArr  =[Ocean_StoreOrderModel mj_objectArrayWithKeyValuesArray:respInfo[@"ORDERSLIST"]];
                NSMutableArray *orderFarmeArr = [NSMutableArray array];
                for (Ocean_StoreOrderModel *orderModel in orderArr) {
                    Ocean_StoreFootFrame *fram = [Ocean_StoreFootFrame new];
                    fram.model = orderModel;
                    [orderFarmeArr addObject:fram];
                }
                weakSelf.p_orderInfoArr = orderFarmeArr;
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

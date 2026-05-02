//
//  Ocean_OrderController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_OrderController.h"
#import "XHSegmentControl.h"
#import "Ocean_StoreModel.h"
#import "Ocean_StoreCell.h"
#import "Ocean_OrderDetailController.h"
#import "Ocean_OrderEvaluteController.h"
#import "Ocean_PayGoodsController.h"
#import "Ocean_WuliuWebController.h"
#import "Ocean_MainStoreController.h"

@interface orderHeadView  : UITableViewHeaderFooterView

@end

@implementation orderHeadView



@end

@interface Ocean_OrderController ()<XHSegmentControlDelegate,UITableViewDelegate,UITableViewDataSource,Ocean_StoreFootCellDelegate>
{
    NSString *p_state;
    BOOL isControl;

}

@property (nonatomic,strong) XHSegmentControl * p_sectionView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * p_orderInfoArr;
@end

@implementation Ocean_OrderController

-(XHSegmentControl *)p_sectionView{
    if (!_p_sectionView) {
        //20220406，适配大屏幕手机
        //CGFloat XHY =  screen_Height==812 ?88:64;
        CGFloat XHY =  screen_Height>=812 ?88:64;
        
        XHSegmentControl *segmentedControl = [[XHSegmentControl alloc]initWithFrame:CGRectMake(0,XHY, screen_Width, 40)];
        segmentedControl.titles = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
        segmentedControl.titleColor = [UIColor blackColor];
        segmentedControl.segmentType = 0;
        segmentedControl.delegate =self;
        _p_sectionView = segmentedControl;

    }
    
    return _p_sectionView;
}
- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation{
    if (!isControl) {
        isControl = YES;
        return;
    }
    NSString *state = @"";
    if (index) {
        state = [NSString stringWithFormat:@"%ld",index -1];
    }
    [self ORDERLISTBYSTATE:state];

}


- (UITableView *)tableView {
    if (!_tableView) {
        
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.p_sectionView.bottom, screen_Width, screen_Height- self.p_sectionView.bottom) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"我的订单";
    [self.view addSubview:self.p_sectionView];
    [self.p_sectionView load];
    if (_index.length) {
        self.p_sectionView.selectIndex = [_index integerValue]+1;
    }else{
        self.p_sectionView.selectIndex = 0;

    }
    
    [self.view addSubview:self.tableView];
    p_state = @"";
    [self.tableView registerClass:[orderHeadView class] forHeaderFooterViewReuseIdentifier:@"orderHeadview"];
    MJWeakSelf;
    [self.tableView configReloadAction:^{
        
        [weakSelf ORDERLISTBYSTATE:p_state];
        
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"CZWPayfinish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"EvaluteSuccess" object:nil];
  
}
-(void)reloadData{

    [self ORDERLISTBYSTATE:p_state];


}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.p_orderInfoArr.count;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 6;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [tableView dequeueReusableCellWithIdentifier:@"orderHeadview"];
    headView.backgroundColor = RGB(250, 246, 254);
    return headView;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[section];
    NSInteger rownum = OrderModelFram.bodyFramArr.count;
    rownum +=2;
    return rownum;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[indexPath.section];
    NSArray *rowArrFrame = OrderModelFram.bodyFramArr;
    if (indexPath.row==0) {
        Ocean_StoreHeadCell  *headcell = [Ocean_StoreHeadCell cellWithTableView:tableView];
        headcell.orderModel = OrderModelFram.model;
        return headcell;
    }else if (indexPath.row ==(rowArrFrame.count+1)){
        Ocean_StoreFootCell *footcell = [Ocean_StoreFootCell cellWithTableView:tableView];
        footcell.delegate = self;
        footcell.cellFrame = OrderModelFram;
        return footcell;
    }else{
        Ocean_StoreBodyCell *bodyCell = [Ocean_StoreBodyCell cellWithTableView:tableView];
        bodyCell.cellFrame = rowArrFrame[indexPath.row -1];
        return bodyCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[indexPath.section];
    NSArray *rowArrFrame = OrderModelFram.bodyFramArr;
    if (indexPath.row == 0) {
        Ocean_MainStoreController *shopVC = [[Ocean_MainStoreController alloc] init];
        shopInfoModel *model = [shopInfoModel new];
        model.m_gbid = OrderModelFram.model.m_bid;
        shopVC.m_shopInfo = model;
        [self.navigationController pushViewController:shopVC animated:YES];
        
    }else if (indexPath.row ==(rowArrFrame.count+1)) {
        
    }else {
        Ocean_OrderDetailController *detailVC = [[Ocean_OrderDetailController alloc] init];
        Ocean_StoreFootFrame *OrderModelFram = self.p_orderInfoArr[indexPath.section];
        detailVC.storeModel = OrderModelFram.model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


- (void)didCancelClickCell:(Ocean_StoreFootCell *)cell {
    
    
    if ([@"0" isEqualToString:cell.cellFrame.model.m_state]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消订单?" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self BeforMoneyCancelInterfaceWithSign:@"0" withOrderno:cell.cellFrame.model];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        
        if ([@"2" isEqualToString:cell.cellFrame.model.m_isfee]) {
            //测试
            cell.cellFrame.model.m_expressnumber = @"449023708483";
            //测试
            NSString *url = [NSString stringWithFormat:@"https://m.kuaidi100.com/index_all.html?type=%@&postid=%@",cell.cellFrame.model.m_expressname,cell.cellFrame.model.m_expressnumber];
            
            Ocean_WuliuWebController *wuliuVC = [[Ocean_WuliuWebController alloc] init];
            wuliuVC.urlStr = url;
            [self.navigationController pushViewController:wuliuVC animated:YES];
        }
        
    }
    
    
}


//付款
- (void)didPayMoneyClickCell:(Ocean_StoreFootCell *)cell {
   
    Ocean_PayGoodsController *payVC = [[Ocean_PayGoodsController alloc] init];
    payVC.userName = @"十号葫芦娃";
    payVC.orderno = cell.cellFrame.model.m_orderno;//￥
    payVC.payPrice = [NSString stringWithFormat:@"￥%@",cell.cellFrame.model.m_fee];
    [self.navigationController pushViewController:payVC animated:YES];
    
}

- (void)didQuitGetGoodsClickCell:(Ocean_StoreFootCell *)cell {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否申请退款?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self BeforMoneyCancelInterfaceWithSign:@"1" withOrderno:cell.cellFrame.model];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didSureGetGoodsClickCell:(Ocean_StoreFootCell *)cell {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认收货?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self AfterMoneyConfirmInterfaceWithOrderno:cell.cellFrame.model.m_orderno];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didEvaluateClickCell:(Ocean_StoreFootCell *)cell {
    Ocean_OrderEvaluteController *evaluteVC = [[Ocean_OrderEvaluteController alloc] init];
    evaluteVC.goodsArray = cell.cellFrame.model.GOODINFO;
    evaluteVC.myOrderno = cell.cellFrame.model.m_orderno;
    [self.navigationController pushViewController:evaluteVC animated:YES];
}



-(void)ORDERLISTBYSTATE:(NSString *)state{
    p_state = state;
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInWindow:nil];
    self.p_orderInfoArr = [NSMutableArray array];
    [self.tableView reloadData];
    [self.tableView hideBlankPageView];
    [self.tableView hideErrorPageView];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[Ocean_UserInfo sharedOcean_UserInfo].m_uid,@"m_uid",
                         [Ocean_UserInfo sharedOcean_UserInfo].m_session,@"m_session",
                         state,@"m_state",nil];
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


//取消订单
- (void)BeforMoneyCancelInterfaceWithSign:(NSString *)sign withOrderno:(Ocean_StoreOrderModel *)model {
    
    MJWeakSelf;
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_sign":sign,
                          @"m_orderno":model.m_orderno
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"BEFORMONEYCANCEL" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                
                [weakSelf ORDERLISTBYSTATE:p_state];
                
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        
        [weakSelf.tableView reloadData];
        
    }];
    
}


//确认收货
- (void)AfterMoneyConfirmInterfaceWithOrderno:(NSString *)orderno {
    
    MJWeakSelf;
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_orderno":orderno
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"AFTERMONEYCONFIRM" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                [weakSelf ORDERLISTBYSTATE:p_state];

            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        
        [weakSelf.tableView reloadData];
        
    }];
    
}


@end

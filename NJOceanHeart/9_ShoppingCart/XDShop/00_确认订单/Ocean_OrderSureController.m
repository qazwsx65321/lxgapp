//
//  Ocean_OrderSureController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_OrderSureController.h"

#import "Ocean_ ShowCartModel.h"
#import "Ocean_ShopAddressCell.h"
#import "Ocean_AddressModel.h"
#import "Ocean_AddressListController.h"
#import "Ocean_StoreModel.h"
#import "Ocean_StoreCell.h"
#import "Ocean_PayGoodsController.h"

@interface OrderSureHeadView  : UITableViewHeaderFooterView


@end

@implementation OrderSureHeadView



@end

@interface Ocean_OrderSureController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger goodsNum;
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *addressArray;

@property (nonatomic,strong) NSMutableArray *listrray;

@property (nonatomic,strong) NSMutableArray *canshuArray;

@end

@implementation Ocean_OrderSureController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height-52) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    

    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
    [self GET_OrderGetdefaultAddess];
    
    
    [self initData];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"ChangeModel" object:nil];
    
    [self.tableView registerClass:[OrderSureHeadView class] forHeaderFooterViewReuseIdentifier:@"OrderSureHeadView"];
    
    [self initFootView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"CZWPayfinish" object:nil];
    
    
}


-(void)reloadData{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)noti:(NSNotification *)info {
    
    self.addressArray = [NSArray array];
    self.addressArray = @[info.object];
    
    [self.tableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listrray.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        Ocean_StoreFootFrame *OrderModelFram = self.listrray[section-1];
        NSInteger rownum = OrderModelFram.bodyFramArr.count;
        rownum +=2;
        return rownum;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        Ocean_ShopAddressCell *cell = [Ocean_ShopAddressCell cellWithTableView:tableView];
        if (self.addressArray.count) {
            cell.model = self.addressArray[0];
        }
        return cell;
    }else {
        
        
        Ocean_StoreFootFrame *OrderModelFram = self.listrray[indexPath.section-1];
        NSArray *rowArrFrame = OrderModelFram.bodyFramArr;
        if (indexPath.row == 0) {
            Ocean_StoreHeadCell *headCell = [Ocean_StoreHeadCell cellWithTableView:tableView];
            headCell.orderModel = OrderModelFram.model;
            return headCell;
        }else if (indexPath.row == rowArrFrame.count + 1) {
            Ocean_StoreFootCell *footCell = [Ocean_StoreFootCell cellWithTableView:tableView];
            footCell.cellFrame = OrderModelFram;
            footCell.goodsNum = [NSString stringWithFormat:@"%zd",goodsNum];
            return footCell;
        }else {
            Ocean_StoreBodyCell *bodyCell = [Ocean_StoreBodyCell cellWithTableView:tableView];
            bodyCell.cellFrame = rowArrFrame[indexPath.row -1];
            return bodyCell;
        }
        
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Ocean_AddressListController *addressVC = [[Ocean_AddressListController alloc] init];
        addressVC.isOrderAddress = YES;
        [self.navigationController pushViewController:addressVC animated:YES];
    }else {
        
    }
}




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        UIView *headView = [tableView dequeueReusableCellWithIdentifier:@"orderHeadview"];
        headView.backgroundColor = RGB(250, 246, 254);
        return headView;
    }else{
        return [UIView new];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }else {
        Ocean_StoreFootFrame *OrderModelFram = self.listrray[indexPath.section-1];
        
        if (indexPath.row==0) {
            return 40;
        }else if (indexPath.row ==(OrderModelFram.bodyFramArr.count+1)){
            return OrderModelFram.cellHeight;
        }else{
            Ocean_StoreBodyFrame *bodyFrame = OrderModelFram.bodyFramArr[indexPath.row -1];
            return bodyFrame.cellHeight;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else {
        return 6;
        
    }
    
}


- (void)initFootView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_Height - 50, screen_Width, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen_Width - 100/320.f*screen_Width, 50)];
    [label setAttributedText:[self setLabelTextWithText:@"实付" withChangeText:self.allPrice ? self.allPrice : @"0.00"]];
    label.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(screen_Width - 100.f/320.f*screen_Width, 0, 100/320.f*screen_Width, 50);
    button.backgroundColor = [UIColor colorWithRed:0.831 green:0.169 blue:0.196 alpha:1.000];
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
    
}

- (void)submitClick {
    
    [self ORDERSUBMIT];
    
    
}

- (NSMutableAttributedString *)setLabelTextWithText:(NSString *)text withChangeText:(NSString *)changeText {
    
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：%@",text,changeText]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:changeText].location, [[noteStr string] rangeOfString:changeText].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.847 green:0.231 blue:0.259 alpha:1.000] range:redRange];
    
    return noteStr;
    
}


//模型数据处理
- (void)initData {
    
    if (self.goodsArray.count) {
        
        NSMutableArray *shopArray = [NSMutableArray array];
        self.listrray = [NSMutableArray array];
        self.canshuArray = [NSMutableArray array];
        
        for (int i = 0; i < self.goodsArray.count; i ++) {
            Ocean__ShowCartGoodsHead *head = self.goodsArray[i];
            
            Ocean_StoreOrderModel *ordermodel = [[Ocean_StoreOrderModel alloc] init];
            ordermodel.m_logo = head.m_logo;
            ordermodel.m_bid = head.m_bid;
            ordermodel.m_bname = head.m_bname;
            
            NSMutableArray *arr = [NSMutableArray array];
            
            float price = 0.0;
            
            goodsNum = 0;
            
            for (int j = 0; j < head.m_goodslist.count; j ++) {
                Ocean__ShowCartGoodsModel *Goods = head.m_goodslist[j];
                Ocean_StoreCommodityModel *commodModel = [[Ocean_StoreCommodityModel alloc] init];
                commodModel.m_goodsid = Goods.m_gid;
                commodModel.m_dgid = Goods.m_dgid;
                commodModel.m_title = Goods.m_title;
                commodModel.m_price = Goods.m_price;
                commodModel.m_num = Goods.m_num;
                commodModel.m_pic = Goods.m_listpic;
                commodModel.m_guigename = Goods.m_guigename;
                [arr addObject:commodModel];
                
                float b = [Goods.m_price floatValue];
                float c = [Goods.m_num floatValue];
                 price += b*c;
                
                NSInteger a = [Goods.m_num integerValue];
                goodsNum += a;
                
                
                
                //放入提交订单所需的参数
                NSDictionary *dic = [NSDictionary dictionary];
                dic = @{
                        @"m_shopid":head.m_bid,
                        @"m_shopName":head.m_bname,
                        @"m_goodsid":Goods.m_gid,
                        @"m_goodsguigeid":Goods.m_dgid,
                        @"m_goodsnum":Goods.m_num,
                        @"m_cardids":Goods.m_aid
                        };
                
                
                [self.canshuArray addObject:dic];
                
                
            }
            
            ordermodel.m_fee = [NSString stringWithFormat:@"%.2f",price];
            
            ordermodel.GOODINFO = [arr mutableCopy];
            
            [shopArray addObject:ordermodel];
            
            
        }
        
        
        for (int i = 0; i < shopArray.count; i ++) {
            Ocean_StoreOrderModel *ordermodel = shopArray[i];
            Ocean_StoreFootFrame *frame = [[Ocean_StoreFootFrame alloc] init];
            frame.model = ordermodel;
            [self.listrray addObject:frame];
        }
        
        
        
        
    }
    
    
    
    
    
}



//获取地址
- (void)GET_OrderGetdefaultAddess {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session
                          };
    
    self.addressArray = [NSArray array];
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"ORDERGETDEFAULTADDRESS" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            ShopAddressBody *body = [ShopAddressBody mj_objectWithKeyValues:respInfo];
            if ([@"0000" isEqualToString:body.ERRORCODE]) {
                
                self.addressArray = body.MYADDRESS;
                
            }else {
                [MBProgressHUD showWarnMessage:body.ERRORDESTRIPTION];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        
        [self.tableView reloadData];
    }];
    
}


//提交订单
- (void)ORDERSUBMIT {
    
    if (!self.addressArray.count) {
        [MBProgressHUD showTipMessageInView:@"请输入收货地址!"];
        return;
    }
    
    ShopAddressModel *model = self.addressArray[0];
    
    MJWeakSelf;
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_psaddress":[NSString stringWithFormat:@"%@ %@ %@%@%@%@",model.m_name,model.m_telphone,model.m_pro,model.m_city,model.m_area,model.m_address],
                          @"m_allprice":[weakSelf.allPrice substringFromIndex:1],
                          @"m_goods":weakSelf.canshuArray
                          
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"ORDERSUBMIT" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                Ocean_PayGoodsController *payVC = [[Ocean_PayGoodsController alloc] init];
                payVC.userName = model.m_name;
                payVC.orderno = respInfo[@"m_orderno"];
                payVC.payPrice = weakSelf.allPrice;
                payVC.isShopStore = YES;
                [weakSelf.navigationController pushViewController:payVC animated:YES];
            }else {
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
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

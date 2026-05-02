//
//  Ocean_EnterStorePayController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_EnterStorePayController.h"
#import "XRNextPreCell.h"
#import "Ocean_ChooseTypePayCell.h"
#import "WXRPayTool.h"
@interface Ocean_EnterStorePayController ()<XRNextPreCellDelegate,Ocean_ChooseTypePayCellDelegate>
{

    NSString *Order;
    BOOL isAliPay;

}
@property (nonatomic,strong) NSArray * p_infoArr;

@end

@implementation Ocean_EnterStorePayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    
    isAliPay = YES;
    
    if (self.type ==2){
        
        self.m_bid = [Ocean_UserInfo sharedOcean_UserInfo].m_uid;
        self.m_price = [Ocean_UserInfo sharedOcean_UserInfo].m_cardPrice;
        self.m_remark = [Ocean_UserInfo sharedOcean_UserInfo].m_cardname;
        if (!self.m_price) {
            [MBProgressHUD showWarnMessage:@"暂时无法支付"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    [self Ocean_ChooseTypePayCellChoosePay:100];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payFinsh:) name:WXRPayToolFinishNotication object:nil];
    self.title = @"支付";
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view endEditing:YES];
    self.tableView.tableHeaderView = [self tableHeadView];

    if (self.type==2) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        return;

    }
    
    if (self.type ==0) {
        return;
    }
    
        UIButton *backButton =  self.navigationItem.leftBarButtonItem.customView;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored"-Wundeclared-selector"
        [backButton removeTarget:self.navigationController action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    #pragma clang diagnostic pop
        [backButton addTarget:self action:@selector(backFist1) forControlEvents:UIControlEventTouchUpInside];
    

}

-(NSString *)getAliPayOrder:(NSString *)uid andType:(NSInteger)type{
    //type:1/购卡  0/商户入驻
    NSString * order;

    if (type==0) {
        order = [NSString stringWithFormat:@"10HHLWS_%@_2",uid];
    }else{
        order = [NSString stringWithFormat:@"10HHLWC_%@_1",uid];
    }
    return order;
}

-(NSString *)getWXPayOrder:(NSString *)phone andAttch:(NSString *)uid andType:(NSInteger)type{

    NSString *order = @"";
    NSString *attach = @"";
    if (type==0) {
        order = [KX9RechargeOrderTool getRechargeorder:phone andType:@"_S"];
        attach = [NSString stringWithFormat:@"%@_2",uid];

    }else{
        order = [KX9RechargeOrderTool getRechargeorder:phone andType:@"_C"];
        attach = [NSString stringWithFormat:@"%@_1",uid];
    }
    
    return [NSString stringWithFormat:@"%@&&:&&%@",order,attach];

}


-(void)backFist1{

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}


-(void)cancel{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)payFinsh:(NSNotification *)not{
    if ([not.userInfo[@"state"] isEqualToString:@"OK"]) {
        [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:@"O" forKey:@"m_checkflag"];
        if (self.type==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if (self.type ==1){
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else if (self.type ==2){
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //即将显示隐藏progessView
    if (self.type==2)return;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"QSHideProgressView" object:@(1)];

}



-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

-(UIView *)tableHeadView{
    UIView *headVIew = [[UIView alloc]init];
    UILabel *title = [[UILabel alloc]init];
    NSString *titlestr = @"";
    if (self.type ==0) {
        titlestr = [NSString stringWithFormat:@"渠道对接费(%@)",self.m_remark];
    }else if (self.type ==1){
        titlestr =[NSString stringWithFormat:@"申请卡费(%@)",self.m_remark];
    }else if (self.type ==2){
        titlestr= [NSString stringWithFormat:@"申请卡费(%@)",self.m_remark];
    }
    title.text = titlestr;
    
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:18];
    title.frame  = CGRectMake(0, 30, screen_Width, 18);
    [headVIew addSubview:title];
    
    
    UILabel *price = [[UILabel alloc]init];
    price.text = [NSString stringWithFormat:@"¥ %@",self.m_price];
    price.textAlignment = NSTextAlignmentCenter;
    price.font = [UIFont systemFontOfSize:20];
    price.frame  = CGRectMake(0, title.bottom +15, screen_Width, 20);
    [headVIew addSubview:price];
    headVIew.size = CGSizeMake(screen_Width, price.bottom+20);
    return headVIew;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_price?4:0;

}

-(void)Ocean_ChooseTypePayCellChoosePay:(NSInteger)tag{

    if (tag ==100) {
        isAliPay = YES;
        
       Order =  [self getAliPayOrder:self.m_bid andType:self.type];
    }else{
        isAliPay = NO;
        NSString *phone = self.m_phone?self.m_phone:[Ocean_UserInfo sharedOcean_UserInfo].m_registPhone;
       Order =  [self getWXPayOrder:phone andAttch:self.m_bid  andType:self.type];
    }
    
    _p_infoArr= @[@{@"title":@"收款方",@"des":@"10号葫芦娃"},@{@"title":@"订单号",@"des":Order}];
    [self.tableView reloadData];
   

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row ==2) {
        Ocean_ChooseTypePayCell *cell = [Ocean_ChooseTypePayCell cellWithTableView:tableView];
        cell.delegate =self;
        return cell;
    }else if (indexPath.row ==3){
        XRNextPreCell *cell = [XRNextPreCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.nextTitle  =@"立即支付";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{

        NSDictionary *dic = self.p_infoArr[indexPath.row];
        NSString *cellsign = @"tableViewmessagecell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellsign];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellsign];
        }
        cell.textLabel.text = dic[@"title"];
        
        cell.detailTextLabel.text = dic[@"des"];
        
        if (!isAliPay && indexPath.row ==1) {
            NSArray *strArr = [dic[@"des"] componentsSeparatedByString:@"&&:&&"];
            cell.detailTextLabel.text = strArr[0];
        }
        
        cell.detailTextLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)clickNextbutton{
    
    
    [WXRPayTool WXRPayToPlatformOderNumber:Order andOrderPrice:self.m_price andPlat:isAliPay];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row ==2) {
        return 80;
    }else if (indexPath.row ==3){
        return 100;
    }else{
        return 60;
    }

}

@end

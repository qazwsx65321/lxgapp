//
//  Ocean_AddressAddController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AddressAddController.h"

#import "Ocean_AddressAddCell.h"
#import "Ocean_AddressAddCell0.h"
#import "Ocean_AddressAddCell1.h"
#import "ServiceLocationController.h"
#import "Ocean_AddressModel.h"
#import "XDTextView.h"
#import "ZmjPickView.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface Ocean_AddressAddController ()<UITableViewDelegate,UITableViewDataSource,SlectLocationDelegate,Ocean_AddressAddCell1Delegate,BMKGeoCodeSearchDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *phoneText;
@property (nonatomic,strong) XDTextView *textView;

@property (nonatomic,strong) ZmjPickView * p_pickerArea;
@property (nonatomic,strong) BMKGeoCodeSearch * searcher;



@end

@implementation Ocean_AddressAddController

-(ZmjPickView *)p_pickerArea{
    if (!_p_pickerArea) {
        _p_pickerArea = [[ZmjPickView alloc]init];
    }
    return _p_pickerArea;
}

- (AddAddressModel *)selfModel {
    if (!_selfModel) {
        _selfModel = [[AddAddressModel alloc] init];
        
        _selfModel.m_flag = @"0";
        _selfModel.m_addressid = @"";
    }
    return _selfModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.976 alpha:1.000];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.isEdit ? @"编辑地址" : @"添加地址";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.976 alpha:1.000];
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    saveBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    [self.view addSubview:self.tableView];
    
}

- (void)saveClick {
    
    if (!self.nameText.text.length) {
        [MBProgressHUD showWarnMessage:@"请填写收货人!"];
        return;
    }
    
    if (!self.phoneText.text.length) {
        [MBProgressHUD showWarnMessage:@"请填写联系电话!"];
        return;
    }
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@",self.selfModel.m_pro,self.selfModel.m_city,self.selfModel.m_area];
    
    if (!str.length) {
        [MBProgressHUD showWarnMessage:@"请选择地区!"];
        return;
    }
    
    if (!self.textView.XD_text.length) {
        [MBProgressHUD showWarnMessage:@"请填写详细地址!"];
        return;
    }
    
    
    self.selfModel.m_compaddress = self.textView.XD_text;
    [self BUSSINESSIN];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Ocean_AddressAddCell *cell = [Ocean_AddressAddCell cellWithTableView:tableView];
        self.nameText = cell.textFiled0;
        self.phoneText = cell.textFiled1;
        cell.model = self.selfModel;
        return cell;
    }else if (indexPath.row == 1) {
        Ocean_AddressAddCell0 *cell = [Ocean_AddressAddCell0 cellWithTableView:tableView];
        cell.model = self.selfModel;
        return cell;
    }
    else {
        Ocean_AddressAddCell1 *cell = [Ocean_AddressAddCell1 cellWithTableView:tableView];
        self.textView = cell.textView;
        cell.isEdit = self.isEdit;
        cell.model = self.selfModel;
        cell.delegate = self;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        [self.p_pickerArea show];
        MJWeakSelf;
        self.p_pickerArea.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
            
            weakSelf.selfModel.m_pro = shengName;
            weakSelf.selfModel.m_city = shiName;
            weakSelf.selfModel.m_area = xianName;
            weakSelf.selfModel.m_storeAddress = [NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName];
            [weakSelf.tableView reloadData];
            
        };
        
        
//        ServiceLocationController *locationVC = [[ServiceLocationController alloc] init];
//        locationVC.delegate = self;
//        [self.navigationController pushViewController:locationVC animated:YES];
    }
    
}

-(void)selectLocation:(CLLocationCoordinate2D)CLLocationCoordinate2D andTitle:(NSString *)title andAddress:(NSString *)address {
    
    self.selfModel.m_coordinatex = [NSString stringWithFormat:@"%f",CLLocationCoordinate2D.longitude];
    self.selfModel.m_coordinatey = [NSString stringWithFormat:@"%f",CLLocationCoordinate2D.latitude];
    
    NSArray *arr = [address componentsSeparatedByString:@" "];
    
    self.selfModel.m_pro = arr[0];
    self.selfModel.m_city = arr[1];
    self.selfModel.m_area = arr[2];
    
    [self.tableView reloadData];
    
}


-(BMKGeoCodeSearch *)searcher{
    if (!_searcher) {
        _searcher =[[BMKGeoCodeSearch alloc]init];
        _searcher.delegate = self;
    }
    return _searcher;
}


-(void)frontGeoAddress{
    
    
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city=  self.selfModel.m_city;
    geoCodeSearchOption.address = self.selfModel.m_compaddress;
    BOOL flag = [self.searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        
        [MBProgressHUD showWarnMessage:@"输入的位置无法解析,请重新输入"];
    }
    
    
    
    
}


//实现Deleage处理回调结果
//接收正向编码结果

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        CLLocationCoordinate2D coord =  result.location;
        NSString *la = [NSString stringWithFormat:@"%f",coord.latitude];
        NSString *lo = [NSString stringWithFormat:@"%f",coord.longitude];
        self.selfModel.m_coordinatey = la;
        self.selfModel.m_coordinatex = lo;
        
        
        if (self.isEdit) {
            [self AddAddressWithMethod:@"UPDATEADDRESS"];
        }else {
            [self AddAddressWithMethod:@"ADDADDRESS"];
        }
        
        
    }
    else {
        [MBProgressHUD showWarnMessage:@"输入的位置无法解析,请重新输入"];
    }
}


-(void)BUSSINESSIN{
    
    
    //判断地址是否正确
    [self frontGeoAddress];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }else if (indexPath.row == 1) {
        return 40;
    }
    else {
        return 145;
    }
}


- (void)didDeleteAddress:(Ocean_AddressAddCell1 *)cell {
    
   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除地址？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SET_DeleteAddressWithAddressId:cell.model.m_addressid];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)AddAddressWithMethod:(NSString *)method {
    
    self.selfModel.m_uid = [Ocean_UserInfo sharedOcean_UserInfo].m_uid;
    self.selfModel.m_session = [Ocean_UserInfo sharedOcean_UserInfo].m_session;
    self.selfModel.m_linkname = self.nameText.text;
    self.selfModel.m_linktel = self.phoneText.text;
    self.selfModel.m_address = self.textView.XD_text;
    
    [HttpRequestTools requestUserInfoWithData:[self.selfModel mj_keyValues] methodName:method completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddAddressSuccess" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
    }];
    
}



//删除地址
- (void)SET_DeleteAddressWithAddressId:(NSString *)addressid {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_addressid":addressid
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"DELETEADDRESS" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteAddressSuccess" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
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

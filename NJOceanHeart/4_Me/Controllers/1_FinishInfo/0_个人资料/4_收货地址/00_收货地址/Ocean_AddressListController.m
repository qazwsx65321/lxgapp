//
//  Ocean_AddressListController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/5.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AddressListController.h"

#import "Ocean_AddressListCell.h"

#import "Ocean_AddressAddController.h"
#import "Ocean_AddressModel.h"

@interface Ocean_AddressListController ()<UITableViewDelegate,UITableViewDataSource,Ocean_AddressListCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *addressArray;

@property (nonatomic,strong) ShopAddressModel *shopModel;

@end

@implementation Ocean_AddressListController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
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
    
    self.title = @"收货地址";
    self.view.backgroundColor = [UIColor colorWithWhite:0.976 alpha:1.000];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus1"] style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
    addBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    [self GET_GetAddress];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti) name:@"AddAddressSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti) name:@"DeleteAddressSuccess" object:nil];
    
    MJWeakSelf;
    [self.tableView configReloadAction:^{
        
        [weakSelf GET_GetAddress];
        
    }];
}

- (void)noti {
    [self GET_GetAddress];;
}

- (void)addClick {
    Ocean_AddressAddController *addVC = [[Ocean_AddressAddController alloc] init];
    addVC.isEdit = NO;
    [self.navigationController pushViewController:addVC animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_AddressListCell *cell = [Ocean_AddressListCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.cellFrame = self.addressArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Ocean_AddressListFrame *cellFrame = self.addressArray[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isOrderAddress) {
        self.shopModel = [[ShopAddressModel alloc] init];
        
        Ocean_AddressListFrame *cellFrame = self.addressArray[indexPath.row];
        self.shopModel.m_name = cellFrame.model.m_linkname;
        self.shopModel.m_telphone = cellFrame.model.m_telphone;
        self.shopModel.m_pro = cellFrame.model.m_pro;
        self.shopModel.m_city = cellFrame.model.m_city;
        self.shopModel.m_area = cellFrame.model.m_area;
        self.shopModel.m_address = cellFrame.model.m_address;
        self.shopModel.m_lat = cellFrame.model.m_coordinatey;
        self.shopModel.m_lng = cellFrame.model.m_coordinatex;
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeModel" object:self.shopModel];
    }
    
}

- (void)didEditAddress:(Ocean_AddressListCell *)cell {
    Ocean_AddressAddController *addVC = [[Ocean_AddressAddController alloc] init];
    addVC.isEdit = YES;
    addVC.selfModel.m_linkname = cell.cellFrame.model.m_linkname;
    addVC.selfModel.m_linktel = cell.cellFrame.model.m_telphone;
    addVC.selfModel.m_pro = cell.cellFrame.model.m_pro;
    addVC.selfModel.m_city = cell.cellFrame.model.m_city;
    addVC.selfModel.m_area = cell.cellFrame.model.m_area;
    addVC.selfModel.m_address = cell.cellFrame.model.m_address;
    addVC.selfModel.m_flag = cell.cellFrame.model.m_flag;
    addVC.selfModel.m_coordinatex = cell.cellFrame.model.m_coordinatex;
    addVC.selfModel.m_coordinatey = cell.cellFrame.model.m_coordinatey;
    addVC.selfModel.m_addressid = cell.cellFrame.model.m_id;
    [self.navigationController pushViewController:addVC animated:YES];
    
}

- (void)didDefaultAddress:(Ocean_AddressListCell *)cell {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否设为默认地址？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SET_DefaultAddressWithAddressId:cell.cellFrame.model.m_id];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)didDeleteAddress:(Ocean_AddressListCell *)cell {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除地址？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SET_DeleteAddressWithAddressId:cell.cellFrame.model.m_id];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


//获取地址
- (void)GET_GetAddress {
    
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInWindow:nil];
    self.addressArray = [NSMutableArray array];
//    [self.tableView reloadData];
    [self.tableView hideBlankPageView];
    [self.tableView hideErrorPageView];
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session
                          };
    
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"GETADDRESS" completion:^(id respInfo, NSError *error) {
        
        [MBProgressHUD hideHUD];
        if (!error) {
            
            MyAddressBody *body = [MyAddressBody mj_objectWithKeyValues:respInfo];
            
            if ([@"0000" isEqualToString:body.ERRORCODE]) {
                
                for (MyAddressModel *model in body.MYADDRESS) {
                    Ocean_AddressListFrame *frame = [[Ocean_AddressListFrame alloc] init];
                    frame.model = model;
                    [weakSelf.addressArray addObject:frame];
                }
                
            }else{
                [weakSelf.tableView showBlankPageView:body.ERRORDESTRIPTION andImageName:@"commentEmpty"];
            }
        }else{
            [weakSelf.tableView showErrorPageView];
        }
        [weakSelf.tableView reloadData];
    }];
    
}



//设置默认地址
- (void)SET_DefaultAddressWithAddressId:(NSString *)addressid {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_addressid":addressid
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"DEFAULTADDRESS" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
                [self GET_GetAddress];
                
            }else{
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
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
                
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
                [self GET_GetAddress];
                
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



@end

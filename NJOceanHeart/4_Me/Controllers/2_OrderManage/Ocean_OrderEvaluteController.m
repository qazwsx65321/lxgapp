//
//  Ocean_OrderEvaluteController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_OrderEvaluteController.h"

#import "Ocean_OrderEvaluteCell.h"
#import "Ocean_OrderEvaluteModel.h"
#import "Ocean_StoreModel.h"

@interface Ocean_OrderEvaluteController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *canArray;

@end

@implementation Ocean_OrderEvaluteController

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
    
    self.title = @"发表评价";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(launchClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    self.canArray = [NSMutableArray array];
    for (int i = 0; i < self.goodsArray.count; i ++) {
        Ocean_StoreCommodityModel *m = self.goodsArray[i];
        Ocean_OrderEvaluteModel *model = [[Ocean_OrderEvaluteModel alloc] init];
        model.m_goodsid = m.m_goodsid;
        model.m_starnum = @"0";
        model.m_content = @"";
        [self.canArray addObject:model];
    }
    
    [self.view addSubview:self.tableView];
    
}

- (void)launchClick {
    [self GET_PUBGOODSEVALUATE];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_OrderEvaluteCell *cell = [Ocean_OrderEvaluteCell cellWithTableView:tableView];
    cell.model = self.goodsArray[indexPath.row];
    cell.evalutModel = self.canArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 195;
}


- (void)GET_PUBGOODSEVALUATE {
    
    self.canArray = [Ocean_OrderEvaluteModel mj_keyValuesArrayWithObjectArray:self.canArray];
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_orderno":self.myOrderno,
                          @"m_goodsinfo":self.canArray
                          
                          
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"PUBGOODSEVALUATE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"EvaluteSuccess" object:nil];
                
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

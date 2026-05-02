//
//  Ocean_WithdrawDespositRecordController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_WithdrawDespositRecordController.h"
#import "Ocean_DespositModel.h"
#import "Ocean_DespositRecordDetailController.h"
@interface Ocean_WithdrawDespositRecordController ()
@property (nonatomic,strong) NSArray * listArr;
@end

@implementation Ocean_WithdrawDespositRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录";
    self.tableView.tableFooterView = [UIView new];
    [self CASHMONEYQUERY];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellsign = @"cellsign";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellsign];
    }
    Ocean_DespositModel *model= self.listArr [indexPath.row];
    cell.textLabel.text =  @"提现记录";
    cell.detailTextLabel.text = model.m_month;
    return cell;
}

-(void)CASHMONEYQUERY{
    MJWeakSelf;
    [HttpRequestTools  requestUserInfoWithData:nil methodName:@"CASHMONEYQUERY" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                weakSelf.listArr = [Ocean_DespositModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_txlist"]];
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [self.tableView reloadData];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Ocean_DespositModel *model= self.listArr [indexPath.row];
    Ocean_DespositRecordDetailController *deailVc =[[Ocean_DespositRecordDetailController alloc]init];
    deailVc.m_txid = model.m_txid;
    [self.navigationController pushViewController:deailVc animated:YES];
}

@end

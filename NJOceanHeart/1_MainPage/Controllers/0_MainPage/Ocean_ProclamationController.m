//
//  Ocean_ProclamationController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ProclamationController.h"
#import "Ocean_FIRSTPAGESHOWModel.h"
#import "Ocean_ProclamationCell.h"
#import "Ocean_ProclamationDetailController.h"
@interface Ocean_ProclamationController ()

@property (nonatomic,strong) NSArray * p_infoArr;

@end

@implementation Ocean_ProclamationController

static NSString *cellSign = @"Ocean_ProclamationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MORENOTICE];
    self.title = @"公告";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[Ocean_ProclamationCell class] forCellReuseIdentifier:cellSign];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.p_infoArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    announcementModel *model = self.p_infoArr [indexPath.row];
    Ocean_ProclamationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSign forIndexPath:indexPath];
    cell.model = model;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return  [tableView fd_heightForCellWithIdentifier:cellSign cacheByIndexPath:indexPath configuration:^(Ocean_ProclamationCell * cell) {
        
        cell.model = self.p_infoArr[indexPath.row];
        
    }];


}

-(void)MORENOTICE{

    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"MORENOTICE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                NSArray *arr= [announcementModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_goodslist2"]];
                weakSelf.p_infoArr = arr;
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.tableView reloadData];
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    announcementModel *model = self.p_infoArr [indexPath.row];

    Ocean_ProclamationDetailController*detailVC = [[Ocean_ProclamationDetailController alloc]init];
    detailVC.m_id = model.m_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end

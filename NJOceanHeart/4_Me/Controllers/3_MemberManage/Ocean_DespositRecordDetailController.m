//
//  Ocean_DespositRecordDetailController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DespositRecordDetailController.h"
#import "Ocean_DespositDetailModel.h"
#import "Ocean_WithDetailCell.h"
#import "Ocean_WithDetailResultCell.h"
#import "Ocean_DespositResonController.h"
#import "Ocean_disposeCell.h"
@interface Ocean_DespositRecordDetailController ()<Ocean_WithDetailResultCellDelegate>

@property (nonatomic,weak) UILabel * p_HtitleLb;

@property (nonatomic,weak) UILabel * p_HstateLb;

@property (nonatomic,strong) Ocean_DespositDetailModel * detailModel;

@property (nonatomic,strong) UIView  * p_headView;

@property (nonatomic,strong) NSArray * p_InfoArr;


@end

@implementation Ocean_DespositRecordDetailController


-(UIView *)p_headView{

    if (!_p_headView) {
        _p_headView = [[UIView alloc]init];
        _p_headView.width = screen_Width;
        UILabel *countLb = [[UILabel alloc]init];
        countLb.font = [UIFont fontWithName:Heiti_Medium size:25];
        countLb.text = @"0.00";
        countLb.textAlignment = NSTextAlignmentCenter;
        countLb.width = screen_Width;
        countLb.height = 25;
        countLb.y = 25;
        self.p_HtitleLb = countLb;
        [_p_headView addSubview:countLb];
        
        UILabel *stateLb = [[UILabel alloc]init];
        stateLb.font = [UIFont systemFontOfSize:16];
        stateLb.text = @"已提交";
        stateLb.height = 17;
        stateLb.textAlignment = NSTextAlignmentCenter;
        stateLb.width = screen_Width;
        stateLb.y = countLb.bottom +18;
        self.p_HstateLb = stateLb;
        [_p_headView addSubview:stateLb];
        _p_headView.height = stateLb.bottom +25;
    }
    return _p_headView;
}

-(void)Ocean_WithDetailResultCellClickResonButton{

    Ocean_DespositResonController *desVC = [[Ocean_DespositResonController alloc]init];
    desVC.m_reson = self.detailModel.m_reson;
    [self.navigationController pushViewController:desVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录详情";
    self.tableView.tableFooterView = [UIView new];
    [self CASHMONEYQUERYDETAIL];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return  self.p_InfoArr.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArr = self.p_InfoArr[section];
    return sectionArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.p_InfoArr[indexPath.section][indexPath.row];
    if ([@"1" isEqualToString:dic[@"type"]]) {
        
        Ocean_WithDetailCell *cell = [Ocean_WithDetailCell cellWithTableView:tableView];
        cell.textLabel.text = dic[@"title"];
        cell.detailTextLabel.text = dic[@"detail"];
        return cell;
    }else if ([@"2" isEqualToString:dic[@"type"]]){
        Ocean_disposeCell *cell = [Ocean_disposeCell cellWithTableView:tableView];
        cell.model = self.detailModel;
        return cell;
    }else if ([@"3" isEqualToString:dic[@"type"]]){
        
        Ocean_WithDetailResultCell *cell = [Ocean_WithDetailResultCell cellWithTableView:tableView];
        cell.m_dic = dic;
        cell.delegate = self;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.p_InfoArr[indexPath.section][indexPath.row];
    if ([@"1" isEqualToString:dic[@"type"]]) {
        return 40;
    }else if ([@"2" isEqualToString:dic[@"type"]]){
        return 161;
    }else if ([@"3" isEqualToString:dic[@"type"]]){
        return 40;
    }
    return 0;

}


-(void)CASHMONEYQUERYDETAIL{

    MJWeakSelf;
    
    [MBProgressHUD showActivityMessageInView:@""];
    
    [HttpRequestTools  requestUserInfoWithData:@{@"m_txid":self.m_txid} methodName:@"CASHMONEYQUERYDETAIL" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                
                weakSelf.detailModel = [Ocean_DespositDetailModel mj_objectWithKeyValues:respInfo];
                
                [self initData];
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [self.tableView reloadData];
        
    }];



}

-(void)initData{
    

    
    [self.detailModel judgeObjectPropertyNull];
    
    
    self.tableView.tableHeaderView = self.p_headView;

    
    //m_state 1.申请中  2.已处理 3.不同意
    self.p_HtitleLb.text = self.detailModel.m_smoney;
    
    NSDictionary *headDic = @{
                              @"1":@"已提交",
                              @"2":@"提现成功",
                              @"3":@"不同意"
                          };
    
    NSDictionary *rowDic = @{
                              @"1":@"待处理",
                              @"2":@"提现成功",
                              @"3":@"不同意"
                              };
    
    self.p_HstateLb.text = headDic[self.detailModel.m_state];
    
    self.p_InfoArr = @[@[@{
                         @"title":@"手续费",
                         @"detail":self.detailModel.m_around,
                         @"type":@"1"
                         },
                       @{
                           @"title":@"实付费",
                           @"detail":self.detailModel.m_money,
                           @"type":@"1"
                           },
                       @{
                           @"title":@"处理进度",
                           @"detail":@"",
                           @"type":@"2"
                           },
                       @{
                           @"title":@"创建时间",
                           @"detail":self.detailModel.m_buildtime,
                           @"type":@"1"
                           },
                       ],
                     @[@{
                           @"title":@"审核结果",
                           @"detail":rowDic[self.detailModel.m_state],
                           @"type":@"3",
                           @"state":self.detailModel.m_state
                           }]
                     ];
    
    [self.tableView reloadData];


}



@end

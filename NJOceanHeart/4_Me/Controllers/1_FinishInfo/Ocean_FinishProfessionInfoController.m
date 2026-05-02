//
//  Ocean_FinishProfessionInfoController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FinishProfessionInfoController.h"
#import "Ocean_BasicInfoCell.h"
#import "XRNextPreCell.h"
#import "Ocean_FinishBankInfoViewController.h"
#import "Ocean_PersonageInfoModel.h"

@interface Ocean_FinishProfessionInfoController ()<UITableViewDelegate,UITableViewDataSource,XRNextPreCellDelegate>

@property (nonatomic,strong) NSArray * p_messageArr;

@end

@implementation Ocean_FinishProfessionInfoController

-(NSArray *)p_messageArr{
    if (!_p_messageArr) {
        _p_messageArr=  @[@{@"title":@"单位名称:",@"placeHold":@"请填写单位名称",@"type":@"1"                            ,@"key":@"m_company"},
                          @{@"title":@"职位/职务:",@"placeHold":@"请填写职位/职务",@"type":@"1",@"key":@"m_jobname"},
                          ];
    }
    return _p_messageArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";

    UIButton *backButton =  self.navigationItem.leftBarButtonItem.customView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    [backButton removeTarget:self.navigationController action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop    
    
    [backButton addTarget:self action:@selector(backFist2) forControlEvents:UIControlEventTouchUpInside];
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.y = 45+64;
    table.tableFooterView = [[UIView alloc]init];
    table.height -=105;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)backFist2{
    [self.navigationController popViewControllerAnimated:NO];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.p_messageArr.count +1;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row==self.p_messageArr.count?80:45;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row ==self.p_messageArr.count) {
        
        XRNextPreCell *cell = [XRNextPreCell cellWithTableView:tableView];
        cell.nextTitle = @"下一步";
        [cell.p_nextButton setBackgroundColor:BackgroundColors(1)];
        cell.delegate = self;
        return cell;
    }
    
    NSDictionary *infoDic = self.p_messageArr[indexPath.row];
    Ocean_BasicInfoCell *cell = [Ocean_BasicInfoCell cellWithTableView:tableView];
    [cell setBaseDic:infoDic andInfoModel:self.postModel];
    return cell;
    
    return cell;
}




-(void)clickNextbutton{
    
    NSString *waringStr =   [self.postModel judgePostModelToStandard:@{
                                                                       @"_m_company":@"请填写单位名称",
                                                                       @"_m_jobname":@"请填写职务/职位",
                                                                       }];
    
    
    if (waringStr) {
        [MBProgressHUD showWarnMessage:waringStr];
        return;
    };
    Ocean_FinishBankInfoViewController *bankinfo = [[Ocean_FinishBankInfoViewController alloc]init];
    bankinfo.postModel = self.postModel;
    [self.navigationController pushViewController:bankinfo animated:NO];
}

@end



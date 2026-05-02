//
//  Ocean_DrivingDeductionInquiryVC.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DrivingDeductionInquiryVC.h"

#import "Ocean_TextViewCell.h"
#import "Ocean_ButtonCell.h"
#import "Ocean_DriveCell.h"

@interface Ocean_DrivingDeductionInquiryVC ()<UITableViewDelegate,UITableViewDataSource,Ocean_ButtonCellDelegate>

@property (nonatomic,strong) UITextField *idText;
@property (nonatomic,strong) UITextField *numText;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSDictionary *infoDic;

@end

@implementation Ocean_DrivingDeductionInquiryVC

- (NSDictionary *)infoDic {
    if (!_infoDic) {
        _infoDic = [NSDictionary dictionary];
    }
    return _infoDic;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor lightlightGrayColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"驾驶扣分查询";
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 3 : self.infoDic.count ? 1 : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Ocean_TextViewCell *cell = [Ocean_TextViewCell cellWithTableView:tableView];
            cell.XD_title = @"档案编号:";
            self.idText = cell.textView;
            return cell;
        }else if (indexPath.row == 1) {
            Ocean_TextViewCell *cell = [Ocean_TextViewCell cellWithTableView:tableView];
            cell.XD_title = @"驾驶证号:";
            self.numText = cell.textView;
            return cell;
        }else {
            Ocean_ButtonCell *cell = [Ocean_ButtonCell cellWithTableView:tableView];
            cell.delegate = self;
            return cell;
        }
    }else {
        Ocean_DriveCell *cell = [Ocean_DriveCell cellWithTableView:tableView];
        if (self.infoDic.count) {
            cell.dic = self.infoDic;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == 1) {
            return 40;
        }else {
            return 65;
        }
    }else {
        return 100;
    }
}

- (void)didInquiry:(Ocean_ButtonCell *)cell {
    if (self.idText.text.length > 0) {
        if (self.numText.text.length > 0) {
            
            [self usingToolsPayWithID:self.model.m_sid withPrice:self.model.m_price withSuccess:^{
                self.infoDic = [NSDictionary dictionary];
                
                
                [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
                
                [Ocean_DataTools GetDrivePointWithLicenseid:self.idText.text withLicensenumber:self.numText.text withBlock:^(id data) {
                    
                    self.infoDic = data;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                        [MBProgressHUD hideHUD];
                    });
                    
                } withError:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showInfoMessage:@"暂无该车扣分记录!"];
                        [self.tableView reloadData];
                        
                    });
                }];
            }];
        }
    }
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

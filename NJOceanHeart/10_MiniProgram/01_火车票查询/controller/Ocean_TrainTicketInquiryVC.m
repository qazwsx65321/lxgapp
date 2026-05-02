//
//  Ocean_TrainTicketInquiryVC.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_TrainTicketInquiryVC.h"

#import "Ocean_TextViewCell.h"
#import "Ocean_ButtonCell.h"
#import "Ocean_RoundCell.h"
#import "Ocean_TrainLineCell.h"


@interface Ocean_TrainTicketInquiryVC ()<UITableViewDelegate,UITableViewDataSource,Ocean_ButtonCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UITextField *starText;
@property (nonatomic,strong) UITextField *endText;

@property (nonatomic,copy) NSString *isHigh;

@property (nonatomic,strong) NSArray *infoArray;

@end

@implementation Ocean_TrainTicketInquiryVC

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

- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSArray array];
    }
    return _infoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"火车票查询";
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    self.isHigh = @"0";
    
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 4 : self.infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Ocean_TextViewCell *cell = [Ocean_TextViewCell cellWithTableView:tableView];
            cell.XD_title = @"始发站:";
            self.starText = cell.textView;
            return cell;
        }else if (indexPath.row == 1) {
            Ocean_TextViewCell *cell = [Ocean_TextViewCell cellWithTableView:tableView];
            cell.XD_title = @"到达站:";
            self.endText = cell.textView;
            return cell;
        }else if (indexPath.row == 2) {
            Ocean_RoundCell *cell = [Ocean_RoundCell cellWithTableView:tableView];
            cell.ishigh = self.isHigh;
            return cell;
        }else {
            Ocean_ButtonCell *cell = [Ocean_ButtonCell cellWithTableView:tableView];
            cell.delegate = self;
            return cell;
        }
    }else {
        Ocean_TrainLineCell *cell = [Ocean_TrainLineCell cellWithTableView:tableView];
        if (self.infoArray) {
            cell.model = self.infoArray[indexPath.row];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (indexPath.row == 2) {
            if ([@"0" isEqualToString:self.isHigh]) {
                self.isHigh = @"1";
            }else {
                self.isHigh = @"0";
            }
            [self.tableView reloadData];
        }
        
    }
}

- (void)didInquiry:(Ocean_ButtonCell *)cell {
    if (self.starText.text.length > 0) {
        if (self.endText.text.length > 0) {
            
            [self usingToolsPayWithID:self.model.m_sid withPrice:self.model.m_price withSuccess:^{
                self.infoArray = [NSArray array];
                
                
                [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
                
                [Ocean_DataTools GetTrainLineWithStart:self.starText.text withEnd:self.endText.text withIshigh:self.isHigh withBlock:^(id data) {
                    self.infoArray = data;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                        [MBProgressHUD hideHUD];
                    });
                    
                } withError:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showInfoMessage:@"暂无车次!"];
                        [self.tableView reloadData];
                        
                    });
                }];
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == 1) {
            return 40;
        }else if (indexPath.row == 2) {
            return 40;
        }else {
            return 65;
        }
    }else {
        return 65;
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

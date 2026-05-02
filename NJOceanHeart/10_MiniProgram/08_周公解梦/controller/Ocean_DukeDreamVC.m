//
//  Ocean_DukeDreamVC.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DukeDreamVC.h"

#import "Ocean_TextViewCell.h"
#import "Ocean_ButtonCell.h"
#import "Ocean_DukeDreamCell.h"

@interface Ocean_DukeDreamVC ()<UITableViewDelegate,UITableViewDataSource,Ocean_ButtonCellDelegate>

@property (nonatomic,strong) UITextField *keyText;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *infoArray;

@end

@implementation Ocean_DukeDreamVC

- (NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
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
    self.title = @"周公解梦";
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    [self.view addSubview:self.tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 2 : self.infoArray.count ? self.infoArray.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Ocean_TextViewCell *cell = [Ocean_TextViewCell cellWithTableView:tableView];
            cell.XD_title = @"关键字:";
            self.keyText = cell.textView;
            return cell;
        }else {
            Ocean_ButtonCell *cell = [Ocean_ButtonCell cellWithTableView:tableView];
            cell.delegate = self;
            return cell;
        }
    }else {
        
        Ocean_DukeDreamCell *cell = [Ocean_DukeDreamCell cellWithTableView:tableView];
        if (self.infoArray.count) {
            cell.cellframes = self.infoArray[indexPath.row];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 65;
        }
    }else {
        
        if (self.infoArray.count) {
            Ocean_DukeDreamFrame *frames = self.infoArray[indexPath.row];
            
            return frames.bgViewF.size.height + 1;
        }
        
        return 0;
    }
}

- (void)didInquiry:(Ocean_ButtonCell *)cell {
    if (self.keyText.text.length > 0) {
        
        [self usingToolsPayWithID:self.model.m_sid withPrice:self.model.m_price withSuccess:^{
            self.infoArray = [NSMutableArray array];
            
            
            [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
            
            [Ocean_DataTools GetZhouGongJieMengWithKeyWord:self.keyText.text withBlock:^(id data) {
                
                NSArray *arr = data;
                
                
                for (int i = 0; i < arr.count; i ++) {
                    Ocean_DukeDreamFrame *frames = [[Ocean_DukeDreamFrame alloc] init];
                    frames.model = arr[i];
                    
                    [self.infoArray addObject:frames];
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [MBProgressHUD hideHUD];
                });
            } withError:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showInfoMessage:@"暂无相关解梦信息!"];
                    [self.tableView reloadData];
                    
                });
            }];
        }];
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

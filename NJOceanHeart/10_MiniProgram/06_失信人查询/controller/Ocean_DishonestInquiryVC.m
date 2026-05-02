//
//  Ocean_DishonestInquiryVC.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DishonestInquiryVC.h"

#import "Ocean_TextViewCell.h"
#import "Ocean_ButtonCell.h"
#import "Ocean_DisHonestCell.h"

@interface Ocean_DishonestInquiryVC ()<UITableViewDelegate,UITableViewDataSource,Ocean_ButtonCellDelegate>

@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *idText;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *infoArray;

@end

@implementation Ocean_DishonestInquiryVC

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
    
    self.title = @"失信人查询";
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 3 : self.infoArray.count ? self.infoArray.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Ocean_TextViewCell *cell = [Ocean_TextViewCell cellWithTableView:tableView];
            cell.XD_title = @"姓名:";
            cell.XD_placehodel = @"姓名或公司名称";
            self.nameText = cell.textView;
            return cell;
        }else if (indexPath.row == 1) {
            Ocean_TextViewCell *cell = [Ocean_TextViewCell cellWithTableView:tableView];
            cell.XD_chooseTitle = @"证件:";
            cell.XD_placehodel = @"身份证或组织机构代码";
            self.idText = cell.textView;
            return cell;
        }else {
            Ocean_ButtonCell *cell = [Ocean_ButtonCell cellWithTableView:tableView];
            cell.delegate = self;
            return cell;
        }
    }else {
        Ocean_DisHonestCell *cell = [Ocean_DisHonestCell cellWithTableView:tableView];
        if (self.infoArray.count) {
            cell.name = self.nameText.text;
            cell.cellframes = self.infoArray[indexPath.row];
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
        
        if (self.infoArray.count) {
            Ocean_DisHonestFrame *frames = self.infoArray[indexPath.row];
            
            return frames.bgViewF.size.height + 10;
        }
        
        return 0;
    }
}

- (void)didInquiry:(Ocean_ButtonCell *)cell {
    if (self.nameText.text.length > 0) {
            [self usingToolsPayWithID:self.model.m_sid withPrice:self.model.m_price withSuccess:^{
                self.infoArray = [NSMutableArray array];
                
                
                [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
                
                [Ocean_DataTools GetShiXinWithRealName:self.nameText.text withIdCard:self.idText.text withBlock:^(id data) {
                    
                    NSArray *arr = data;
                    
                    for (int i = 0; i < arr.count; i ++) {
                        Ocean_DisHonestFrame *frames = [[Ocean_DisHonestFrame alloc] init];
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
                        [MBProgressHUD showInfoMessage:@"暂无此人失信信息!"];
                        [self.tableView reloadData];
                        
                    });
                }];
            }];
    }else {
       [MBProgressHUD showInfoMessage:@"请输入姓名!"];
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

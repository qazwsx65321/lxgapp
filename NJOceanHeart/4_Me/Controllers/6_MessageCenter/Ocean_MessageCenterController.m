//
//  Ocean_MessageCenterController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MessageCenterController.h"

#import "Ocean_MessageCell.h"

#import "Ocean_MessageDetailController.h"

@interface Ocean_MessageCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *infoArray;

@end

@implementation Ocean_MessageCenterController

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
    self.title = @"消息中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(cleanClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    
    [self initData];
    [self.view addSubview:self.tableView];
}

- (void)cleanClick {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"notifications"];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_MessageCell *cell = [Ocean_MessageCell cellWithTableView:tableView];
    cell.cellFrame = self.infoArray[indexPath.row];
    return cell;
}


- (void)initData {
    
    self.infoArray = [NSMutableArray array];
    
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"notifications"];
    
    for (int i = 0; i < arr.count; i ++) {
        NSDictionary *dic = arr[0];
        Ocean_MessageFrame *frames = [[Ocean_MessageFrame alloc] init];
        frames.infoDic = dic;
        [self.infoArray addObject:frames];
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Ocean_MessageDetailController *detailVC = [[Ocean_MessageDetailController alloc] init];
    Ocean_MessageFrame *frames = self.infoArray[indexPath.row];
    detailVC.dic = frames.infoDic;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Ocean_MessageFrame *frames = self.infoArray[indexPath.row];
    return frames.cellHeight;
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

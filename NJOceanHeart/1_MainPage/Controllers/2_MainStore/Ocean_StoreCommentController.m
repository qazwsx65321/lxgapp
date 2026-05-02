//
//  UserCommentController.m
//  Glad9TM
//
//  Created by 陈志伟 on 17/6/6.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "Ocean_StoreCommentController.h"
#import "UserCommentModel.h"
#import "UserCommentCell.h"
@interface Ocean_StoreCommentController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *infoArray;

@end

@implementation Ocean_StoreCommentController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UITableView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];

    [self GET_GoddsEvaluateListInterface];
    
 
    MJWeakSelf;
    [self.tableView configReloadAction:^{
        [weakSelf GET_GoddsEvaluateListInterface];
    }];
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
    UserCommentCell *cell = [UserCommentCell cellWithTableView:tableView];
    cell.XD_frame = self.infoArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCommentFrame *fr = self.infoArray[indexPath.row];
    return fr.cellHeight;
}

- (void)GET_GoddsEvaluateListInterface {
    
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_goodsid":self.m_goodsid} methodName:@"GOODSEVALUATE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            UserCommentHead *respModel = [UserCommentHead mj_objectWithKeyValues:respInfo];
            
            
            if ([respModel.ERRORCODE isEqualToString:@"0000"])
            {
                NSArray *classArr = respModel.EVALUATEINFO;
                NSMutableArray *framArr = [NSMutableArray array];
                UserCommentFrame *fModel = [UserCommentFrame new];
                for (UserCommentModel *model in classArr) {
                    fModel.model = model;
                    [framArr addObject:fModel];
                }
                weakSelf.infoArray = framArr;
            }else{
                [weakSelf.tableView showBlankPageView:respInfo[@"ERRORDESTRIPTION"] andImageName:@"commentEmpty"];
            }
        }else{
            
            [weakSelf.tableView showErrorPageView];

            
        }
        [weakSelf.tableView reloadData];
    }];

    
    
    
    
}

@end

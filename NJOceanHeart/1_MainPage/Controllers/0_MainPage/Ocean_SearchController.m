//
//  Ocean_SearchController.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_SearchController.h"
#import "Ocean_ShopResultModel.h"
#import "Ocean_ShopResultCell.h"
#import "Ocean_GoodsResultCell.h"
#import "Ocean_MainStoreController.h"
#import "GoodDetailViewController.h"
#import "Ocean_MainforceCommodityController.h"
#import "Ocean_SearchTextField.h"
@interface Ocean_SearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UISearchBar *searchBarr;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)Ocean_SearchResultModel *model;


@property (nonatomic,strong) Ocean_SearchTextField * p_QTextFiled;

@end

@implementation Ocean_SearchController


-(Ocean_SearchTextField *)p_QTextFiled{
    if (!_p_QTextFiled) {
        _p_QTextFiled = [[Ocean_SearchTextField alloc]initWithFrame:CGRectMake(0, 0, 500, 30)];
        _p_QTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        UIImageView *imageV =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_search"]];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.size = CGSizeMake(15, 15);
        _p_QTextFiled.leftView =imageV;
        _p_QTextFiled.leftViewMode = UITextFieldViewModeAlways;
        _p_QTextFiled.clearsOnBeginEditing = YES;
    }
    return _p_QTextFiled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//QS ---2017.9.28
//    _searchBarr = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 36)];
//    _searchBarr.delegate = self;
//    _searchBarr.frame = CGRectMake(0, 0, 100, 36);
//    self.navigationItem.titleView = _searchBarr;
//    [_searchBarr becomeFirstResponder];
    
//QS ---2017.9.28
    //QS ---2017.9.28
    self.navigationItem.titleView = self.p_QTextFiled;
    [self.p_QTextFiled becomeFirstResponder];

    //QS ---2017.9.28

    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(5, 0, 30, 30);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setImage:[UIImage imageNamed:@"main_search"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_Width, screen_Height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[Ocean_ShopResultCell class] forCellReuseIdentifier:@"Ocean_ShopResultCell"];
    [_tableView registerClass:[Ocean_GoodsResultCell class] forCellReuseIdentifier:@"Ocean_GoodsResultCell"];
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_ShopResultModel *body = _model.GOODSINFO[indexPath.row];
    if ([body.m_type isEqualToString:@"0"]) {
        return [tableView fd_heightForCellWithIdentifier:@"Ocean_ShopResultCell" cacheByIndexPath:indexPath configuration:^(Ocean_ShopResultCell *cell)
                {
                    cell.model = body;
                }];
    }
//    else
//    {
//        return 90;
//
//    }
    else
    {
        return [tableView fd_heightForCellWithIdentifier:@"Ocean_GoodsResultCell" cacheByIndexPath:indexPath configuration:^(Ocean_GoodsResultCell *cell)
                {
                    cell.model = body;
                }];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.GOODSINFO.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ocean_ShopResultModel *body = _model.GOODSINFO[indexPath.row];
    if ([body.m_type isEqualToString:@"0"]) {
        Ocean_ShopResultCell *cell = [Ocean_ShopResultCell cellWithTableView:tableView];
        cell.model = body;
        return cell;
    }
    else
    {
        Ocean_GoodsResultCell *cell = [Ocean_GoodsResultCell cellWithTableView:tableView];
        cell.model = body;
        return cell;
    }
}
- (void)search
{
//    QS
    if (!self.p_QTextFiled.text.length) {
        [MBProgressHUD showInfoMessage:@"搜索内容不能为空"];
    }
    else
    {
        NSDictionary *dict = @{@"m_content":self.p_QTextFiled.text
                               };
        [HttpRequestTools requestUserInfoWithData:dict methodName:@"SEARCH" completion:^(id respInfo, NSError *error) {
            if (!error) {
                _model = [[Ocean_SearchResultModel alloc] init];
                if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                    _model = [Ocean_SearchResultModel mj_objectWithKeyValues:respInfo];
                    [_tableView reloadData];
                }
                else {
                    [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
                }
            } else {
                [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }];
        [self.p_QTextFiled resignFirstResponder];
    }
    
//    QS

    
//    [self searchBarSearchButtonClicked:_searchBarr];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (!searchBar.text.length) {
        [MBProgressHUD showInfoMessage:@"搜索内容不能为空"];
    }
    else
    {
    NSDictionary *dict = @{@"m_content":searchBar.text
                           };
    [HttpRequestTools requestUserInfoWithData:dict methodName:@"SEARCH" completion:^(id respInfo, NSError *error) {
        if (!error) {
            _model = [[Ocean_SearchResultModel alloc] init];
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                _model = [Ocean_SearchResultModel mj_objectWithKeyValues:respInfo];
                [_tableView reloadData];
            }
            else {
                [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        } else {
            [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
        }
    }];
    [_searchBarr resignFirstResponder];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchBarr resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Ocean_ShopResultModel *body = _model.GOODSINFO[indexPath.row];
    if ([body.m_type isEqualToString:@"0"]) {

        Ocean_MainStoreController *store = [[Ocean_MainStoreController alloc]init];
        
        shopInfoModel *shopinfo = [shopInfoModel new];
        shopinfo.m_name = body.m_bname;
        shopinfo.m_gbid = body.m_bid;
        shopinfo.m_listpic = body.m_logo;
        shopinfo.m_allnum = [NSString stringWithFormat:@"%d",body.m_allnum];
        shopinfo.m_soldnum = [NSString stringWithFormat:@"%d",body.m_soldallnum];
        store.m_shopInfo = shopinfo;
        [self.navigationController pushViewController:store animated:YES];
        
    }else{
        Ocean_MainforceCommodityController  *vc = [[Ocean_MainforceCommodityController alloc]init];
        vc.m_gid = body.m_goodsid;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBarr resignFirstResponder];
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

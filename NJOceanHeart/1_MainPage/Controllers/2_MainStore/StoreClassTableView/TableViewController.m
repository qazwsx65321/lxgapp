//
//  TableViewController.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "TableViewHeaderView.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "CategoryModel.h"
#import "TableViewController.h"
#import "Ocean_CategoryRightFramModel.h"
#import "Ocean_MainforceCommodityController.h"
static float kLeftTableViewWidth = 80.f;

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic,strong) NSArray * selectGoodArr;

@end

@implementation TableViewController
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];

    _selectIndex = 0;
    _isScrollDown = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Getters

//- (NSArray *)categoryData
//{
//    if (!_categoryData)
//    {
//        _categoryData = [NSArray array];
//    }
//    return _categoryData;
//}
//
//- (NSArray *)foodData
//{
//    if (!_foodData)
//    {
//        _foodData = [NSArray array];
//    }
//    return _foodData;
//}

-(void)setFoodData:(NSArray *)foodData{
    _foodData = foodData;
    if (foodData.count) {
        _selectGoodArr = foodData[0];
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
}

-(void)setCategoryData:(NSArray *)categoryData{
    _categoryData = categoryData;
   
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT-64)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, SCREEN_WIDTH-kLeftTableViewWidth, SCREEN_HEIGHT-64)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.tableFooterView = [UIView new];

        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
    }
    return _rightTableView;
}

#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        return self.categoryData.count;
    }
    else
    {
        return [self.selectGoodArr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
        CategoryModel *model = self.categoryData[indexPath.row];
        cell.name.text = model.m_name;
        return cell;
    }
    else
    {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.framModel = self.selectGoodArr[indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_rightTableView == tableView)
    {
        Ocean_CategoryRightFramModel *Fmodel= self.selectGoodArr[indexPath.row];
        CGFloat cellH = Fmodel.cellHeight;
        return cellH;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        TableViewHeaderView *view = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        CategoryModel *model = self.categoryData[section];
        view.name.text = model.m_name;
        return view;
    }
    return nil;
}

//// TableView分区标题即将展示
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
//{
//    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
//    if ((_rightTableView == tableView)
//        && !_isScrollDown
//        && (_rightTableView.dragging || _rightTableView.decelerating))
//    {
//        [self selectRowAtIndexPath:section];
//    }
//}
//
//// TableView分区标题展示结束
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
//    if ((_rightTableView == tableView)
//        && _isScrollDown
//        && (_rightTableView.dragging || _rightTableView.decelerating))
//    {
//        [self selectRowAtIndexPath:section + 1];
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        self.selectGoodArr = self.foodData[indexPath.row];
        [self.rightTableView reloadData];
        
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//        [self scrollToTopOfSection:_selectIndex animated:YES];
//        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
//                              atScrollPosition:UITableViewScrollPositionTop
//                                      animated:YES];
        
    }else{
    
        Ocean_CategoryRightFramModel *fModel = self.selectGoodArr[indexPath.row];
        Ocean_MainforceCommodityController *commodityVC = [[Ocean_MainforceCommodityController alloc]init];
        commodityVC.m_gid = fModel.m_foodModel.m_shopid;
        commodityVC.m_storePic = self.m_storePic;
        [self.navigationController pushViewController:commodityVC animated:YES];
        
    }
}

//- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
//{
//    CGRect headerRect = [self.rightTableView rectForSection:section];
//    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _rightTableView.contentInset.top);
//    [self.rightTableView setContentOffset:topOfHeader animated:animated];
//}
//
//// 当拖动右边TableView的时候，处理左边TableView
//- (void)selectRowAtIndexPath:(NSInteger)index
//{
//    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
//                                animated:YES
//                          scrollPosition:UITableViewScrollPositionTop];
//}
//
//#pragma mark - UISrcollViewDelegate
//// 标记一下RightTableView的滚动方向，是向上还是向下
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    static CGFloat lastOffsetY = 0;
//
//    UITableView *tableView = (UITableView *) scrollView;
//    if (_rightTableView == tableView)
//    {
//        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
//        lastOffsetY = scrollView.contentOffset.y;
//    }
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define tableViewH  100

#import "Ocean_ClassifyController.h"


#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
#import "DCClassGoodsItem.h"
// Views
#import "DCClassCategoryCell.h"
#import "DCGoodsSortCell.h"
#import "DCBrandSortCell.h"
#import "DCBrandsSortHeadView.h"
#import "GoodListViewController.h"


@interface Ocean_ClassifyController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassGoodsItem *> *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassMianItem *> *mainItem;

@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";

@implementation Ocean_ClassifyController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, DCTopNavH, tableViewH, ScreenH - DCTopNavH);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCClassCategoryCell class] forCellReuseIdentifier:DCClassCategoryCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH, DCTopNavH, ScreenW - tableViewH, ScreenH - DCTopNavH);
        //注册Cell
        [_collectionView registerClass:[DCGoodsSortCell class] forCellWithReuseIdentifier:DCGoodsSortCellID];
        [_collectionView registerClass:[DCBrandSortCell class] forCellWithReuseIdentifier:DCBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[DCBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID];
    }
    return _collectionView;
}


#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpNav];
    
    [self setUpTab];
    
    [self setUpData];
}

#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = RGB(248, 244, 254);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 加载数据
- (void)setUpData
{
    [self ONETYPE];
}


#pragma mark - 设置导航条
- (void)setUpNav
{
    self.title = @"商品分类";
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DCClassGoodsItem *item = _titleItem[indexPath.row];
    [self TWOTYPE:item.m_cid];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    DCClassMianItem *mianItem =  _mainItem[section];
    return mianItem.m_threeclass.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _mainItem.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
    DCClassMianItem *mianItem =  _mainItem[indexPath.section];
    cell.subItem = mianItem.m_threeclass[indexPath.item];
    gridcell = cell;
        return gridcell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(collectionView.width, 40);

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        DCBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID forIndexPath:indexPath];
        DCClassMianItem *mianItem =  _mainItem[indexPath.section];
        headerView.headTitle = mianItem;
        headerView.p_linv.hidden = NO;
        if (!indexPath.section) {
            headerView.p_linv.hidden = YES;
        }
        reusableview = headerView;
    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
        return CGSizeMake((ScreenW - tableViewH - 6)/3, (ScreenW - tableViewH - 6)/3 + 20);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    DCClassMianItem *mianItem1 =  _mainItem[indexPath.section];
    DCCalssSubItem *subItem = mianItem1.m_threeclass[indexPath.item];    GoodListViewController *listViewController = [[GoodListViewController alloc]init];
    listViewController.type = @"3";
    listViewController.classId = subItem.m_cid;
    [self.navigationController pushViewController:listViewController animated:YES];

}
-(void)ONETYPE{
    
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"ONETYPE" completion:^(id respInfo, NSError *error) {
        int index = 0;
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                _titleItem =  [DCClassGoodsItem mj_objectArrayWithKeyValuesArray:respInfo[@"m_typelist"]];
                BOOL isHave = NO;
                for (int i = 0; i<_titleItem.count; i++) {
                    DCClassGoodsItem *item = _titleItem[i];
                    if ([item.m_cid isEqualToString:self.m_gcid]) {
                        index = i;
                        isHave = YES;
                        
                        
                        
                        break;
                    }
                }
                
                [weakSelf.tableView reloadData];
                
                if (isHave) {
                    [self TWOTYPE:self.m_gcid];
                }else{
                    if (_titleItem.count) {
                        DCClassGoodsItem *item = [_titleItem firstObject];
                        [self TWOTYPE:item.m_cid];
                    }
                    
                }
                
                if (_titleItem.count) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                    });
                    
                }
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.tableView reloadData];
      
    }];
    
}

//DCCalssSubItem
-(void)TWOTYPE:(NSString *)typeid{
    
    MJWeakSelf;
    _mainItem = nil;
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_cid":typeid} methodName:@"TWOTYPE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                _mainItem =  [DCClassMianItem mj_objectArrayWithKeyValuesArray:respInfo[@"m_typelist"]];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.collectionView reloadData];
    }];
    
}


@end

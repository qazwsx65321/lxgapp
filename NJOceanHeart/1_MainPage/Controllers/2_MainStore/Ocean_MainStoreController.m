//
//  Ocean_MainStoreController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/11.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MainStoreController.h"
#import "XHSegmentViewController.h"
#import "TableViewController.h"
#import "Ocean_MainStoreScoller.h"
#import "Ocean_StoreCommentController.h"
#import "CategoryModel.h"
#import "Ocean_NavigationController.h"
#import "Ocean_MainStoreShopModel.h"
#import "Ocean_MainStoreHeadView.h"
#import "Ocean_CategoryRightFramModel.h"
#import "Ocean_StoreDetailController.h"
@interface Ocean_MainStoreController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView * p_scroller;
@property (nonatomic,weak) TableViewController * p_classVC;
@property (nonatomic,weak) Ocean_MainStoreHeadView * p_headView;
@property (nonatomic,strong) Ocean_MainStoreShopModel *p_respModel;
@end

@implementation Ocean_MainStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.m_shopInfo judgeObjectPropertyNull];
    Ocean_NavigationController *nav =  (Ocean_NavigationController*)self.navigationController;
//    nav.alpha = 0;
    UILabel *title = [[UILabel alloc]init];
    title.text = self.m_shopInfo.m_name;
    [title sizeToFit];
    title.hidden = YES;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = title;
    
    self.title = self.m_shopInfo.m_name;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //20220406，适配大屏幕手机
    //CGFloat HHH =  screen_Height==812 ?44:0;
    CGFloat HHH =  screen_Height>=812 ?44:0;
    
    Ocean_MainStoreHeadView *headView = [[Ocean_MainStoreHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60+64+15+HHH)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(StoreDetail)];
    [headView addGestureRecognizer:tap];
    headView.backgroundColor = BackgroundColors(1);
    self.p_headView = headView;
    headView.model = self.m_shopInfo;
    
    Ocean_MainStoreScoller *scorller = [[Ocean_MainStoreScoller alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (@available(iOS 11.0, *)) {
        scorller.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scorller.bounces = NO;
    scorller.delegate = self;
    
    //20220406，适配大屏幕手机
    //CGFloat SHH =  screen_Height==812 ?22:0;
    CGFloat SHH =  screen_Height>=812 ?22:0;
    
    scorller.contentSize = CGSizeMake(screen_Width, 75 + scorller.height+SHH);
    scorller.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scorller];
    [scorller addSubview:headView];
    self.p_scroller = scorller;
    
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(canScroll:) name:@"MainStoreScorllEvent" object:nil];
    
    XHSegmentViewController *mainController = [[XHSegmentViewController alloc]init];
    [self addChildViewController:mainController];
    mainController.segmentBackgroundColor = [UIColor whiteColor];
    mainController.segmentTitleColor = [UIColor colorWithRed:0.149 green:0.153 blue:0.149 alpha:1.000];
    mainController.segmentHighlightColor = [UIColor colorWithRed:0.957 green:0.345 blue:0.278 alpha:1.000];
    mainController.segmentLineColor = [UIColor colorWithRed:0.957 green:0.345 blue:0.278 alpha:1.000];
    mainController.segmentTitleFont = [UIFont fontWithName:Heiti_Medium size:13];
    mainController.NavHeight = 40;
    TableViewController *table = [[TableViewController alloc]init];
    
    table.m_storePic = self.m_shopInfo.m_listpic;
    table.title = @"商品";
    
    self.p_classVC = table;
    
    Ocean_StoreCommentController *table1 = [[Ocean_StoreCommentController alloc]init];
    table1.m_goodsid = self.m_shopInfo.m_gbid;
    table1.title = @"评价";
    mainController.view.height = self.view.height;
    mainController.viewControllers = @[table,table1];
    mainController.view.y = headView.bottom;
    mainController.view.width = screen_Width;
    [scorller addSubview:mainController.view];
    [mainController.segmentControl load];
    [self BUSINESSCLASS];
    
}
-(void)StoreDetail{

    if (!self.p_respModel.shopinfolist.count) {
        [MBProgressHUD showWarnMessage:@"暂无店铺信息"];
        return;
    }
    Ocean_StoreDetailController *detailVC = [[Ocean_StoreDetailController alloc]init];
    detailVC.infomodel = [self.p_respModel.shopinfolist firstObject];
    [self.navigationController pushViewController:detailVC animated:YES];

}


-(void)canScroll:(NSNotification *)not{
    BOOL canscorll = [[not object] boolValue];
    self.p_scroller.scrollEnabled  = canscorll;
}






-(void)BUSINESSCLASS{
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInView:@""];
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_bid":self.m_shopInfo.m_gbid} methodName:@"BUSINESSCLASS" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];

        if (!error) {
            
            Ocean_MainStoreShopModel *respModel = [Ocean_MainStoreShopModel mj_objectWithKeyValues:respInfo];
            self.p_respModel = respModel;
            if ([respModel.ERRORCODE isEqualToString:@"0000"])
            {
                NSArray *classArr = respModel.classlist;
                NSMutableArray *shopArrs = [NSMutableArray array];
                for (CategoryModel *model in classArr) {
                    NSMutableArray *shopArr = [NSMutableArray array];
                    for (NSArray *arr in model.m_goodslist) {
                       FoodModel *shopModel = [[FoodModel alloc]initObjectWithArray:arr];
                        
                        Ocean_CategoryRightFramModel *framModel = [[Ocean_CategoryRightFramModel alloc]initWithFoodModel:shopModel];
                        
                        [shopArr addObject:framModel];
                    }
                    [shopArrs addObject:shopArr];
                }
                
                weakSelf.p_classVC.categoryData = classArr;
                weakSelf.p_classVC.foodData = shopArrs;
                //获取商铺信息展示
                
                if (respModel.shopinfolist.count) {
                    
                    storeShopModel *shopModel1 = [respModel.shopinfolist firstObject];
                    shopInfoModel *info1model = [shopInfoModel new];
                    info1model.m_gbid = weakSelf.m_shopInfo.m_gbid;
                    info1model.m_soldnum = shopModel1.m_soldallnum;
                    info1model.m_allnum = shopModel1.m_allnum;
                    info1model.m_listpic = shopModel1.m_logo;
                    info1model.m_name = shopModel1.m_name;
                    weakSelf.p_headView.model =info1model;
                    
                    
                }
                
               
                
                //获取商铺信息展示
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat alpha = scrollView.contentOffset.y/60;
    if (scrollView.dragging) {
        
        Ocean_NavigationController *nav =  (Ocean_NavigationController*)self.navigationController;
      
        if (alpha>0.75) {
            
            self.navigationItem.titleView.hidden = NO;
            
        }else {
            self.navigationItem.titleView.hidden = YES;

        }
        
        [UIView animateWithDuration:.3 animations:^{
            nav.alpha = alpha;
            
        }];
        
         
        
    }

}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    Ocean_NavigationController *nav =  (Ocean_NavigationController*)self.navigationController;
    nav.alpha = 1;
}




@end

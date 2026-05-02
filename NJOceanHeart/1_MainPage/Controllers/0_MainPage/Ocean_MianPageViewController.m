//
//  Ocean_MianPageViewController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MianPageViewController.h"
#import "Ocean_MainPageLayout.h"
#import "Ocean_FistHotGoodsCell.h"
#import "Ocean_FirstPageHeadView.h"
#import "Ocean_FirstPageFunctionCell.h"
#import "Ocean_FIRSTPAGESHOWModel.h"
#import "Ocean_RecommendStoreCell.h"
#import "Ocean_FirstAnnouncementCell.h"
#import "Ocean_MainStoreController.h"
#import "Ocean_bannerCell.h"
#import "Ocean_MainPageBannerModel.h"
#import "Ocean_MainforceCommodityController.h"
#import "Ocean_UrlWebController.h"
#import "Ocean_EnterStoreController.h"
#import "Ocean_ClassifyController.h"
#import "ZFScanViewController.h"
#import "Ocean_SearchController.h"
#import "Ocean_ProclamationController.h"
#import "Ocean_MessageCenterController.h"
#import "Ocean_MianPageViewController+Ocean_FunctionMethod.h"
#import "Ocean_FriendsInfoController.h"
#import "Ocean_HotViewController.h"
#import "Ocean_NewsLinkVC.h"
#import "Ocean_ProclamationDetailController.h"

#import "Ocean_DishonestInquiryVC.h"
#import "KX9FirstPageProductModel.h"

@interface Ocean_MianPageViewController ()<Ocean_FirstPageFunctionCellDelegate,Ocean_bannerCellDelegate,UISearchBarDelegate,Ocean_FirstPageHeadViewDelegate>

@property (nonatomic,strong) NSArray  * p_classInfoArr;

@property (nonatomic,strong) NSArray  * p_sectionHeadArr;

@property (nonatomic,strong) Ocean_FIRSTPAGESHOWModel * firstModel;

@property (nonatomic,strong) NSArray * p_colorArr;

@property (nonatomic,strong) NSArray * p_announcementArr;

@property (nonatomic,strong) NSArray * p_bannerArr;

@property (nonatomic, strong)UISearchBar *searchBarr;

@property (nonatomic,strong) NSArray * p_infoArr;

@end

@implementation Ocean_MianPageViewController

#define EffectPictureW 384
#define EffectPictureH 962


-(NSArray *)p_colorArr{
    if (!_p_colorArr) {
        _p_colorArr = @[@"E8FDFE",@"FFFDE7",@"FDEFEE",@"E2ECFE",@"EBFDED"];
    }
    return _p_colorArr;
}

-(NSArray *)p_sectionHeadArr{
    if (!_p_sectionHeadArr) {
        _p_sectionHeadArr = @[[NSNull null],[NSNull null],[NSNull null],
                              @{@"more":@"",@"content":@"热门商品"},
                              @{@"content":@"推荐店铺"}];
    }
    return  _p_sectionHeadArr;
}
- (instancetype)init
{
    Ocean_MainPageLayout *flowLay = [[Ocean_MainPageLayout alloc]init];
    return [super initWithCollectionViewLayout:flowLay];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(guangguang) name:@"guangjie" object:nil];
    self.collectionView.backgroundColor = RGB(250, 250, 250);
    [self drawNav];
    [self initCollectionViewCell];
    [self MORENOTICE];
    [self FIRSTPAGE_CAROUSEPIC];
    [self FIRSTPAGESHOW];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receviceGroupButtoEvent:) name:@"HYZXGroupButtonClickEvent" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receviceAnnouncement:) name:@"ScorllerInfoArr" object:nil];
//监听登陆判断开片信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgeLoginCard) name:@"QSAlterViewFromCurrentVC" object:nil];
    
    
    MJWeakSelf;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf FIRSTPAGESHOW];
        [weakSelf MORENOTICE];
        [weakSelf FIRSTPAGE_CAROUSEPIC];
    }];
    
    [Ocean_JudgeAlterView alterViewFrom:self.tabBarController];

    
    if (@available(iOS 11.0, *)){
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    self.collectionView.showsVerticalScrollIndicator = NO;
}
#pragma mark- 判断通知消息
//监听登陆判断开片信息
-(void)judgeLoginCard{

    [Ocean_JudgeAlterView alterViewFrom:self.tabBarController];
    
}


- (void)guangguang
{
    self.tabBarController.selectedIndex = 0;
}

-(void)initCollectionViewCell{

    NSArray *classArr = [NSArray arrayWithContentsOfFile:ProjectListPath(@"FirstPageLayoutCell", @"plist")];
    self.p_classInfoArr = classArr;
    for (NSDictionary *classInfo in classArr) {
        [self.collectionView registerClass:NSClassFromString(classInfo[@"FistClassName"]) forCellWithReuseIdentifier:classInfo[@"FistClassName"]];
    }

    
    [self.collectionView registerClass:[Ocean_FirstPageHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Ocean_FirstPageHeadView"];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
            NSLog(@"####################----%@------",NSStringFromCGRect(self.navigationController.navigationBar.frame));

}

-(void)drawNav{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"scan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(itemsender:)];
    leftItem.tag = 100;
    self.navigationItem.leftBarButtonItem =leftItem;
    
//    _searchBarr = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
//    _searchBarr.placeholder = @"搜索店铺、商品名称";
//    _searchBarr.delegate = self;
//    _searchBarr.frame = CGRectMake(0, 0, 100, 80);
//    self.navigationItem.titleView = _searchBarr;
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"scan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(itemsender:)];
//    leftItem.tag = 100;
//    self.navigationItem.rightBarButtonItem =rightItem;
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"main_news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(itemsender:)];
    rightItem.tag = 300;
    self.navigationItem.rightBarButtonItem =rightItem;
    
  
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 200;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setImage:[UIImage imageNamed:@"main_search"] forState:UIControlStateNormal];
    [button setTitle:@"搜索店铺、商品名称" forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:RGB(179, 179, 179) forState:0];
    button.backgroundColor = [UIColor whiteColor];
    button.width = 500;
    button.height =30;
    [button addTarget:self action:@selector(itemsender:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;

}
//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//
//    return YES;
//}

#pragma mark- 导航栏功能按钮


-(void)itemsender:(id)sender{
    NSNumber *flag = [sender valueForKeyPath:@"tag"];
    
    switch ([flag integerValue]) {
        case 100:
        {//二维码
            ZFScanViewController * vc = [[ZFScanViewController alloc] init];
            vc.returnScanBarCodeValue = ^(NSString * barCodeString){
                
                if ([barCodeString checkURL]) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:barCodeString]];
                }else{
                    NSArray *infoArrs = [barCodeString componentsSeparatedByString:@"&&"];
                    NSString *uid = infoArrs[1];
                    NSString *type = infoArrs[0];
                    NSString *str  = [NSData AES256DecryptWithCiphertext:uid];
                    if (!str.length) {
                        [MBProgressHUD showErrorMessage:@"对不起,无法识别此二维码!"];
                        return;
                    }
                    
                    if ([type isEqualToString:@"1"]) {
                        //扫描二维码后添加好友
                        //NSString *m_uid = str;
                        Ocean_FriendsInfoController *friendVC = [[Ocean_FriendsInfoController alloc] init];
                        friendVC.friendid = str;
                        [self.navigationController pushViewController:friendVC animated:YES];
                        
                        
                    }else if ([@"3" isEqualToString:type]){
                        //扫描二维码后转账
                        [self getUserinfoFromQRUid:str];
                    }
                    
//                    
//                    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
//                    [alter show];
                }
            };
            
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 200:
        {//搜索店铺
            
            Ocean_SearchController *controller = [[Ocean_SearchController alloc] init];
            [self.navigationController pushViewController:controller animated:NO];
            
        }
            break;
        default:
        {//消息
            
            Ocean_MessageCenterController *messageVC = [[Ocean_MessageCenterController alloc]init];
            [self.navigationController pushViewController:messageVC animated:YES];
            
        }
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.p_classInfoArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section ==1 && !self.firstModel.m_goodslist.count) {
            return 0;
    }
    
    if (section ==4) {
        return self.firstModel.m_goodslist4.count;
    }
    NSDictionary *infodic = self.p_classInfoArr[section];
    return [infodic[@"itemNumber"] integerValue];
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *infodic = self.p_classInfoArr[indexPath.section];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:infodic[@"FistClassName"] forIndexPath:indexPath];
    if (indexPath.section==3) {
        
        hotGoodsModel *model = self.firstModel.m_goodslist3[indexPath.item];
        Ocean_FistHotGoodsCell *hotcell = (Ocean_FistHotGoodsCell *)cell;
        hotcell.sign = indexPath.item;
        hotcell.m_model = model;
        hotcell.backgroundColor = [UIColor colorWithHexString:self.p_colorArr[indexPath.item]];
    }else if (indexPath.section ==1){
        Ocean_FirstPageFunctionCell *funccell = (Ocean_FirstPageFunctionCell *)cell;
        funccell.delegate = self;
        funccell.m_groupButtons = self.firstModel.m_goodslist;
    }else if (indexPath.section ==4){
        shopInfoModel *model = self.firstModel.m_goodslist4[indexPath.item];
        Ocean_RecommendStoreCell *storeCell = (Ocean_RecommendStoreCell *)cell;
        storeCell.model = model;
    }else if (indexPath.section ==2){
    Ocean_FirstAnnouncementCell *announcemnet =(Ocean_FirstAnnouncementCell *)cell;
    announcemnet.p_noticationArr = self.p_announcementArr;
    }else if (indexPath.section ==0){
        Ocean_bannerCell *bannerCell =(Ocean_bannerCell *)cell;
        bannerCell.m_scrollItems = self.p_bannerArr;
        bannerCell.delegate = self;
    }
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *infodic = self.p_classInfoArr[indexPath.section];
    NSInteger lineNum = [infodic[@"lineNum"] integerValue];
    NSInteger H = [infodic[@"H"] integerValue];
    if (lineNum == 1) {
        if (indexPath.section==1) {
           
            return CGSizeMake(screen_Width,screen_Width * H/404 +45);
        }else if (indexPath.section ==4){
            CGFloat H = (screen_Width -30)/3 + 30 + 40 +15;
            return CGSizeMake(screen_Width,H);

        
        }
        return CGSizeMake(screen_Width,screen_Width * H/EffectPictureW);
    }else{
        NSInteger itemSpace = [infodic[@"itemSpace"] integerValue];
        CGFloat FirstItemW = (screen_Width - 6 *itemSpace)/2;
        CGFloat FirstItemH = FirstItemW *374/265;
        if (!indexPath.item) {
            return  CGSizeMake(FirstItemW, FirstItemH);
        }
        else{
            return CGSizeMake(FirstItemW/2, 0);
        }
    }
    
}



-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    NSDictionary *infodic = self.p_classInfoArr[section];
    NSInteger space = [infodic[@"itemSpace"] integerValue];
    return space;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    NSDictionary *infodic = self.p_classInfoArr[section];
    NSInteger space = [infodic[@"itemSpace"] integerValue];
    return space;
}





- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSDictionary *infodic = self.p_classInfoArr[section];
    NSInteger space = [infodic[@"sectionInset"] integerValue];
    return  UIEdgeInsetsMake(0, space, 5, space);
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic =  self.p_sectionHeadArr[section];
    if ([dic isKindOfClass:[NSNull class]]) {
        return CGSizeZero;
    }else{
        if (section ==4 && !self.firstModel.m_goodslist4.count) {
            return CGSizeMake(0, 0);
        }
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Ocean_FirstPageHeadView";
    NSDictionary *dic = self.p_sectionHeadArr[indexPath.section];
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        Ocean_FirstPageHeadView *cell = (Ocean_FirstPageHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        cell.p_info = dic;
        reusableview = cell;
        
    }
    return reusableview;
}






//功能按钮事件


-(void)FunctionCellClickItem:(UIButton *)button andClassinfo:(NSDictionary *)classInfo{
    UIViewController *vc = [NSClassFromString(classInfo[@"className"]) new];
    vc.title =classInfo[@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 调用接口
//首页数据接口
-(void)FIRSTPAGESHOW{
    [MBProgressHUD  showActivityMessageInWindow:@""];
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"FIRSTPAGESHOW" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        [weakSelf.collectionView.mj_header endRefreshing];
        if (!error) {
           Ocean_FIRSTPAGESHOWModel * respModel  = [Ocean_FIRSTPAGESHOWModel mj_objectWithKeyValues:respInfo];
            if ([respModel.ERRORCODE isEqualToString:@"0000"]) {
                weakSelf.firstModel = respModel;
//                weakSelf.firstModel.m_showios_4 = @"1";
                //m_showios_6:1是显示 0是不显示
                if (![weakSelf.firstModel.m_showios_6  integerValue]) {
                    weakSelf.firstModel.m_goodslist = [NSArray array];
                }else{
                    QSisCan = YES;
                }
            }else{
                [MBProgressHUD showTipMessageInView:respModel.ERRORDESTRIPTION];            
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.collectionView reloadData];

    }];
}
//轮播接口

-(void)MORENOTICE{
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"MORENOTICE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                weakSelf.p_announcementArr = [announcementModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_goodslist2"]];
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.collectionView reloadData];
    }];

}
//首页顶部轮播大图

-(void)FIRSTPAGE_CAROUSEPIC{

    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"FIRSTPAGE-CAROUSEPIC" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                NSArray *arr = [Ocean_MainPageBannerModel mj_objectArrayWithKeyValuesArray:respInfo[@"HEADPICLIST"]];
                self.p_bannerArr = arr;
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.collectionView reloadData];
    }];

}



-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];

}


#pragma mark - 功能按钮事件


//***********************************页面事件*************************************
//点击一组按钮事件

-(void)receviceGroupButtoEvent:(NSNotification *)not{
    groupButtonModel *model = not.object;
    //type : 1第三方链接，2商品分类，3商户用户申请
    switch ([model.m_type integerValue]) {
            case 1:
        {
            Ocean_UrlWebController *webvc = [[Ocean_UrlWebController alloc]init];
            webvc.m_url = model.m_url;
            webvc.title = model.m_name;
            [self.navigationController pushViewController:webvc animated:YES];
        }
            break;
          case 2:
        {
            Ocean_ClassifyController *classify = [[Ocean_ClassifyController alloc]init];
            classify.m_gcid = model.m_gcid;
            [self.navigationController pushViewController:classify animated:YES];
        }
            break;
            
            case 4:
        {
            Ocean_EnterStoreController *enterStoreVC =[[Ocean_EnterStoreController alloc]init];
            [self.navigationController pushViewController:enterStoreVC animated:YES];
        }
            break;
        case 5:
        {
            if (![Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
                [self presentViewController:LoginVC animated:YES completion:nil];
                return;
            }
            
            [self USINGTOOLSLISTWithType:6 withSuccess:^(KX9FirstPageProductModel *data) {
                Ocean_DishonestInquiryVC *dishonestVC =[[Ocean_DishonestInquiryVC alloc]init];
                dishonestVC.model = data;
                [self.navigationController pushViewController:dishonestVC animated:YES];
            }];
        }
            break;
        case 7:
        {
            Ocean_NewsLinkVC *newsVC =[[Ocean_NewsLinkVC alloc]init];
            [self.navigationController pushViewController:newsVC animated:YES];
        }
            break;
    }
    
    
}
#pragma mark - 公告事件
-(void)receviceAnnouncement:(NSNotification *)not{
//    announcementModel  *announcement= not.object;
    Ocean_ProclamationController *proVC = [[Ocean_ProclamationController alloc]init];
    [self.navigationController pushViewController:proVC animated:YES];
    
}
#pragma mark - 轮播图事件
-(void)bannerCellselectItemInfo:(Ocean_MainPageBannerModel *)bannerModel{
    switch ([bannerModel.m_flag integerValue]) {
        case 0:
        {
            if (!bannerModel.m_goodsid) {
                [MBProgressHUD showInfoMessage:@"暂无商品信息,请稍后再试!"];
                return;
            }

            Ocean_MainforceCommodityController *commodityVC = [[Ocean_MainforceCommodityController alloc]init];
            commodityVC.m_gid = bannerModel.m_goodsid;
            commodityVC.title = @"商品";
            [self.navigationController pushViewController:commodityVC animated:YES];
            
        }
            break;
            
        case 1:
        {
            Ocean_UrlWebController *urlweb = [[Ocean_UrlWebController alloc]init];
            urlweb.title = @"广告链接";
            urlweb.m_url = bannerModel.m_url;
            if([bannerModel.m_url checkURL]){
                [self.navigationController pushViewController:urlweb animated:YES];

            }
        }
            break;
        
        case 2:
        {
            Ocean_MainStoreController  *storeVC= [[Ocean_MainStoreController alloc]init];
            storeVC.title = @"商铺";
            shopInfoModel *model = [shopInfoModel new];
            model.m_gbid = bannerModel.m_bid;
            storeVC.m_shopInfo = model;
            if (!bannerModel.m_bid.length) {
                [MBProgressHUD showInfoMessage:@"暂无商户信息,请稍后再试!"];
                return;
            }
            
            [self.navigationController pushViewController:storeVC animated:YES];
            
        }break;
            
        case 3:
        {
            if (!bannerModel.m_nid.length) {
                return;
            }
            Ocean_ProclamationDetailController*detailVC = [[Ocean_ProclamationDetailController alloc]init];
            detailVC.m_id = bannerModel.m_nid;
            [self.navigationController pushViewController:detailVC animated:YES];
        }break;
    }
    
    
}
#pragma mark - 点击商铺/热门商品事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==4) {
        //点击商铺
        Ocean_MainStoreController *storeVC = [[Ocean_MainStoreController alloc]init];
        
        shopInfoModel *model =  self.firstModel.m_goodslist4[indexPath.item];
        storeVC.m_shopInfo = model;
        [self.navigationController pushViewController:storeVC animated:YES];
        
    }else if (indexPath.section ==3){
        //点击热门商品
        if (!self.firstModel.m_goodslist3.count) {
            [MBProgressHUD showInfoMessage:@"暂无商品,请稍后再试!"];
            return;
        }
        
        hotGoodsModel *model = self.firstModel.m_goodslist3[indexPath.item];
        Ocean_MainforceCommodityController *commodityVC = [[Ocean_MainforceCommodityController alloc]init];
        commodityVC.m_gid = model.m_gbid;
        [self.navigationController pushViewController:commodityVC animated:YES];
    }
    
    
}

-(void)headviewClickMoreMethod{

    Ocean_HotViewController *hotvc = [[Ocean_HotViewController alloc]init];
    [self.navigationController pushViewController:hotvc animated:YES];


}



//type:0公交地铁   1火车票   2驾驶扣分查  3身份证认证   4新华字典   5新闻链接   6失信人查询   7智能问答   8周公解梦   9物流   10IP地址   11手机号码
-(void)USINGTOOLSLISTWithType:(NSInteger)type withSuccess:(void(^)(KX9FirstPageProductModel *data))complete {
    
    MJWeakSelf;
    weakSelf.p_infoArr = [NSArray array];
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"USINGTOOLSLIST" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                weakSelf.p_infoArr = [KX9FirstPageProductModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_list"]];
                
                KX9FirstPageProductModel *model = self.p_infoArr[type];
                
                if (complete) {
                    complete(model);
                }
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
    
}


@end

//
//  Ocean_MainforceCommodityController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MainforceCommodityController.h"
#import "GoodsDetailView.h"
#import "GoodsDetailMainView.h"
#import "BottomView.h"
#import "ChoseView.h"
#import "Ocean_GoodsDetailCell.h"
#import "Ocean_GoodsDetailModel.h"
#import "Ocean_AddCartModel.h"
#import "Ocean_ShopCell.h"
#import "Ocean_ImageCell.h"
#import <YUSegment.h>
#import <MJRefreshAutoNormalFooter.h>
#import <MJRefreshNormalHeader.h>
#import "GoodDetailHeaderView.h"
#import "GoodDetailCommentBody.h"
#import "GoodCommentCell.h"
#import "Ocean_MainStoreController.h"
#import "ShoppingCartViewController.h"
#import "Ocean_ ShowCartModel.h"
#import "Ocean_OrderSureController.h"

@interface Ocean_MainforceCommodityController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,GoodDetailHeaderDelegate,Ocean_RevicedImageToolDelegate>
{
    UITableView *OneTable;
    BottomView *bottomView;
    ChoseView *choseView;
    Ocean_GoodsDetailModel *detail;
    Ocean_AddCartModel *addModel;
    
    BOOL isAddCar;
    
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockdic;//商品库存量
    CGPoint center;
}
@property (nonatomic, copy)NSString *type;
@property (nonatomic,strong) NSMutableArray * p_iamgeArr;
@property (nonatomic, strong)NSArray *comments;
@property (nonatomic, strong)GoodDetailHeaderView *headerView;

@end

@implementation Ocean_MainforceCommodityController
-(NSMutableArray *)p_iamgeArr{
    if (!_p_iamgeArr) {
        _p_iamgeArr = [NSMutableArray array];
    }
    return _p_iamgeArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super  viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sure:) name:@"finishChooseShop" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super  viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =@"商品详情";
    _type = @"1";
    
    self.view.backgroundColor = [UIColor whiteColor];
    _headerView = [[GoodDetailHeaderView alloc] init];
    _headerView.delegate = self;
    
    
  
    /** 第一页面 table*/
    OneTable = [[UITableView alloc] initWithFrame:CGRectMake(0,0, screen_Width, screen_Height - 47 ) style:UITableViewStylePlain];
    OneTable.separatorColor = [UIColor greenColor];
    OneTable.delegate = self;
    OneTable.dataSource = self;
    OneTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:OneTable];
    
    [OneTable registerClass:[Ocean_GoodsDetailCell class] forCellReuseIdentifier:@"GoodsDetailCell"];
    [OneTable registerClass:[Ocean_ShopCell class] forCellReuseIdentifier:@"ShopCell"];

    
    sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",nil];
    colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",nil];
    NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
    stockdic = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:str]];
    [self initBottomView];
    
    [self GET_GoddsEvaluateListInterface];

}

-(void)initBottomView
{
    
    bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-47, SCREEN_WIDTH, 47)];
    [self.view addSubview:bottomView];
    [bottomView.bt_service addTarget:self action:@selector(seleteService) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bt_shop addTarget:self action:@selector(seleteShop) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bt_collection addTarget:self action:@selector(seleteCollection:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bt_addBasket addTarget:self action:@selector(show1) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bottomView.bt_buyNow addTarget:self action:@selector(seleteBuy) forControlEvents:UIControlEventTouchUpInside];
}
-(void)initChoseViewSizeArr:(NSArray *)sizeArr andColorArr:(NSArray *)colorArr andStockDic:(NSDictionary *)stockDic andURL:(NSString *)url;
{
    addModel = [[Ocean_AddCartModel alloc] init];
    addModel.m_num = [NSNumber numberWithInteger:1];
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    choseView.model = addModel;
    [self.view addSubview:choseView];
    choseView.lb_price.text = detail.m_price;
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [choseView.bt_sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    
    
    [choseView initTypeView:sizeArr :colorArr :stockDic :url];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    
}
#pragma mark-bottom action
-(void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
-(void)seleteService
{
    [self showAlert:@"点击客服"];
}
-(void)seleteShop
{
    
    if (![Ocean_JudgeAlterView alterViewFrom:self]) {
        return;
    }
    
    ShoppingCartViewController *shopcardVC  = [[ShoppingCartViewController alloc]init];
    shopcardVC.title =@"购物车";
    shopcardVC.ispush = YES;
    
    [self.navigationController pushViewController:shopcardVC animated:YES];
}
-(void)seleteCollection:(UIButton *)btn
{
    if (btn.selected) {
        btn.selected = NO;
        [self showAlert:@"取消收藏"];
    }else
    {
        btn.selected = YES;
        [self showAlert:@"已收藏"];
    }
}
-(void)seleteBuy
{
    isAddCar = NO;
    [self show];
    
//    [self showAlert:@"立即购买"];
}
#pragma mark-goosdetail action
-(void)share
{
    [self showAlert:@"分享"];
}
-(void)goodsJudge
{
    [self showAlert:@"宝贝评价"];
}
#pragma mark-action
/**
 *  点击按钮弹出
 */

-(void)show1{
    
    isAddCar = YES;
    [self show];

}
-(void)show
{
    if (![Ocean_JudgeAlterView alterViewFrom:self]) {
        return;
    }
    
    
    center = OneTable.center;
    center.y -= 64;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        
        OneTable.center = center;
        OneTable.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        
        choseView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion: nil];
    
    //3.导航条上的自定义的子标签是否需要跟着隐藏.
    //self.isTitleAlpha = YES;
    //self.isLeftAlpha = YES;
    
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    center.y += 64;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        OneTable.center = center;
        OneTable.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        //OneTable.bt_addSize.headLabel.text = choseView.lb_detail.text;
    } completion: nil];
    
}
-(void)sure:(NSNotification *)not
{
    
  
    
    SizeModel *mdoel  = (SizeModel *)not.object;
    
    if (isAddCar) {
        [MBProgressHUD showActivityMessageInView:@""];
        [HttpRequestTools  requestUserInfoWithData:@{
                                                     @"m_gid":mdoel.m_gid,
                                                     @"m_dgid":mdoel.m_dgid,
                                                     @"m_num":addModel.m_num                                                   } methodName:@"ADDCART" completion:^(id respInfo, NSError *error) {
                                                         if (!error) {
                                                             [MBProgressHUD hideHUD];
                                                             if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"])
                                                             {
                                                                 //[weakSelf.view showBlankPageView:respInfo[@"ERRORDESTRIPTION"] andImageName:@"commentEmpty"];
                                                                 [MBProgressHUD showSuccessMessage:@"加入购物车成功!"];
                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
                                                             }else{
                                                                 //[weakSelf.view showBlankPageView: andImageName:@"commentEmpty"];
                                                                 [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
                                                                 
                                                             }
                                                         }else{
                                                             
                                                             [MBProgressHUD showErrorMessage:@"网络异常"];
                                                             
                                                         }
                                                         [self dismiss];
                                                         
                                                     }];

    }else{
    //立即购买
        
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        Ocean__ShowCartGoodsHead *count = [[Ocean__ShowCartGoodsHead alloc] init];
            count.m_bid = detail.m_bid;
            count.m_bname = detail.m_name;
            count.m_logo = detail.m_listpic;
            count.m_soldallnum = [NSString stringWithFormat:@"%d",detail.m_soldallnum];
            count.m_allnum = [NSString stringWithFormat:@"%d",detail.m_allnum];
        
        Ocean__ShowCartGoodsModel *good = [Ocean__ShowCartGoodsModel new];
        good.m_gid = mdoel.m_gid;
        good.m_listpic = mdoel.m_guige;
        good.m_title = detail.m_title;
        good.m_price = mdoel.m_price;
        good.m_num = [NSString stringWithFormat:@"%@",addModel.m_num];
        good.m_guigename = mdoel.m_title;
        good.m_aid = @"";
        good.m_dgid = mdoel.m_dgid;
        
        [good judgeObjectPropertyNull];
        
//        m_gid;
//        @property (nonatomic, strong)NSString *m_listpic;
//        @property (nonatomic, strong)NSString *m_title;
//        @property (nonatomic, strong)NSString *m_price;
//        @property (nonatomic, strong)NSString *m_num;
        
//        @property (nonatomic, strong)NSString *m_cprice;
//        @property (nonatomic, strong)NSString *m_guigename;
//        @property (nonatomic, strong)NSString *m_dgid;
//        @property (nonatomic, strong)NSString *m_kcnum;
//        @property (nonatomic, strong)NSString *m_limitnum;
//        @property (nonatomic, strong)NSString *m_aid;
//        @property (nonatomic, strong)NSString *m_shengyu;
        
        
//        @"m_shopid":head.m_bid,
//        @"m_shopName":head.m_bname,
//        @"m_goodsid":Goods.m_gid,
//        @"m_goodsguigeid":Goods.m_dgid,
//        @"m_goodsnum":Goods.m_num,
//        @"m_cardids":Goods.m_aid
//        
        count.m_goodslist =[@[good] mutableCopy];
        [count judgeObjectPropertyNull];
        Ocean_OrderSureController *ordersureVC = [[Ocean_OrderSureController alloc]init];
        ordersureVC.goodsArray = @[count];
        float price =  [good.m_price floatValue] *[good.m_num integerValue];
        ordersureVC.allPrice = [NSString stringWithFormat:@"¥%.2f",price];
        [self.navigationController pushViewController:ordersureVC animated:YES];
    }
    
    
    
//    NSString *str = [NSString stringWithFormat:@"%ld",[addModel.m_num integerValue]];
    
}
- (void)GET_GoddsEvaluateListInterface {
    
    MJWeakSelf;
    detail = [[Ocean_GoodsDetailModel alloc] init];
    [MBProgressHUD showActivityMessageInView:@""];
    
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_gid":self.m_gid} methodName:@"GOODSDETAIL" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"])
            {
                
                detail = [Ocean_GoodsDetailModel mj_objectWithKeyValues:respInfo];
                for (NSString *url in detail.m_detailpic) {
                    Ocean_RevicedImageTool *imageView = [[Ocean_RevicedImageTool alloc]initWithUrl:url];
                    imageView.delegate = self;
                    [self.p_iamgeArr addObject:imageView];
                }
                [self initChoseViewSizeArr:detail.m_showmenu andColorArr:colorarr andStockDic:detail.list1 andURL:detail.m_winlistpic[0]];
            }else{
                OneTable.hidden = YES;
                bottomView.hidden = YES;
                [weakSelf.view showBlankPageView:respInfo[@"ERRORDESTRIPTION"] andImageName:@"commentEmpty"];
            }
        }else{
            
//            [weakSelf.view showErrorPageView];
            [MBProgressHUD showErrorMessage:@"网络异常"];
        }
        
        [OneTable reloadData];
    }];
    

    
}

#pragma mark---------tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
           
            //return screen_Height - 64 - 47 - 200;
            return [tableView fd_heightForCellWithIdentifier:@"GoodsDetailCell" cacheByIndexPath:indexPath configuration:^(Ocean_GoodsDetailCell *cell)
                    {
                        cell.model = detail;
                    }];
            
        }
        else
        {
            if ([@"1" isEqualToString:detail.m_zytype]) {
                return 100;
            }
            return 80;
        }
    }
    else
    {
        if ([_type intValue] == 1) {
            
            UIImageView *imagev = self.p_iamgeArr[indexPath.row];
            UIImage *image = imagev.image;
            CGFloat W = image.size.width;
            CGFloat H = image.size.height;
            if ( W > 0) {
                H = screen_Width *H/W;
            }
            
            return H;
        } else {
            GoodDetailCommentModel *comment = _comments[indexPath.row];
            return [StringSizeModel sizeWithText:comment.m_content font:[UIFont systemFontOfSize:14] maxW:self.view.width - 30].height+90;
        }
    }

    
}
    

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else
    {
        if ([_type intValue] == 1) {
            return self.p_iamgeArr.count;
        } else {
            return _comments.count;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Ocean_GoodsDetailCell *cell = [Ocean_GoodsDetailCell cellWithTableView:tableView];
            cell.model = detail;
            return cell;
        }
        else
        {
            Ocean_ShopCell *cell = [Ocean_ShopCell cellWithTableView:tableView];
            cell.model = detail;
            return cell;
        }
        
    }
    else
    {
        if ([_type intValue] == 1) {
        Ocean_ImageCell *cell = [Ocean_ImageCell cellWithTableView:tableView];
        UIImageView *imageV = self.p_iamgeArr[indexPath.row];
        cell.imageView.image = imageV.image;
        return cell;
        }else {
            GoodCommentCell *cell = [GoodCommentCell cellWithTableView:tableView];
//            cell.userInteractionEnabled = NO;
            cell.comment = _comments[indexPath.row];
            return cell;
        }
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        return _headerView;


    }
    else
    {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }
    else
    {
        return 0;
    }
}
- (void)segmentedControlTapped:(YUSegmentedControl *)sender
{
    
}

-(void)RevicedImageReloadPreView{
    [OneTable reloadData];
}

-(void)headerButtonDidPressed:(NSInteger)index{
    _type = [NSString stringWithFormat:@"%zd", index];
    [OneTable reloadData];
    if (index ==1) {
        return;
    }
    [self GOODSEVALUATE];

}

-(void)GOODSEVALUATE{
    MJWeakSelf;
    
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_goodsid":self.m_gid} methodName:@"GOODSEVALUATE" completion:^(id respInfo, NSError *error) {
        GoodDetailCommentRespBody *respBody = [GoodDetailCommentRespBody mj_objectWithKeyValues:respInfo];
                if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
                    weakSelf.comments = respBody.EVALUATEINFO;
                } else {
                    [MBProgressHUD showWarnMessage:respBody.ERRORDESTRIPTION];
                }
        [OneTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];

    }];



}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section ==0&& indexPath.row ==1) {
        Ocean_MainStoreController *storeVC = [[Ocean_MainStoreController alloc]init];
        shopInfoModel *storeinfo = [[shopInfoModel alloc]init];
        storeinfo.m_name = detail.m_name;
        storeinfo.m_gbid = detail.m_bid;
        storeinfo.m_listpic = detail.m_listpic;
        storeinfo.m_allnum = [NSString stringWithFormat:@"%d",detail.m_allnum];
        storeinfo.m_soldnum = [NSString stringWithFormat:@"%d",detail.m_soldallnum];
        storeVC.m_shopInfo = storeinfo;
        [self.navigationController pushViewController:storeVC animated:YES];
    }

}



@end

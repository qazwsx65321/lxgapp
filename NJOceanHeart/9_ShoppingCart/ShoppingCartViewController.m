//
//  ShoppingCartViewController.m
//  TDS
//
//  Created by 黎金 on 16/3/24.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "Util.h"
#import "Header.h"
#import "ShoppingTableView.h"
#import "Ocean_ ShowCartModel.h"
#import "Ocean_OrderSureController.h"

@interface ShoppingCartViewController ()
{

    BOOL isbool;
    
    BOOL editbool;
    
    NSString *numString;
    
    ShoppingTableView *shopping;
    
    NSArray *cellArray;
    
    UIBarButtonItem *item;
    
    Ocean__ShowCartModel *goods;
    
    
    //总价
    NSString *totalNUm;
}
@end

@implementation ShoppingCartViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self loadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];

//    item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(EditBtn:)];
//    self.navigationItem.rightBarButtonItem = item;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"reload" object:nil];
    [self setInit];
    [self loadData];
}

-(void)setInit{

    numString = @"0";
    [Util setFoursides:_bottomView Direction:@"top" sizeW:SCREEN_WIDTH];
    [Util setFoursides:_naviView Direction:@"bottom" sizeW:SCREEN_WIDTH];
    
    
    shopping = [[ShoppingTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50 - 55) style:UITableViewStyleGrouped];
    if (self.ispush) {
        shopping.height +=44;
    }else{
        //20220406,适配大屏幕手机
        //CGFloat BHY =  screen_Height==812 ?40:0;
        CGFloat BHY =  screen_Height>=812 ?40:0;
        
        shopping.height -=BHY;
    }
    shopping.m_controller = self;
    [self.view addSubview:shopping];
    shopping.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        [shopping.mj_header endRefreshing];
    }];
    
    totalNUm = @"0";
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllPrice:) name:@"AllPrice" object:nil];
     [Util setUILabel:_allPriceLabel Data:@"总价: " SetData:@"￥0.00" Color:BACKGROUNDCOLOR Font:15 Underline:NO];
  
}

#pragma mark 通知
- (void)AllPrice:(NSNotification *)text{

    _allPriceLabel.text = [NSString stringWithFormat:@"总价: %@",text.userInfo[@"allPrice"]];
     [Util setUILabel:_allPriceLabel Data:@"总价: " SetData:text.userInfo[@"allPrice"] Color:BACKGROUNDCOLOR Font:15 Underline:NO];
    
    numString = text.userInfo[@"num"];
    
    totalNUm = text.userInfo[@"allPrice"];
    
    [self setTlementLabel];
    [self setAllBtnState:[text.userInfo[@"allState"]  isEqual: @"YES"]?NO:YES];
    
    cellArray =  text.userInfo[@"cellModel"];
}

#pragma mark 设置结算按钮状态
-(void)setTlementLabel{

    NSString *string = editbool?@"删除":@"结算";
    _settlementLabel.text = [NSString stringWithFormat:@"%@(%@)",string,numString];
}

#pragma mark 数据
-(void)setData{


   
//    NSDictionary *dicts = @{
//                            @"item":@[
//                                @{
//                                    @"headID":@"10",
//                                    @"headState":@1,
//                                    @"discount":@"9",
//                                    @"headCellArray":@[
//                                            @{
//                                                @"imageUrl":@"headurl.png",
//                                                @"title":@"韩版宽松杂色马海毛休闲",
//                                                @"color":@"浅蓝",
//                                                @"size":@"s",
//                                                @"price":@"100.00",
//                                                @"numInt":@1,
//                                                @"inventoryInt":@10,
//                                                @"mustInteger":@1,
//                                                @"ID":@"10",
//                                                },
//                                            @{
//                                                
//                                                @"imageUrl":@"headurl.png",
//                                                @"title":@"韩版宽松杂色马海毛休闲",
//                                                @"color":@"浅蓝",
//                                                @"size":@"s",
//                                                @"price":@"100.00",
//                                                @"numInt":@2,
//                                                @"inventoryInt":@10,
//                                                @"mustInteger":@1,
//                                                @"ID":@"11",
//                                                },
//                                            @{
//                                                
//                                                @"imageUrl":@"headurl.png",
//                                                @"title":@"韩版宽松杂色马海毛休闲",
//                                                @"color":@"浅蓝",
//                                                @"size":@"s",
//                                                @"price":@"100.00",
//                                                @"numInt":@2,
//                                                @"inventoryInt":@10,
//                                                @"mustInteger":@0,
//                                                @"ID":@"12",
//                                                },
//                                            ]
//                                        
//                                    },
//                                @{
//                                    @"headID":@"11",
//                                    @"headState":@1,
//                                    @"discount":@"9",
//                                    @"headCellArray":@[
//                                            @{
//                                                @"imageUrl":@"headurl.png",
//                                                @"title":@"韩版宽松杂色马海毛休闲",
//                                                @"color":@"浅蓝",
//                                                @"size":@"s",
//                                                @"price":@"100.00",
//                                                @"numInt":@2,
//                                                @"inventoryInt":@10,
//                                                @"mustInteger":@1,
//                                                @"ID":@"13",
//                                                },
//                                            @{
//                                                
//                                                @"imageUrl":@"headurl.png",
//                                                @"title":@"韩版宽松杂色马海毛休闲",
//                                                @"color":@"浅蓝",
//                                                @"size":@"s",
//                                                @"price":@"100.00",
//                                                @"numInt":@2,
//                                                @"inventoryInt":@10,
//                                                @"mustInteger":@0,
//                                                @"ID":@"14",
//                                                },
//                                            ]
//                                    
//                                    },
//                                @{
//                                    @"headID":@"10",
//                                    @"headState":@1,
//                                    @"discount":@"9",
//                                    @"headCellArray":@[
//                                            @{
//                                                @"imageUrl":@"headurl.png",
//                                                @"title":@"韩版宽松杂色马海毛休闲",
//                                                @"color":@"浅蓝",
//                                                @"size":@"s",
//                                                @"price":@"100.00",
//                                                @"numInt":@2,
//                                                @"inventoryInt":@10,
//                                                @"mustInteger":@0,
//                                                @"ID":@"15",
//                                                },
//                            
//                                            ]
//                                    
//                                    },
//                                @{
//                                    @"headID":@"10",
//                                    @"headState":@0,
//                                    @"discount":@"9",
//                                    @"headCellArray":@[
//                                            @{
//                                                @"imageUrl":@"headurl.png",
//                                                @"title":@"韩版宽松杂色马海毛休闲",
//                                                @"color":@"浅蓝",
//                                                @"size":@"s",
//                                                @"price":@"100.00",
//                                                @"numInt":@2,
//                                                @"inventoryInt":@10,
//                                                @"mustInteger":@0,
//                                                @"ID":@"16",
//                                                },
//                                            
//                                            ]
//                                    
//                                    },
//                                
//                                
//                                ]
//                            };
//    
//    
//    NSMutableArray *arrayl = [[NSMutableArray alloc] init];
//    for (NSDictionary *dict in dicts[@"item"]) {
//        
//        //NSMutableArray *dictarray = [[NSMutableArray alloc] init];
//        ShoppingModel *model = [[ShoppingModel alloc] initWithShopDict:dict];
//        //[dictarray addObject:model];
//        [arrayl addObject:model];
//        
//    }
    
    shopping.shoppingArray = [NSMutableArray arrayWithArray:goods.SHOPPINGCARTINFO];
    shopping.bottom = self.bottomView;
    
}

#pragma mark 编辑
- (IBAction)EditBtn:(UIButton *)sender {

    if (editbool) {
        
        [shopping editBtn:editbool];
        editbool = NO;
    }else{
    
        
        [shopping editBtn:editbool];
        editbool = YES;
    }
    [item setTitle:editbool?@"完成":@"编辑"];
    [_editLabel setTitle:editbool?@"完成":@"编辑" forState:UIControlStateNormal];
    [self setTlementLabel];
    _allPriceLabel.hidden = editbool;
    
}

#pragma mark 返回
- (IBAction)ReturnBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma 全选
- (IBAction)AllBtn:(UIButton *)sender {
    
    [shopping allBtn:!isbool];
}

#pragma mark 全选
-(void)setAllBtnState:(BOOL)_bool{

    if (_bool) {
        
        _allImage.image = [UIImage imageNamed:@"iconfont-yuanquan"];
        isbool = NO;
        
    }else{
        
        _allImage.image = [UIImage imageNamed:@"iconfont-zhengque"];
        isbool = YES;
    }
}

#pragma mark 结算
- (IBAction)SettlementBtn:(UIButton *)sender {
    
    if (editbool) {
        
        [shopping deleteBtn:editbool];
        
    }else{
    
        
        if (!cellArray.count || [totalNUm isEqualToString:@"￥0.00"]) {
            [MBProgressHUD showWarnMessage:@"请选择商品!"];
            return;
        }
        NSLog(@"结算:%@ ",cellArray);
        
        NSMutableArray *jiesuanArr = [[NSMutableArray alloc] initWithCapacity:100];
        NSUInteger i = goods.SHOPPINGCARTINFO.count;
        for (Ocean__ShowCartGoodsHead *head in goods.SHOPPINGCARTINFO) {
            Ocean__ShowCartGoodsHead *count = [[Ocean__ShowCartGoodsHead alloc] init];
            count.m_bid = head.m_bid;
            count.m_bid = head.m_bid;
            count.m_bname = head.m_bname;
            count.m_logo = head.m_logo;
            count.m_soldallnum = head.m_soldallnum;
            count.m_allnum = head.m_allnum;
            count.m_goodslist = [[NSMutableArray alloc] initWithCapacity:100];
            for (Ocean__ShowCartGoodsModel *good in cellArray) {
                    if (good.section == [goods.SHOPPINGCARTINFO indexOfObject:head]) {
                        [count.m_goodslist addObject:good];
                    }
            }
            if (count.m_goodslist.count) {
                [jiesuanArr addObject:count];
            }
        }
        
        Ocean_OrderSureController *sureVC = [[Ocean_OrderSureController alloc] init];
        sureVC.goodsArray = jiesuanArr;
        sureVC.allPrice = totalNUm;
        [self.navigationController pushViewController:sureVC animated:YES];
        
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



//- (void)DELETECARTWithGoodsid:(NSString *)goodsid withGuigeid:(NSString *)guigeid {
//    
//    NSDictionary *dic = @{
//                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
//                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
//                          @"m_goodsid":goodsid,
//                          @"m_guigeid":guigeid
//                          };
//    
//    [HttpRequestTools requestUserInfoWithData:dic methodName:@"" completion:^(id respInfo, NSError *error) {
//        if (!error) {
//            
//            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
//                
//                [self loadData];
//                
//            }else {
//                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
//            }
//            
//        }else {
//            [MBProgressHUD showErrorMessage:@"服务器异常!"];
//        }
//    }];
//    
//    
//}



- (void)loadData
{
    
    if (![Ocean_UserInfo sharedOcean_UserInfo].isLogin) {
        [MBProgressHUD showWarnMessage:@"尚未登录!"];
        return;
    }

    goods = [[Ocean__ShowCartModel alloc] init];
    [shopping hideBlankPageView];
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                                                   @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session
                                                   } methodName:@"SHOWCART" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"])
            {
                goods = [Ocean__ShowCartModel mj_objectWithKeyValues:respInfo];
                _bottomView.hidden = NO;
                [self setData];
                [shopping reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jisuan" object:nil];
                

            }else{
                goods.SHOPPINGCARTINFO = [[NSArray alloc] init];
                _bottomView.hidden = YES;
                [self setData];
                [shopping reloadData];
                
                
                [shopping showBlankPageView:@"购物车没有商品" andImageName:@"commentEmpty"];
                UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
                [shopping addGestureRecognizer:rec];
            }
        }else{
            [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
                _bottomView.hidden = YES;
        }
    }];
}
-(void)tapAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"guangjie" object:nil];;
}
-(void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
@end

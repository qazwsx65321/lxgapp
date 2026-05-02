//
//  GoodDetailViewController.m
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "GoodDetailBody.h"
#import "GoodDetailBannerCell.h"
#import "GoodDetailInfoCell.h"
#import "GoodImageInfoCell.h"
#import "GoodCommentCell.h"
#import "GoodDetailHeaderView.h"
#import "GoodDetailCommentBody.h"
#import "GoodDetailBottomView.h"
#import "Ocean_GoodsStandardCell.h"

//#import "CartViewController.h"
//#import "ConfirmOrderViewController.h"
//#import "CartBody.h"
//#import "AddToCartBody.h"
//#import "LoginViewController.h"
//#import "RootViewController.h"

@interface GoodDetailViewController ()<UITableViewDelegate, UITableViewDataSource, GoodDetailHeaderDelegate, GoodDetailBottomDelegate, Ocean_GoodsStandardCellDelegate,Ocean_RevicedImageToolDelegate>
{
    CGFloat standardCellH;
}
@property (nonatomic, copy)NSString *type;
@property (nonatomic, strong)NSArray *goodInfo;
@property (nonatomic, strong)NSArray *comments;
@property (nonatomic, strong)GoodDetailHeaderView *headerView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)GoodSpecModel *spec;
@property (nonatomic,strong) NSMutableArray * p_iamgeArr;
@end

static  NSString *infoCell = @"GoodDetailInfoCell";
static  NSString *ImageCell = @"ImageCell";

@implementation GoodDetailViewController


-(NSMutableArray *)p_iamgeArr{
    if (!_p_iamgeArr) {
        _p_iamgeArr = [NSMutableArray array];
    }
    return _p_iamgeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _type = @"1";
    self.title = @"商品详情";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 36, 36);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    [self getGoodDetailInfo];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 44) style:UITableViewStylePlain];
    self.tableView.delegate = self;;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor lightlightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightlightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    _headerView = [[GoodDetailHeaderView alloc] init];
    _headerView.delegate = self;
    
    
    
    GoodDetailBottomView *bottomView = [[GoodDetailBottomView alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    bottomView.delegate = self;
    [self.view addSubview: bottomView];
    [self.tableView registerClass:[GoodDetailInfoCell class] forCellReuseIdentifier:infoCell];
    [self.tableView registerClass:[GoodImageInfoCell class] forCellReuseIdentifier:ImageCell];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
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
            GoodDetailBannerCell *cell = [GoodDetailBannerCell cellWithTableView:tableView];
            GoodDetailRespBody *goodDetail = [_goodInfo firstObject];
            cell.images = goodDetail.m_winlistpic;
            return cell;
        } else if(indexPath.row==1){
            
            GoodDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCell];
            cell.goodDetail = [_goodInfo firstObject];
            return cell;
        }else{
            Ocean_GoodsStandardCell *cell = [Ocean_GoodsStandardCell cellWithTableView:tableView];
            cell.goodDetail = [_goodInfo firstObject];
            cell.delegate = self;
            return cell;
        }
    } else {
        if ([_type intValue] == 1) {
            GoodImageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCell];
            UIImageView *imageV = self.p_iamgeArr[indexPath.row];
            cell.imageView.image = imageV.image;
            return cell;
        } else {
            GoodCommentCell *cell = [GoodCommentCell cellWithTableView:tableView];
            
            cell.comment = _comments[indexPath.row];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.view.width;
        } else if(indexPath.row==1){
            
            return [tableView fd_heightForCellWithIdentifier:infoCell cacheByIndexPath:indexPath configuration:^(GoodDetailInfoCell *cell)
                    {
                        cell.goodDetail = [_goodInfo firstObject];
                    }];
            
        }else{
            
            return standardCellH;
            
            
        }
    } else {
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

- (void)StandardCellInfoDidSelectedItem:(GoodSpecModel *)spec{


}

-(void)standardCellGetstandardNum:(CGFloat)standardH{
    standardCellH = standardH;
    [self.tableView reloadData];

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return _headerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)share
{
//    GoodDetailModel *good = [_goodInfo firstObject];
//    [RootViewController shareWithTitle:good.m_title thumbImage:[good.m_lunbopic firstObject] text:good.m_title];
}

- (void)headerButtonDidPressed:(NSInteger)index
{
    _type = [NSString stringWithFormat:@"%zd", index];
    [self getCommentInfo];
}


- (void)goodDetailDidGoBuy
{
//    if (![UserInfo sharedUserInfo].isLogin) {
//        [MBProgressHUD showTip:@"请先登录"];
//        LoginViewController *controller = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
//        return;
//    }
//    
//    if (!_spec) {
//        [MBProgressHUD showTip:@"请选择规格"];
//        return;
//    }
//    
//   
//    
//    
//    
//    GoodDetailModel *good = [_goodInfo firstObject];
//    CartModel *cart = [[CartModel alloc] init];
//    cart.m_price = good.m_aprice;
//    cart.m_name = good.m_title;
//    cart.m_picturelist = [good.m_lunbopic firstObject];
//    cart.m_kucun = good.m_allKucun;
//    cart.m_goodsid = good.m_id;
//    GoodSpecModel *spec = [good.m_guige firstObject];
//    cart.m_guigeid = spec.m_guigeid;
//    cart.m_shengyu = good.m_allKucun;
//    cart.m_goodsnum = @"1";
//    
//    NSDictionary *dict = @{
//                           @"JUDGEMETHOD":@"NOW-BUY-JUGELIMITNUMS",
//                           @"m_goodsid":cart.m_goodsid,
//                           @"m_num":@1,
//                           @"m_guigeid":cart.m_guigeid,
//                           @"m_name":[UserInfo sharedUserInfo].userid,
//                           @"m_userid":[UserInfo sharedUserInfo].uuid,
//                           @"m_session":[UserInfo sharedUserInfo].session,
//                           
//                           };
//   
//    [HessianRequest requestWithData:dict completion:^(id respInfo, NSError *error) {
//        if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
//            ConfirmOrderViewController *controller = [[ConfirmOrderViewController alloc] init];
//            controller.from = @"detail";
//            controller.goods = @[cart];
//            [self.navigationController pushViewController:controller animated:YES];
//        } else {
//            [MBProgressHUD showTip:respInfo[@"ERRORDESTRIPTION"]];
//        }
//    }];
}

- (void)goodDetailDidAddToCart
{
    
//    if (![UserInfo sharedUserInfo].isLogin) {
//        [MBProgressHUD showTip:@"请先登录"];
//        LoginViewController *controller = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
//        return;
//    }
    
    if (!_spec) {
//        [MBProgressHUD showTip:@"请选择规格"];
        return;
    }
//
//    GoodDetailModel *good = [_goodInfo firstObject];
//    AddToCartReqBody *reqBody = [AddToCartReqBody new];
//    reqBody.JUDGEMETHOD = @"YIKAOLAMART-ADDCART";
//    reqBody.m_name = [UserInfo sharedUserInfo].userid;
//    reqBody.m_userid = [UserInfo sharedUserInfo].uuid;
//    reqBody.m_session = [UserInfo sharedUserInfo].session;
//    reqBody.m_goodsid = good.m_id;
//    reqBody.m_guigeid = _spec.m_guigeid;
//    reqBody.m_num = 1;
//    
//    [HessianRequest requestWithData:[reqBody mj_keyValues] completion:^(id respInfo, NSError *error) {
//        AddToCartRespBody *respBody = [AddToCartRespBody mj_objectWithKeyValues:respInfo];
//        if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
//            [MBProgressHUD showTip:respBody.ERRORDESTRIPTION];
//        } else {
//            [MBProgressHUD showTip:respBody.ERRORDESTRIPTION];
//        }
//    }];
}

- (void)goodDetailDidGoCart
{
//    if (![UserInfo sharedUserInfo].isLogin) {
//        [MBProgressHUD showTip:@"请先登录"];
//        LoginViewController *controller = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
//        return;
//    }
//    CartViewController *controller = [[CartViewController alloc] init];
//    controller.from = @"detail";
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)getGoodDetailInfo
{
    
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_gid":self.goodId} methodName:@"GOODSDETAIL" completion:^(id respInfo, NSError *error) {
        if (!error) {
        GoodDetailRespBody *respBody = [GoodDetailRespBody mj_objectWithKeyValues:respInfo];
            if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
                _goodInfo = @[respBody];
                for (NSString *url in respBody.m_detailpic) {
                    Ocean_RevicedImageTool *imageView = [[Ocean_RevicedImageTool alloc]initWithUrl:url];
                    imageView.delegate = self;
                    [self.p_iamgeArr addObject:imageView];
                }
                
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.tableView reloadData];
    }];
    
//    GoodDetailReqBody *reqBody = [GoodDetailReqBody new];
//    reqBody.JUDGEMETHOD = @"YIKAOLAMART-GOODSDETAILINFO";
//    reqBody.m_goodsid = _goodId;
//    [HessianRequest requestWithData:[reqBody mj_keyValues] completion:^(id respInfo, NSError *error) {
//        GoodDetailRespBody *respBody = [GoodDetailRespBody mj_objectWithKeyValues:respInfo];
//        if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
//            _goodInfo = respBody.GOODSDTAILINFO;
//            [self.tableView reloadData];
//        } else {
//            [MBProgressHUD showTip:respBody.ERRORDESTRIPTION];
//        }
//    }];
    
    
}

- (void)getCommentInfo
{
//    GoodDetailCommentReqBody *reqBody = [GoodDetailCommentReqBody new];
//    reqBody.JUDGEMETHOD = @"YIKAOLAMART-GOODSEVALUATE";
//    reqBody.m_goodsid = _goodId;
//    [HessianRequest requestWithData:[reqBody mj_keyValues] completion:^(id respInfo, NSError *error) {
//        GoodDetailCommentRespBody *respBody = [GoodDetailCommentRespBody mj_objectWithKeyValues:respInfo];
//        if ([respBody.ERRORCODE isEqualToString:@"0000"]) {
//            _comments = respBody.EVALUATEINFO;
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
//        } else {
//            _comments = @[];
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
//            if ([_type isEqualToString:@"2"]) {
//                [MBProgressHUD showTip:respBody.ERRORDESTRIPTION];
//            }
//        }
//    }];
}

-(void)RevicedImageReloadPreView{

    [self.tableView reloadData];

}

@end

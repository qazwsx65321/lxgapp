//
//  Ocean_FindMeViewController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FindMeViewController.h"
#import "DCClassGoodsItem.h"
#import "Ocean_ZFDropDown.h"
#import "ZFTapGestureRecognizer.h"
#import "Ocean_FindMelistModel.h"
#import "Ocean_FindMeListCell.h"
#import "Ocean_MainStoreController.h"

#import "XRCF_Common_Way.h"     //20210221

@interface Ocean_FindMeViewController ()<ZFDropDownDelegate,UITableViewDelegate,UITableViewDataSource,ZFTapGestureRecognizerDelegate>
{

    NSString *m_cid;
    NSString *m_flag;
    NSString *coordinatex;
    NSString *coordinatey;
    BOOL isReload;

}
@property (nonatomic,weak) UIButton * p_weakButton;
@property (nonatomic,strong) NSArray * m_classArr;
@property (nonatomic, strong) Ocean_ZFDropDown * dropDown;
@property (nonatomic, strong) Ocean_ZFDropDown * dropDown2;
@property (nonatomic, strong) ZFTapGestureRecognizer * tap;
@property (nonatomic,strong) NSMutableArray * p_showInfoArr;
@property (nonatomic,strong) NSArray * p_showInfoArr2;
@property (nonatomic,strong) NSArray * p_findListArr;
@property (nonatomic,weak) UITableView * tableView;
@end

@implementation Ocean_FindMeViewController

static NSString *listCellId = @"Ocean_FindMeListCell";


-(NSArray *)p_showInfoArr2{
    if (!_p_showInfoArr2) {
        _p_showInfoArr2 = @[@"由远到近",@"由近到远"];
    }
    return _p_showInfoArr2;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MBProgressHUD hideHUD];
    if (!isReload)return;
    isReload = YES;

    [[KX9UploadLocation sharedKX9UploadLocation]startLocationGetLongitudeAndLatitude:^(CLLocationCoordinate2D coord, NSError *LocationServiceError) {
        if (LocationServiceError) {
            [MBProgressHUD showWarnMessage:@"暂时获取不到位置信息"];
        }else{
            coordinatex = [NSString stringWithFormat:@"%lf",coord.longitude];
            coordinatey = [NSString stringWithFormat:@"%lf",coord.latitude];
            
        }
    }];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"FindeME####################----%@------",NSStringFromCGRect(self.navigationController.navigationBar.frame));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat XHY =  screen_Height==812 ?88:64;
    
    //20210221 add
    XRCF_Common_Way * commonway=[[XRCF_Common_Way alloc]init];
    NSInteger subheightdata = [commonway GetFitScreenSubValue];
    XHY =  XHY + subheightdata;

    
    self.dropDown = [[Ocean_ZFDropDown alloc] initWithFrame:CGRectMake(0, XHY, self.view.width/2 , 45) pattern:kDropDownPatternDefault];
    self.dropDown.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.dropDown.topicButton setTitle:@"商户类型" forState:UIControlStateNormal];
    self.dropDown.cellTextColor = RGB(147, 147, 147);
    self.dropDown.topicButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    self.navigationItem.title =@"周边";
    
//    self.dropDown.cornerRadius = 10.f;
    self.dropDown.borderStyle = kDropDownTopicBorderStyleSingleLine;
    self.dropDown.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.dropDown.cellTextAlignment = NSTextAlignmentCenter;
    self.dropDown.tableViewBackgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.dropDown];
    
    self.dropDown2 = [[Ocean_ZFDropDown alloc] initWithFrame:CGRectMake(self.view.width/2,XHY, self.view.width/2, 45) pattern:kDropDownPatternDefault];
    self.dropDown2.delegate = self;
    [self.dropDown2.topicButton setTitle:@"商户距离" forState:UIControlStateNormal];
    self.dropDown2.topicButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.dropDown2.borderStyle = kDropDownTopicBorderStyleSingleLine;
//    self.dropDown2.cornerRadius = 10.f;
    self.dropDown2.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.dropDown2.cellTextFont = [UIFont boldSystemFontOfSize:16.f];
    self.dropDown2.cellTextColor = RGB(147, 147, 147);
    [self.view addSubview:self.dropDown2];
    self.dropDown2.cellTextAlignment = NSTextAlignmentCenter;
    self.dropDown2.tableViewBackgroundColor = [UIColor whiteColor];

   
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ONETYPE:) name:@"ChooseOcean_ZFDropDown" object:nil];
    
    //20220406，适配大屏幕手机
    //CGFloat THY =  screen_Height==812 ?22:0;
    CGFloat THY =  screen_Height>=812 ?22:0;

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.dropDown2.bottom, screen_Width,screen_Height - self.dropDown2.bottom-50-THY) style:UITableViewStylePlain];
    [self.view addSubview:table];
//    table.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    [table registerClass:[Ocean_FindMeListCell class] forCellReuseIdentifier:listCellId];
    table.delegate  =self;
    table.tableFooterView = [[UIView alloc]init];
    table.dataSource = self;
    self.tableView = table;
    MJWeakSelf;
    [[KX9UploadLocation sharedKX9UploadLocation]startLocationGetLongitudeAndLatitude:^(CLLocationCoordinate2D coord, NSError *LocationServiceError) {
        if (LocationServiceError) {
            
        }else{
            coordinatex = [NSString stringWithFormat:@"%lf",coord.longitude];
            coordinatey = [NSString stringWithFormat:@"%lf",coord.latitude];
            m_cid = @"";
            m_flag = @"0";
            [weakSelf NEARYSHOP];
        }
    }];
    
    [table configReloadAction:^{
        
        [weakSelf  NEARYSHOP];
        
    }];
    self.tap = [[ZFTapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.tap.ZFTapGestureDelegate = self;
    [self.view addGestureRecognizer:self.tap];
}
- (void)tapAction{
    [self.dropDown resignDropDownResponder];
    [self.dropDown2 resignDropDownResponder];
}


-(BOOL)ZFTapGestureRecognizerresponseGesture{
    
    if (self.dropDown.tableViewContainerView.hidden && self.dropDown2.tableViewContainerView.hidden) {
        return NO;
    }else{
        return YES;
    }

}


#pragma mark tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.p_findListArr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

   return  [tableView fd_heightForCellWithIdentifier:listCellId cacheByIndexPath:indexPath configuration:^(Ocean_FindMeListCell * cell) {
       
       cell.model = self.p_findListArr[indexPath.row];
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Ocean_FindMeListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellId forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.model = self.p_findListArr[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Ocean_MainStoreController *storevc = [[Ocean_MainStoreController alloc]init];
    Ocean_FindMelistModel  *model = self.p_findListArr[indexPath.row];
    shopInfoModel *shopinfo = [shopInfoModel new];
    shopinfo.m_name = model.m_name;
    shopinfo.m_gbid = model.m_bid;
    shopinfo.m_listpic = model.m_listpic;
    shopinfo.m_allnum = model.m_allnum;
    shopinfo.m_soldnum = model.m_soldallnum;
    storevc.m_shopInfo = shopinfo;
    [self.navigationController pushViewController:storevc animated:YES];
    

}

#pragma mark ZFDropDownDelegate

- (NSArray *)itemArrayInDropDown:(ZFDropDown *)dropDown{
    if (dropDown == self.dropDown) {
        return self.p_showInfoArr;
    }
    return self.p_showInfoArr2;
}


- (NSUInteger)numberOfRowsToDisplayIndropDown:(ZFDropDown *)dropDown itemArrayCount:(NSUInteger)count{
    if (dropDown == self.dropDown) {
        return (screen_Height -158)/44;
    }
    return self.p_showInfoArr2.count;
}

- (void)dropDown:(Ocean_ZFDropDown *)dropDown didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (dropDown == self.dropDown) {
        if (!indexPath.row) {
            [dropDown.topicButton setTitle:@"商户类型" forState:UIControlStateNormal];
        }
        
        if (indexPath.row == self.dropDown.m_index) {
            return;
        }
    }else{
        
        if (indexPath.row == self.dropDown2.m_index) {
            return;
        }
        
    }
    
    dropDown.m_index = indexPath.row;
    NSInteger cloum1 = self.dropDown.m_index?1:0;
    NSInteger cloum2 = self.dropDown2.m_index;
    NSInteger flagnum = cloum1 *2 +cloum2;
    
    NSInteger cloum1Index =  self.dropDown.m_index;
    m_cid = @"";
    m_flag = [NSString  stringWithFormat:@"%d",flagnum];
    if (cloum1Index) {
        DCClassGoodsItem *itemInfo = self.m_classArr[cloum1Index-1];
        m_cid = itemInfo.m_cid;
    }
    [self NEARYSHOP];
}


#pragma mark ServerInterFace;

-(void)NEARYSHOP{
    
    MJWeakSelf;
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:m_cid,@"m_cid",
                         m_flag,@"m_flag",
                         coordinatex,@"m_coordinatex",
                         coordinatey,@"m_coordinatey",nil];
    
    weakSelf.p_findListArr = nil;
    [MBProgressHUD showActivityMessageInWindow:@""];
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"NEARYSHOP" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        [weakSelf.tableView hideBlankPageView];
        [weakSelf.tableView hideErrorPageView];

        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                weakSelf.p_findListArr =[Ocean_FindMelistModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_courselist"]];
                
            }else{
            [weakSelf.tableView showBlankPageView:respInfo[@"ERRORDESTRIPTION"] andImageName:@"commentEmpty"];
            }
        }else{
            [weakSelf.tableView  showErrorPageView];
           

        }
        
        [weakSelf.tableView reloadData];
        
    }];
    
    
}

-(void)ONETYPE:(NSNotification *)not{
    Ocean_ZFDropDown *dropDownView = not.object;
    MJWeakSelf;
    if (self.p_showInfoArr.count) {
        [dropDownView show];
        [dropDownView reloadData];
        return;
    }
    [MBProgressHUD showActivityMessageInView:@""];
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"BUSINESSCLASSLIST" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                
                
                weakSelf.m_classArr =  [DCClassGoodsItem mj_objectArrayWithKeyValuesArray:respInfo[@"m_buscalist"]];
                NSMutableArray *mutalArr = [NSMutableArray array];
                for (DCClassGoodsItem *item in weakSelf.m_classArr) {
                    [mutalArr addObject:item.m_name];
                }
                self.p_showInfoArr = mutalArr;
                [self.p_showInfoArr insertObject:@"默认" atIndex:0];
                [dropDownView show];
                [dropDownView reloadData];
            }else{
                
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
}

//
//-(void)BUSINESSCLASSLIST{
//    MJWeakSelf;
//    [MBProgressHUD showActivityMessageInView:@""];
//    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"BUSINESSCLASSLIST" completion:^(id respInfo, NSError *error) {
//        [MBProgressHUD hideHUD];
//        if (!error) {
//            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
//                NSArray *classArr = [Ocean_businessClassModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_buscalist"]];
//                weakSelf.p_classInfoArr = classArr;
//                NSMutableArray *mutalArr = [NSMutableArray array];
//                for (Ocean_businessClassModel *model in classArr) {
//                    [mutalArr addObject:model.m_name];
//                }
//                weakSelf.p_pickClassView.infoArr = mutalArr;
//                [weakSelf.p_pickClassView showListView];
//                
//            }else{
//                [MBProgressHUD showTipMessageInWindow:respInfo[@"ERRORDESTRIPTION"]];
//            }
//        }else{
//            [MBProgressHUD showErrorMessage:@"网路问题..."];
//        }
//    }];
//}
//
//

@end

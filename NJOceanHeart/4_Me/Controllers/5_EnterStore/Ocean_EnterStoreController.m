//
//  Ocean_EnterStoreController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_EnterStoreController.h"
#import "Ocean_StoreIDCell.h"
#import "Ocean_StoreInputMessageCell.h"
#import "Ocean_storeHeadInfoCell.h"
#import "Ocean_EnterStoreModel.h"
#import "Ocean_StoreIntroduceCell.h"
#import "Ocean_storeCheckBoxsCell.h"
#import "XRNextPreCell.h"
#import "ServiceLocationController.h"
#import "Ocean_EnterStoreCheckController.h"
#import "Ocean_ProtocolBoxCell.h"
#import "Ocean_EnterStoreProtolController.h"
#import "Ocean_EnterStorePayController.h"
#import "ZmjPickView.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "Ocean_businessClassModel.h"
#import "WPP_PickView.h"

//20260501 remark
//#import <BRPickerView.h>
#import "BRPickerView.h"

#import "Ocean_UploadCerCell.h"
@interface Ocean_EnterStoreController ()<XRNextPreCellDelegate,SlectLocationDelegate,Ocean_ProtocolBoxCellDelegate,BMKGeoCodeSearchDelegate,WPP_PickViewDelegate>
{
    BOOL sign;
    BOOL isAgreement;
}

@property (nonatomic,strong) NSMutableArray * p_EnterStoreArr;

@property (nonatomic,strong) Ocean_EnterStoreModel * postModel;

@property (nonatomic,strong) NSDictionary *storeInfo;

@property (nonatomic,strong) NSMutableDictionary * waringDic;

@property (nonatomic,strong) ZmjPickView * p_pickerArea;

@property (nonatomic,strong) BMKGeoCodeSearch * searcher;

@property (nonatomic,strong)UIView *tableHeadView;

@property (nonatomic,strong) WPP_PickView * p_pickClassView;

@property (nonatomic,strong) NSArray * p_classInfoArr;

@end

@implementation Ocean_EnterStoreController

-(WPP_PickView *)p_pickClassView{
    if (!_p_pickClassView) {
        _p_pickClassView = [[WPP_PickView alloc]init];
        _p_pickClassView.delegate = self;
        _p_pickClassView.titleName = @"请选择店铺分类";
    }
    return _p_pickClassView;
}

-(void)chooseIndexForm:(UIPickerView *)pickView{
    NSInteger item  = [pickView selectedRowInComponent:0];
    Ocean_businessClassModel *model =  self.p_classInfoArr[item];
    self.postModel.m_gbcid = model.m_cid;
    self.postModel.m_gbname = model.m_name;
    [self.tableView reloadData];
}


-(UIView *)tableHeadView{
    
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]init];
        _tableHeadView.width = screen_Width;
        CGFloat cardW = _tableHeadView.width *400/448;
        CGFloat cardH = cardW *400/640;
        CGFloat cardY = 15;
        CGFloat cardX = (_tableHeadView.width -cardW)/2;

        Ocean_CardView *cardView = [Ocean_CardView initWithBackImageName:@"qudao" Frame:CGRectMake(cardX, cardY, cardW, cardH) TopImage:@"" IconImage:@"" bottomImage:@"" cardNameImage:@""];
        _tableHeadView.height = cardView.bottom  +15;
        
        [_tableHeadView addSubview:cardView];
        
    }
    
    return _tableHeadView;
    
}



-(ZmjPickView *)p_pickerArea{
    if (!_p_pickerArea) {
        _p_pickerArea = [[ZmjPickView alloc]init];
    }
    return _p_pickerArea;
}



-(NSMutableDictionary *)waringDic{
    if (!_waringDic) {
        _waringDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      @"请输入店铺名称",@"_m_name",
                      @"请输入详细地址",@"_m_compaddress",
                      @"请选择证件照(正面)",@"_m_zcardno",
                      @"请选择证件照(反面)",@"_m_fcardno",
                      @"请输入手机号",@"_m_corphone",
                      @"请输入身份证号",@"_m_cardno",
                      @"请输入店铺简介",@"_m_content",
                      @"请选择地址",@"_m_storeAddress",
                      @"请输入法人姓名", @"_m_corporation",
                      @"",@"_m_threelicense",
                      @"",@"_m_license",
                      @"",@"_m_orgcode",
                      @"",@"_m_taxreg",nil];
        
    }
    return _waringDic;
}


-(NSDictionary *)storeInfo{
    if (!_storeInfo) {
        _storeInfo =@{
                      @"101":@[
                                    @{@"type":@"3",@"image":@"card_ying",@"propertyName":@"m_license"},
                                    @{@"type":@"3",@"image":@"card_daima",@"propertyName":@"m_orgcode"},
                                    @{@"type":@"3",@"image":@"card_shui",@"propertyName":@"m_taxreg"}],
                      @"100":@[
                                    @{@"type":@"3",@"image":@"card_sanzheng",@"propertyName":@"m_threelicense"}
                              ]
                      };
    }
    return _storeInfo;
}

-(NSMutableArray *)p_EnterStoreArr{
    if (!_p_EnterStoreArr) {
        NSArray *info = @[@[@{@"type":@"1",@"image":@"user_info"},
                            @{@"type":@"2",@"title":@"真实姓名",@"des":@"您的真实姓名",@"propertyName":@"m_corporation",@"edit":@"1",@"line":@"0"},
                            @{@"type":@"2",@"title":@"身份证号",@"des":@"您的身份证号",@"propertyName":@"m_cardno",@"edit":@"1",@"line":@"0"},
                            @{@"type":@"2",@"title":@"手机号码",@"des":@"您的手机号码",@"propertyName":@"m_corphone",@"edit":@"1",@"line":@"0"},
                            @{@"type":@"2",@"title":@"关注人",@"des":@"关注人手机号码(选填)",@"propertyName":@"m_spreadcode",@"edit":@"1",@"line":@"0"},

                            @{@"type":@"2",@"title":@"证件信息",@"des":@"请上传您的身份证正反面照片",@"edit":@"0",@"line":@"1"},
                            @{@"type":@"3",@"image":@"card_zheng",@"propertyName":@"m_zcardno"},
                            @{@"type":@"3",@"image":@"card_fan",@"propertyName":@"m_fcardno"},
                            ],
                          
                          @[@{@"type":@"1",@"image":@"shop_ifo"},
                            @{@"type":@"5",@"title":@"店铺类型",@"propertyName":@"m_type",@"buttons":@[@{@"title":@"企业",@"show":@"0"},@{@"title":@"个人",@"show":@"0"},@{@"title":@"其他",@"show":@"0"}]},
                            @{@"type":@"2",
                              @"title":@"店铺分类",
                              @"des":@"请选择店铺类别",
                              @"propertyName":@"m_gbname",
                              @"edit":@"0",
                              @"line":@"0"},
                            
                            @{@"type":@"2",@"title":@"店铺名称",@"des":@"您的店铺名称",@"propertyName":@"m_name",@"edit":@"1",@"line":@"0"},
                            @{@"type":@"4",@"title":@"店铺简介",@"des":@"您的店铺简介",@"propertyName":@"m_content"},
                            @{@"type":@"2",@"title":@"店铺地址",@"des":@"请选择省市区",@"propertyName":@"m_storeAddress",@"edit":@"0",@"line":@"0"},
                            @{@"type":@"2",@"title":@"详细地址",@"des":@"请填写详细的街道地址",@"propertyName":@"m_compaddress",@"edit":@"1",@"line":@"0"},
                            @{@"type":@"100",@"title":@"上传店铺三证",@"des":@"工商营业执照、组织机构代码证、税务登记证",@"edit":@"0",@"line":@"0"},
                            @{@"type":@"5",@"title":@"三证合一",@"propertyName":@"m_sign",@"line":@"1",@"buttons":@[@{@"title":@"是",@"show":@"0"},@{@"title":@"否",@"show":@"0"},@{@"title":@"",@"show":@"1"}]}
                            ],
                          @[],
                          @[
                              @{@"type":@"6",@"title":@"协议"},
                              @{@"type":@"0",@"title":@"提交"}
                            ]
                          ];
        _p_EnterStoreArr = [NSMutableArray arrayWithArray:info];
    }

    return _p_EnterStoreArr;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    _postModel = [Ocean_EnterStoreModel new];
    [_postModel addObserver:self forKeyPath:@"m_sign" options:NSKeyValueObservingOptionNew context:NULL];
    self.title = @"渠道对接";
    _postModel.m_sign = @"100";
    _postModel.m_type = @"100";

    isAgreement = YES;

    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 36, 36);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitle:@"查询" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.tableView.tableHeaderView = self.tableHeadView;
}
- (void)check{
    Ocean_EnterStoreCheckController *controller = [[Ocean_EnterStoreCheckController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSString *value = change[@"new"];
    NSLog(@"%@",value);
    if ([value integerValue]<100) {
        return;
    }
    [self.p_EnterStoreArr replaceObjectAtIndex:2 withObject:self.storeInfo[value]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

   return self.p_EnterStoreArr.count;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *itemArr = self.p_EnterStoreArr[section];
    return itemArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *infoDic = self.p_EnterStoreArr[indexPath.section][indexPath.row];
    
    CGFloat height;
    
    if ([infoDic[@"type"] integerValue] ==1) {
        
        height = 60;
        
    }else if ([infoDic[@"type"] integerValue] ==2){
        height = 45;
    }else if ([infoDic[@"type"] integerValue] ==3){
        height = screen_Width * 350/560 +20;
    }else if ([infoDic[@"type"] integerValue] ==5){
        height = 45;
    }else if ([infoDic[@"type"] integerValue] ==6){
        height = 45;
    }else if ([infoDic[@"type"] integerValue] ==100){
        height = 60;
        
    }else{
        height = 100;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *infoDic = self.p_EnterStoreArr[indexPath.section][indexPath.row];
    NSUInteger type =  [infoDic[@"type"] integerValue];

    UITableViewCell *cell;
    if (type ==1) {
        Ocean_storeHeadInfoCell *headCell = [Ocean_storeHeadInfoCell cellWithTableView:tableView];
        headCell.imageView.image = [UIImage imageNamed:infoDic[@"image"]];
        
        
        cell = headCell;
    }else if (type ==2){
        Ocean_StoreInputMessageCell *inputCell = [Ocean_StoreInputMessageCell cellWithTableView:tableView];
        inputCell.p_accInfo = infoDic;
        inputCell.model = self.postModel;
        
        
        cell = inputCell;
    }else if (type ==3){
        Ocean_StoreIDCell *idCell  =[Ocean_StoreIDCell cellWithTableView:tableView];
        idCell.p_accInfo = infoDic;
        idCell.model = self.postModel;
        idCell.vc = self;
        
        cell = idCell;
    }else if (type ==4){
        Ocean_StoreIntroduceCell *ntroduceCell = [Ocean_StoreIntroduceCell cellWithTableView:tableView];
        ntroduceCell.p_accInfo = infoDic;
        ntroduceCell.model = self.postModel;
        cell = ntroduceCell;

    }else if (type ==5){
        Ocean_storeCheckBoxsCell *CheckBoxsCell = [Ocean_storeCheckBoxsCell cellWithTableView:tableView];
        CheckBoxsCell.p_accInfo = infoDic;
        CheckBoxsCell.model = self.postModel;
        cell = CheckBoxsCell;
        
    }else if (type ==6){
        Ocean_ProtocolBoxCell *CheckprotolCell = [Ocean_ProtocolBoxCell cellWithTableView:tableView];
        CheckprotolCell.delegate = self;
        cell = CheckprotolCell;
    }else if (type==100){
    
        Ocean_UploadCerCell *Cercell = [Ocean_UploadCerCell cellWithTableView:tableView];
        Cercell.p_accInfo =infoDic;
        cell = Cercell;

    }
    else{
        XRNextPreCell *nextCell = [XRNextPreCell cellWithTableView:tableView];
        nextCell.delegate = self;
        [nextCell.p_nextButton setBackgroundColor:RGB(244, 152, 49)];
        nextCell.nextTitle = @"提交";
        cell = nextCell;
    }
    return cell;
}

-(void)ProtocolBoxCellClickButton:(UIButton *)sender{
    if (sender.tag ==100) {
        
        isAgreement = sender.selected;
        
    }else{
    
        //用户协议
        Ocean_EnterStoreProtolController *enterVC = [[Ocean_EnterStoreProtolController alloc]init];
        enterVC.title = @"渠道对接协议";
        enterVC.m_flag = @"2";
        [self.navigationController pushViewController:enterVC animated:YES];
    
    }

}

-(void)clickNextbutton{

    [self clearUpData];
}

-(void)clearUpData{
    
    self.postModel.m_filepix = @".jpg";
    if ([self.postModel.m_sign integerValue] ==101) {
        [self.waringDic setValue:@"" forKey:@"_m_threelicense"];
        [self.waringDic setValuesForKeysWithDictionary:@{@"_m_license":@"请选择营业执照",
                                                         @"_m_orgcode":@"请选择组织机构代码证",
                                                         @"_m_taxreg":@"请选择税务登记证"}];
    }else{
        
        [self.waringDic setValue:@"选择三证合一" forKey:@"_m_threelicense"];
        [self.waringDic setValuesForKeysWithDictionary:@{@"_m_license":@"",
                                                         @"_m_orgcode":@"",
                                                         @"_m_taxreg":@""}];
        
    }
    NSString *waring =  [self.postModel judgePostModelToStandard:self.waringDic];
    if (waring) {
        [MBProgressHUD showWarnMessage:waring];
        return;
    }
    
    if (![self.postModel.m_corphone checkPhoneNo]) {
        [MBProgressHUD showWarnMessage:@"请输入正确号码"];
        return;
    }else if (![self.postModel.m_cardno checkIDCard]){
        [MBProgressHUD showWarnMessage:@"请输入正确身份证号码"];
        return;
    }else if (self.postModel.m_spreadcode.length && ![self.postModel.m_spreadcode checkPhoneNo]){
        [MBProgressHUD showWarnMessage:@"请输入正确的关注人号码"];
        return;
    }
    
    if (!self.postModel.m_gbcid.length) {
        [MBProgressHUD showWarnMessage:@"请选择商铺分类"];
        return;
    }
    
    if (!isAgreement) {
        [MBProgressHUD showWarnMessage:@"请阅读并同意协议"];
        return;
    }
    
    
    [self BUSSINESSIN];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    
    NSDictionary *infoDic = self.p_EnterStoreArr[indexPath.section][indexPath.row];
    if ([infoDic[@"title"] isEqualToString:@"店铺地址"]) {
        
        MJWeakSelf;
        
      BRAddressPickerView *addressPick =   [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@0, @0, @0] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
           
            NSString * shengName  = selectAddressArr[0];
            NSString * shiName  = selectAddressArr[1];
            NSString * xianName  = selectAddressArr[2];

            weakSelf.postModel.m_pro = shengName;
            weakSelf.postModel.m_city = shiName;
            weakSelf.postModel.m_area = xianName;
            weakSelf.postModel.m_storeAddress = [NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName];
            [weakSelf.tableView reloadData];
            
        }];
        [addressPick.leftBtn setTitleColor:BackgroundColors(1) forState:0];
        addressPick.leftBtn.layer.borderColor = BackgroundColors(1).CGColor;
        [addressPick.rightBtn setBackgroundColor:BackgroundColors(1)];
        addressPick.titleLabel.textColor = BackgroundColors(1);
        
        

    }else if ([@"店铺分类" isEqualToString:infoDic[@"title"]]){
        [self BUSINESSCLASSLIST];

    }
}

-(void)dealloc{
    
    [self.postModel removeObserver:self forKeyPath:@"m_sign"];

}





//实现Deleage处理回调结果
//接收正向编码结果

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        CLLocationCoordinate2D coord =  result.location;
        NSString *la = [NSString stringWithFormat:@"%f",coord.latitude];
        NSString *lo = [NSString stringWithFormat:@"%f",coord.longitude];
        self.postModel.m_lat = la;
        self.postModel.m_lng = lo;
        [self postServer];
    }
    else {
        [MBProgressHUD showWarnMessage:@"输入的位置无法解析,请重新输入"];
    }
}


-(void)postServer{

    MJWeakSelf;
    NSMutableDictionary *postDic = [self.postModel mj_keyValues];
    [postDic setValue:[NSString stringWithFormat:@"%ld",[self.postModel.m_sign integerValue]-100] forKey:@"m_sign"];
    if ([self.postModel.m_sign intValue] ==101) {
        [postDic removeObjectForKey:@"m_threelicense"];
        
    }else{
        [postDic removeObjectsForKeys:@[@"m_license",@"m_orgcode",@"m_taxreg"]];
    }
    
    [postDic setValue:[NSString stringWithFormat:@"%ld",[self.postModel.m_type integerValue]-100+1] forKey:@"m_type"];
    [MBProgressHUD showActivityMessageInWindow:nil];
    [HttpRequestTools  requestUNUserInfoWithData:postDic methodName:@"IOSBUSSINESSIN" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                [MBProgressHUD showTipMessageInWindow:respInfo[@"ERRORDESTRIPTION"]];
                
                Ocean_EnterStorePayController *enterVC = [[Ocean_EnterStorePayController alloc]init];
                enterVC.m_remark = respInfo[@"m_remark"];
                enterVC.m_price = respInfo[@"m_price"];
                enterVC.m_bid = respInfo[@"m_bid"];
                enterVC.type = 0;
                enterVC.m_phone = self.postModel.m_corphone;
                [weakSelf.navigationController pushViewController:enterVC animated:YES];
                
                
//                                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    


}


-(BMKGeoCodeSearch *)searcher{
    if (!_searcher) {
        _searcher =[[BMKGeoCodeSearch alloc]init];
        _searcher.delegate = self;
    }
    return _searcher;
}

-(void)frontGeoAddress{

    
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city=  self.postModel.m_city;
    geoCodeSearchOption.address = self.postModel.m_compaddress;
    BOOL flag = [self.searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        
        [MBProgressHUD showWarnMessage:@"输入的位置无法解析,请重新输入"];
    }

    
    

}

-(void)BUSSINESSIN{
    //判断地址是否正确
    [self frontGeoAddress];
}

-(void)BUSINESSCLASSLIST{
    MJWeakSelf;
    [MBProgressHUD showActivityMessageInView:@""];
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"BUSINESSCLASSLIST" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                NSArray *classArr = [Ocean_businessClassModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_buscalist"]];
                weakSelf.p_classInfoArr = classArr;
                NSMutableArray *mutalArr = [NSMutableArray array];
                for (Ocean_businessClassModel *model in classArr) {
                    [mutalArr addObject:model.m_name];
                }
                weakSelf.p_pickClassView.infoArr = mutalArr;
                [weakSelf.p_pickClassView showListView];
                
            }else{
                [MBProgressHUD showTipMessageInWindow:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
}



@end

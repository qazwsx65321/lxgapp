//
//  Ocean_FinshingInfoController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FinshingInfoController.h"
#import "Ocean_BasicInfoCell.h"
#import "XRNextPreCell.h"
#import "Ocean_FinishProfessionInfoController.h"
#import "Ocean_FinishInfoProgessView.h"
#import "WP_PickView.h"
#import "Ocean_PersonageInfoModel.h"
#import "Ocean_FinishBankInfoViewController.h"
#import "ChooseHeadImageTool.h"
@interface Ocean_FinshingInfoController ()<UITableViewDelegate,UITableViewDataSource,XRNextPreCellDelegate,Ocean_imagePickerControllerDelegate>
@property (nonatomic,strong) NSArray * p_messageArr;
@property (nonatomic,strong) Ocean_FinishInfoProgessView * p_prgessView;
@property (nonatomic,strong) WP_PickView * p_pickView;
@property (nonatomic,strong) Ocean_PersonageInfoModel * postModel;
@property (nonatomic,weak) UITableView * p_tableView;
@property (nonatomic,strong)UIView *tableHeadView;
@property (nonatomic,weak) UIButton * p_picBtn;
@end

@implementation Ocean_FinshingInfoController

-(UIView *)tableHeadView{

    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]init];
        _tableHeadView.width = screen_Width;
        UIButton *headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.p_picBtn = headImageBtn;
        [headImageBtn setBackgroundImage:[UIImage imageNamed:@"QSziliao"] forState:0];
        [headImageBtn addTarget:self action:@selector(selectHeadPic) forControlEvents:UIControlEventTouchUpInside];
        CGFloat W = screen_Width *150/480;
        headImageBtn.size = CGSizeMake(W, W);
        headImageBtn.y = 20;
        headImageBtn.centerX = _tableHeadView.width/2;
        [_tableHeadView addSubview:headImageBtn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, headImageBtn.bottom +15, screen_Width-20, 15)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"头像照片请选择本人清晰2寸免冠照片,以便后期制作卡片使用";
        [label sizeToFit];
        [_tableHeadView addSubview:label];
        _tableHeadView.height = label.bottom +15;
    }
    
    return _tableHeadView;

}

-(void)selectHeadPic{

    [ChooseHeadImageTool chooseImageFormLibOrAlbum:self Edit:YES andDelegate:self];

}

-(void)Ocean_imagePickerControllerdidFinishPickingImageData:(NSData *)imageData{
    UIImage *image = [UIImage imageWithData:imageData];
    [self.p_picBtn setBackgroundImage:image forState:UIControlStateNormal];
    self.postModel.m_headpic = imageData;

}
-(WP_PickView *)p_pickView{
    if (!_p_pickView) {
        _p_pickView =  [[WP_PickView alloc]init];
    }
    return _p_pickView;
}


-(NSArray *)p_messageArr{
    if (!_p_messageArr) {
        _p_messageArr=  @[@{@"title":@"姓名:",
                            @"placeHold":@"请填写真实姓名",
                            @"type":@"1",
                            @"key":@"m_name",
                            @"mustCheck":@"1"},
                          
                          
                          
                          @{@"title":@"性别:",
                            @"placeHold":@"请选择性别(选填)",
                            @"type":@"2",
                            @"show":@[@{@"M":@"男"},
                                      @{@"F":@"女"}],
                            @"key":@"m_sex",
                            @"mustCheck":@"0"},
                          
                          
                          
                          @{@"title":@"出生日期:",
                            @"placeHold":@"请选择出生年月日(选填)",
                            @"type":@"2",
                            @"key":@"m_birthday",
                            @"mustCheck":@"0"},
                          
                          
                          
                          @{@"title":@"证件类型:",
                            @"placeHold":@"请选择证件类型",
                            @"type":@"2",
                            @"show":@[@{@"1":@"中国身份证"},
                                        @{@"2":@"护照"},
                                      @{@"3":@"港澳通行证"},
                                      @{@"4":@"台湾通行证"}],
                            @"key":@"m_cardtype",
                            @"mustCheck":@"1"},
                          
                          
                          @{@"title":@"证件号码:",
                            @"placeHold":@"请填写证件号码",
                            @"type":@"1",
                            @"key":@"m_cardno",
                            @"mustCheck":@"1"},
                          
                          
                          /*@{@"title":@"婚姻状况:",
                            @"placeHold":@"请选择婚姻状况",
                            @"type":@"2",
                            @"show":@[@{@"S":@"未婚"},
                                      @{@"M":@"已婚"},
                                      @{@"O":@"其他"}],
                            @"key":@"m_marriage",
                            @"mustCheck":@"1"},*/
                          
                          
                          
                          /*@{@"title":@"教育程度:",
                            @"placeHold":@"请选择教育程度",
                            @"type":@"2",
                            @"show":@[@{@"M":@"硕士及以上"},
                                      @{@"U":@"大学"},
                                      @{@"P":@"大专"},
                                      @{@"H":@"高中/中专"},
                                      @{@"S":@"初中或以下"}],
                            @"key":@"m_edulevel",
                            @"mustCheck":@"1"},*/
                          
                          
                          
                         /* @{@"title":@"住宅状况:",
                            @"placeHold":@"请选择住宅状况",
                            @"type":@"2",
                            @"show":@[@{@"S":@"自有无按揭"},
                                      @{@"M":@"按揭住宅"},
                                      @{@"Q":@"单位分配"},
                                      @{@"R":@"租房"},
                                      @{@"L":@"与父母同住"},
                                      @{@"O":@"其他"}],
                            @"key":@"m_house",
                            @"mustCheck":@"1"},*/
                          
                          
                        
                          
                          
                          @{@"title":@"住宅地址:",
                            @"placeHold":@"请填写住宅地址(选填)",
                            @"type":@"1",
                            @"key":@"m_houseaddress",
                            @"mustCheck":@"0"},
                          
                          
                          @{@"title":@"手机号:",
                            @"placeHold":@"请填写手机号",
                            @"type":@"1",
                            @"key":@"m_phone",
                            @"mustCheck":@"1"},
                          
                          
                          @{@"title":@"邮箱:",
                            @"placeHold":@"请填写邮箱(选填)",
                            @"type":@"1",
                            @"key":@"m_qq_email",
                            @"mustCheck":@"0"}
                          ];
    }
    return _p_messageArr;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"完善资料";
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.y = 105;
    table.tableHeaderView = self.tableHeadView;
    table.height -=105;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    self.p_tableView = table;
    self.automaticallyAdjustsScrollViewInsets = NO;
    table.tableFooterView = [[UIView alloc]init];

    _postModel = [Ocean_PersonageInfoModel new];
    
    _postModel.m_phone = [Ocean_UserInfo sharedOcean_UserInfo].m_registPhone;
    _postModel.m_filepix = @".jpg";

    Ocean_FinishInfoProgessView *progessView =[[Ocean_FinishInfoProgessView alloc]initWithFrame:CGRectMake(0, 64, screen_Width, 45) andCardTitle:@[@"基本资料",@"卡片类型"] andNavtionVC:self.navigationController];
    self.p_prgessView = progessView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
//    UIButton *backButton =  self.navigationItem.leftBarButtonItem.customView;
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wundeclared-selector"
//    [backButton removeTarget:self.navigationController action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//#pragma clang diagnostic pop    
//    [backButton addTarget:self action:@selector(backFist1) forControlEvents:UIControlEventTouchUpInside];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideView:) name:@"QSHideProgressView" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancel) name:@"QSFinishCardPay" object:nil];
    
}

-(void)cancel{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

//-(void)finishPopView:(NSNotification *)not{
//
//    for (UIViewController *control in self.navigationController.childViewControllers) {
//        NSString *controlstr = NSStringFromClass([control class]);
//        if ([controlstr isEqualToString:self.classStr]) {
//            [self.navigationController popToViewController:control animated:YES];
//            break;
//        }
//        
//    }
//    
//    
//}

-(void)hideView:(NSNotification *)not{
    NSNumber *numobj = not.object;
    self.p_prgessView.hidden = [numobj integerValue];

}



-(void)backFist1{
    [self.p_prgessView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.p_messageArr.count +1;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.p_prgessView];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath.row==self.p_messageArr.count?80:45;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row ==self.p_messageArr.count) {
        
        XRNextPreCell *cell = [XRNextPreCell cellWithTableView:tableView];
        cell.nextTitle = @"下一步";
        [cell.p_nextButton setBackgroundColor:BackgroundColors(1)];
        cell.delegate = self;
        return cell;
    }
    
    NSDictionary *infoDic = self.p_messageArr[indexPath.row];
    Ocean_BasicInfoCell *cell = [Ocean_BasicInfoCell cellWithTableView:tableView];
    [cell setBaseDic:infoDic andInfoModel:self.postModel];
    return cell;
}



-(void)clickNextbutton{
    
    if (!self.postModel.m_headpic.length) {
        [MBProgressHUD showWarnMessage:@"请选择头像"];
        return;
    }
    
    
    
  NSString *waringStr =   [self.postModel judgePostModelToStandard:@{
                                              @"_m_name":@"请输入姓名",
                                              /*@"_m_sex":@"请选择性别",*/
                                              /*@"_m_birthday":@"请选择出生日期",*/
                                              @"_m_cardtype":@"请选择证件类型",
                                              @"_m_cardno":@"请输入证件号码",
                                              /*@"_m_marriage":@"请选择婚姻状况",*/
                                              /*@"_m_edulevel":@"请选择教育程度",*/
                                              /*@"_m_house":@"请选择住宅状况",*/
                                              /*@"_m_houseaddress":@"请填写住宅地址",*/
                                              @"_m_phone":@"请填写手机号",
                                              }];
    
    
    if (waringStr) {
        [MBProgressHUD showWarnMessage:waringStr];
        return;
    };

    
    NSString *cardType = self.postModel.m_cardtype;
    
    BOOL isRight = YES;
    
    if ([cardType isEqualToString:@"1"]) {
       isRight = [self.postModel.m_cardno checkIDCard];
    }else if ([cardType isEqualToString:@"2"]){
        isRight = [self.postModel.m_cardno checkPassportCard];
    }else if ([cardType isEqualToString:@"3"]){
        isRight = [self.postModel.m_cardno checkGangAoPassportNumber];
    }else{
        isRight = [self.postModel.m_cardno checkTaiWanPassportNumber];
    }
    if (!isRight) {
        [MBProgressHUD showWarnMessage:@"请输入正确的证件号"];
        return;
    }

    if (self.postModel.m_phone.length>0 && ![self.postModel.m_phone checkPhoneNo]) {
        [MBProgressHUD showWarnMessage:@"请输入正确的手机号"];
        return;
    }


    if ((self.postModel.m_qq_email.length>0)&&![self.postModel.m_qq_email checkEmail]) {
        [MBProgressHUD showWarnMessage:@"请输入正确的邮件地址"];
        return;
    }



    Ocean_FinishBankInfoViewController *pfVc = [[Ocean_FinishBankInfoViewController alloc] init];
    pfVc.postModel = self.postModel;
    [self.navigationController pushViewController:pfVc animated:NO];
    
}

-(void)dealloc{
    [self.p_prgessView removeFromSuperview];
    self.p_prgessView = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==self.p_messageArr.count) {
        return;
    }
    
    NSDictionary *infoDic = self.p_messageArr[indexPath.row];
    if ([infoDic[@"type"] integerValue]==2) {
        NSString *title = infoDic[@"placeHold"];
        
        NSArray *dicArr = infoDic[@"show"];
        
        
        NSString *propertyStr = infoDic[@"key"];
        
        NSMutableArray *allKeys = [NSMutableArray array];
        NSMutableArray *values = [NSMutableArray array];

        
        for (NSDictionary *dic in dicArr) {
            
            [allKeys addObject:[[dic allKeys] firstObject]];
            [values addObject:[[dic allValues] firstObject]];
        }
        
        [self.view endEditing:YES];
        MJWeakSelf;
            if (dicArr.count) {
                
                [JXTAlertView showAlertViewWithTitle:title message:nil cancelButtonTitle:nil buttonIndexBlock:^(NSInteger buttonIndex) {
                    [weakSelf.postModel setValue:allKeys[buttonIndex] forKey:propertyStr];
                    [weakSelf.p_tableView reloadData];
                    
                } otherButtonTitles:values];
                
            }else{
                
                [self.p_pickView showListViewandReturn:^(NSDate *date) {
                    NSDateFormatter *fd = [[NSDateFormatter alloc]init];
                    [fd setDateFormat:@"yyyyMMdd"];
                    NSString *birthday = [fd stringFromDate:date];
                    weakSelf.postModel.m_birthday = birthday;
                    [weakSelf.p_tableView reloadData];
                }];
                
            }      
        
    }
    
    

}

@end

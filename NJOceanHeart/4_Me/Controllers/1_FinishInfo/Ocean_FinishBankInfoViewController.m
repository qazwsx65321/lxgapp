//
//  Ocean_FinishBankInfoViewController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FinishBankInfoViewController.h"
#import "Ocean_BasicInfoCell.h"
#import "XRNextPreCell.h"
#import "Ocean_PersonageInfoModel.h"
#import "Ocean_CarInfoModel.h"
#import "Ocean_cardInfoCell.h"
#import "Ocean_EnterStorePayController.h"
#import "Ocean_BankCardTypeCell.h"
@interface TabelheadView : UITableViewHeaderFooterView

@end

@implementation TabelheadView


@end


@interface Ocean_FinishBankInfoViewController ()<UITableViewDelegate,UITableViewDataSource,XRNextPreCellDelegate,Ocean_BasicInfoCellDelegate>
{
    NSDictionary *yaoqingDic;
    NSString *cardInfo;
    NSString *lastinfo;
    BOOL isChoose;
}

@property (nonatomic,strong) NSArray * p_messageArr;
@property (nonatomic,strong) NSArray * p_cardInfoArr;
@property (nonatomic,weak) UITableView * p_table;
@property (nonatomic,strong) NSArray * p_seactionArr;
@property (nonatomic,strong) Ocean_CarInfoModel *selectCardModel;
@property (nonatomic,strong) NSDictionary * AllbankInfo;
@end

@implementation Ocean_FinishBankInfoViewController

-(NSDictionary *)AllbankInfo{
    if (!_AllbankInfo) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
        NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        _AllbankInfo = resultDic;
    }
    return _AllbankInfo;
}

-(NSArray *)p_seactionArr{
    if (!_p_seactionArr) {
        _p_seactionArr = @[@"请选择卡片种类",@"绑定银行卡信息"];
    }
    return _p_seactionArr;
}

-(NSArray *)p_messageArr{
    if (!_p_messageArr) {
        _p_messageArr=  @[
                    

                          @{@"title":@"银行卡号:",@"placeHold":@"请填写银行卡号",@"type":@"1",@"key":@"m_bankno"},
                          @{@"title":@"开户行/支行:",@"placeHold":@"请填写开户行/支行",@"type":@"1",@"key":@"m_bankname"},
                          ];
    }
    return _p_messageArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *checkFlag = [Ocean_UserInfo sharedOcean_UserInfo].m_checkflag;
    isChoose = YES;
    self.postModel.m_cardid = @"";
    if ([@"N" isEqualToString:checkFlag]) {
        isChoose = NO;
    }
    self.title = @"完善资料";
    yaoqingDic = @{@"title":@"邀请码",@"placeHold":@"请输入推荐码(选填)",@"type":@"1",@"key":@"m_spreadcode"};
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.y = 45+64;
    self.p_table = table;
    table.height -=105;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    cardInfo = @"";
    table.tableFooterView = [[UIView alloc]init];
    [table registerClass:[TabelheadView class] forHeaderFooterViewReuseIdentifier:@"TabelheadView"];
    UIButton *backButton =  self.navigationItem.leftBarButtonItem.customView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    [backButton removeTarget:self.navigationController action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
    [backButton addTarget:self action:@selector(backFist3) forControlEvents:UIControlEventTouchUpInside];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self GETCARDSTYPE];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.p_cardInfoArr.count+1;
            break;
            
        default:
            return self.p_messageArr.count+1;
            break;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UITableViewHeaderFooterView *Hview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TabelheadView"];
    Hview.textLabel.text = self.p_seactionArr[section];
    return Hview;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            if (self.p_cardInfoArr.count==0) {
                return 45;
            }
            return indexPath.row==self.p_cardInfoArr.count?45:((screen_Width-20)*300/450 +55);

        }
            break;
            
        default:
        {
            
            return indexPath.row==self.p_messageArr.count?80:45;
            
        }
            break;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section) {
        if (indexPath.row ==self.p_messageArr.count) {
            
            XRNextPreCell *cell = [XRNextPreCell cellWithTableView:tableView];
            cell.nextTitle = @"提交";
            [cell.p_nextButton setBackgroundColor:BackgroundColors(1)];
            cell.delegate = self;
            return cell;
        }else{
            NSDictionary *infoDic = self.p_messageArr[indexPath.row];
            if ([@"1" isEqualToString:infoDic[@"type"]]) {
                Ocean_BasicInfoCell *cell = [Ocean_BasicInfoCell cellWithTableView:tableView];
                cell.delegate = self;
                [cell setBaseDic:infoDic andInfoModel:self.postModel];
                return cell;
            }else if([@"2" isEqualToString:infoDic[@"type"]]){
                NSArray *arr = [cardInfo componentsSeparatedByString:@"·"];
                NSString *messgae = @"";
                if (arr.count>1) {
                    messgae = arr[indexPath.row];
                }
                
                Ocean_BankCardTypeCell *cell =[Ocean_BankCardTypeCell cellWithTableView:tableView];
                [cell setBaseDic:infoDic andCardMessage:messgae];
                return cell;
            
            }
        }
        
     
    }else{
        if (indexPath.row ==self.p_cardInfoArr.count) {
            
            NSDictionary *infoDic = yaoqingDic;
            Ocean_BasicInfoCell *cell = [Ocean_BasicInfoCell cellWithTableView:tableView];
            [cell setBaseDic:infoDic andInfoModel:self.postModel];
            return cell;
        }else{
            Ocean_CarInfoModel *model = self.p_cardInfoArr[indexPath.row];
            Ocean_cardInfoCell *cardInfoCell = [Ocean_cardInfoCell cellWithTableView:tableView];
            
            cardInfoCell.userInteractionEnabled = isChoose;
                
            cardInfoCell.infoModel = self.postModel;
            cardInfoCell.cardinfoModel = model;
            return cardInfoCell;
        }
        

    }
    
    return nil;
}

-(void)textFileChange:(UITextField *)tf{
    
    if (tf.text.length>19) {
        [tf deleteBackward];
    }
    
//    if(CardId==nil || CardId.length<8 || CardId.length>19){
//        _p_messageArr=  @[
//                          @{@"title":@"银行卡号:",@"placeHold":@"请填写银行卡号",@"type":@"1",@"key":@"m_bankno"},
//                          @{@"title":@"开户行/支行:",@"placeHold":@"请填写开户行/支行",@"type":@"1",@"key":@"m_bankname"},
//                          ];
//    }
//    NSString *str =  [self returnBankName:CardId];
//    if (str.length&&![cardInfo isEqualToString:@"str"]) {
//        cardInfo = str;
//        _p_messageArr=  @[
//                          @{@"title":@"银行名称:",@"placeHold":@"",@"type":@"2",@"key":@""},
//                          @{@"title":@"银卡种类:",@"placeHold":@"",@"type":@"2",@"key":@""},
//                          
//                          @{@"title":@"银行卡号:",@"placeHold":@"请填写银行卡号",@"type":@"1",@"key":@"m_bankno"},
//                          @{@"title":@"开户行/支行:",@"placeHold":@"请填写开户行/支行",@"type":@"1",@"key":@"m_bankname"},
//                          ];
//    }else{
//    
//        _p_messageArr=  @[
//                          @{@"title":@"银行卡号:",@"placeHold":@"请填写银行卡号",@"type":@"1",@"key":@"m_bankno"},
//                          @{@"title":@"开户行/支行:",@"placeHold":@"请填写开户行/支行",@"type":@"1",@"key":@"m_bankname"},
//                          ];
//
//    
//    }
//    [self.p_table reloadData];
    
}




- (NSString *)returnBankName:(NSString*) idCard{
    NSArray *bankBin = self.AllbankInfo.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    if ([bankBin containsObject:cardbin_6]) {
        return [self.AllbankInfo objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [self.AllbankInfo objectForKey:cardbin_8];
    }else{
        return @"";
    }
    return @"";
    
}


-(void)clickNextbutton{
    
    [self PerfectInfo];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0 &&indexPath.row <self.p_cardInfoArr.count) {
        for (Ocean_CarInfoModel *object in self.p_cardInfoArr) {
            object.isSelect = NO;
        }
        Ocean_CarInfoModel *model = self.p_cardInfoArr[indexPath.row];
        model.isSelect = YES;
        self.selectCardModel = model;
        [self.p_table reloadData];
    }

}


-(void)backFist3{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)GETCARDSTYPE{
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"GETCARDSTYPE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                weakSelf.p_cardInfoArr = [Ocean_CarInfoModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_cardstype"]];
                
                if (!isChoose) {
                    NSString *cardId = [Ocean_UserInfo sharedOcean_UserInfo].m_cardid;
                    for (Ocean_CarInfoModel *Cardmodel  in weakSelf.p_cardInfoArr) {
                        if ([Cardmodel.m_cid isEqualToString:cardId]) {
                            Cardmodel.isSelect = YES;
                            break;
                        }
                    }
                    
                }
               
                
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.p_table reloadData];
    }];



}


-(void)PerfectInfo{


    MJWeakSelf;
    
    if (!self.postModel.m_cardid.length) {
        [MBProgressHUD showWarnMessage:@"请选择卡片"];
        return;
    }
    NSDictionary *setDic = [self.postModel mj_keyValues];
    [_postModel judgeObjectPropertyNull];

    NSDictionary *postDic = [self.postModel mj_keyValues];
    
    [MBProgressHUD showActivityMessageInWindow:@""];
    
    [HttpRequestTools  requestUserInfoWithData:postDic methodName:@"IOSPERFECTINFO" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
                
                [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:@"W" forKey:@"m_checkflag"];

                
                [[Ocean_UserInfo mj_objectWithKeyValues:setDic] setInfoData];
                
                
                //更改头像
                NSString *imageURl = [Ocean_UserInfo sharedOcean_UserInfo].m_headpic;
                
                [[SDImageCache sharedImageCache]removeImageForKey:imageURl withCompletion:nil];
                NSString *m_headName = [NSString stringWithFormat:@"%@t.jpg",[Ocean_UserInfo sharedOcean_UserInfo].m_uid];
                
                
                
                NSURL *url = [NSURL URLWithString:imageURl];
                
                NSArray *subArr = [imageURl componentsSeparatedByString:@"/"];
                NSString *laststring = [subArr lastObject];
                NSURL *pathUrl = url;
                if (laststring.length) {
                   pathUrl  = [url URLByDeletingLastPathComponent];
                }
                NSString *m_headPath = [[pathUrl absoluteString] stringByAppendingPathComponent:m_headName];

                if (m_headPath.length) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_headPath forKey:@"m_headpic"];
                }
                //更改头像
                
                
                
                
                
                
                if ([@"O" isEqualToString:respInfo[@"m_state"]]) {
                    
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                    return;
                }
                
                
                
                
                

                
                Ocean_EnterStorePayController *pay = [[Ocean_EnterStorePayController alloc]init];
                pay.m_bid = [Ocean_UserInfo sharedOcean_UserInfo].m_uid;
                pay.m_price = weakSelf.selectCardModel.m_price;
                pay.m_remark = weakSelf.selectCardModel.m_name;
                pay.type = 1;
                [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:pay.m_remark forKey:@"m_cardname"];
                if (pay.m_price) {
                     [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:pay.m_price forKey:@"m_cardPrice"];

//                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:pay.m_price forKey:@"m_cardPrice"];
//                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:pay.m_price forKey:@"m_cardPrice"];


                }
        
                
                [weakSelf.navigationController pushViewController:pay animated:YES];

              
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"QSHideProgressView" object:@(0)];
}

@end

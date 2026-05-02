//
//  Ocean_chooseRechargeController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_chooseRechargeController.h"
#import "Ocean_ChooseTypePayCell.h"
#import "XRNextPreCell.h"
#import "Ocean_inputMoneyCell.h"
#import "WXRPayTool.h"
@interface TabelRechargheadView : UITableViewHeaderFooterView

@end

@implementation TabelRechargheadView


@end

@interface Ocean_chooseRechargeController ()<Ocean_ChooseTypePayCellDelegate,XRNextPreCellDelegate>
{
    NSInteger payTag;
}
@property (nonatomic,strong) NSArray * p_seactionArr;
@property (nonatomic,weak) UITextField * p_moneyTF;
@end

@implementation Ocean_chooseRechargeController

-(NSArray *)p_seactionArr{
    if (!_p_seactionArr) {
        _p_seactionArr = @[@"充值方式",@"充值金额"];
    }
    return _p_seactionArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    payTag = 100;
    self.tableView.tableHeaderView = [self tableHeadView];
    [self.tableView registerClass:[TabelRechargheadView class] forHeaderFooterViewReuseIdentifier:@"TabelheadView"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(UIView *)tableHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 120)];
    UIImageView *imageV =[[UIImageView alloc]init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang]placeholderImage:[UIImage imageNamed:@"me_user"]];
    headView.backgroundColor = BackgroundColors(1);
    imageV.size = CGSizeMake(60, 60);
    imageV.layer.cornerRadius = imageV.width/2;
    imageV.layer.masksToBounds = YES;
    [headView addSubview:imageV];
    imageV.centerX = headView.width/2;
    imageV.centerY = headView.height/2;
    return headView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *Hview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TabelheadView"];
    Hview.textLabel.text = self.p_seactionArr[section];
    return Hview;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section) {
        return 2;
    }
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section) {
        Ocean_ChooseTypePayCell *cell = [Ocean_ChooseTypePayCell cellWithTableView:tableView];
        cell.delegate =self;
        return cell;
    }else{
        if (indexPath.row ==0) {
            Ocean_inputMoneyCell *cell =  [Ocean_inputMoneyCell cellWithTableView:tableView];
            self.p_moneyTF = cell.p_TF;
            return cell;
        }else{
            XRNextPreCell *cell = [XRNextPreCell cellWithTableView:tableView];
            cell.nextTitle = @"充值";
            cell.delegate = self;
            return cell;
        }
    }
}

-(void)Ocean_ChooseTypePayCellChoosePay:(NSInteger)tag{
    payTag = tag;
}

-(void)clickNextbutton{
    
    if ([self.p_moneyTF.text doubleValue]<=0) {
        [MBProgressHUD showWarnMessage:@"请输入金额"];
        return;
    }
    //20220418 add，推广版本在线充值功能注释
    else {
        [MBProgressHUD showWarnMessage:@"平台结算中，暂不进行在线充值"];
        return;
    }
    
    
    if (payTag ==100) {
        //支付宝支付
//        if ( ![self.p_moneyTF.text checkMoneyValue]) {
//            [MBProgressHUD showErrorMessage:@"请输入金额"];
//            return;
//        }

    NSDate *timedate = [NSDate date];
    NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    dateF.dateFormat = @"yyyyMMddHHmmssSSS";
     NSString *timer =   [dateF stringFromDate:timedate];
        NSLog(@"%@",timer);
    [self.view endEditing:YES];
    NSString *Order= [NSString stringWithFormat:@"%@_%@_0",timer,[Ocean_UserInfo sharedOcean_UserInfo].m_uid];
        [WXRPayTool WXRPayToPlatformOderNumber:Order andOrderPrice:self.p_moneyTF.text andPlat:YES];
    }else{
        //微信支付
        NSDate *timedate = [NSDate date];
        NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
        dateF.dateFormat = @"yyyyMMddHHmmssSSS";
        NSString *timer =   [dateF stringFromDate:timedate];
        NSString *order = [NSString stringWithFormat:@"%@_%@",timer,[Ocean_UserInfo sharedOcean_UserInfo].m_registPhone];

        NSString *arrtch = [NSString stringWithFormat:@"%@_0",[Ocean_UserInfo sharedOcean_UserInfo].m_uid];
        
        NSString *postOrder = [NSString stringWithFormat:@"%@&&:&&%@",order,arrtch];
        
        [WXRPayTool WXRPayToPlatformOderNumber:postOrder andOrderPrice:self.p_moneyTF.text andPlat:NO];

    }
}

@end

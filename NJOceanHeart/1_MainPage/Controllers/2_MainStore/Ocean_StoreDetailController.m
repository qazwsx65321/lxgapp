//
//  Ocean_StoreDetailController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/26.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_StoreDetailController.h"
#import "Ocean_MainStoreShopModel.h"
#import "Ocean_storeAptitudeController.h"
#import "StepViewController.h"
@interface Ocean_StoreDetailController ()

@property (nonatomic,strong) NSArray * p_infoArr;


@end

@implementation Ocean_StoreDetailController



-(void)dealloc{
    NSLog(@"销毁了");

}

-(NSArray *)p_infoArr{
    if (!_p_infoArr) {
        _p_infoArr = @[
                       @[
                           @{@"title":@"品类",
                             @"Detail":@"衣",
                             @"accessory":@"0"
                             },
                           @{@"title":@"联系电话",
                             @"Detail":self.infomodel.m_corphone,
                             @"accessory":@"1",@"type":@"call"},
                           @{@"title":@"店铺地址",
                             @"Detail":self.infomodel.m_compaddress,
                             @"accessory":@"1",@"type":@"nav"},
                        ],
                       @[
                           @{@"title":@"营业资质",
                             @"Detail":@"",
                             @"accessory":@"1",@"type":@"push"},
                        ]
                       ];
        
        
    }
    return _p_infoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.infomodel.m_name;
    self.tableView.tableHeaderView = [self headView];
    self.tableView.tableFooterView = [UIView new];
}

-(UIView *)headView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 0)];
    UIImageView *imageV = [[UIImageView alloc]init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.infomodel.m_logo] placeholderImage:nil];
    imageV.width = screen_Width;
    imageV.height = screen_Width *300/449;
    [headView addSubview:imageV];
    
    UILabel *titlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, imageV.bottom+10, screen_Width-20, 15)];
    titlabel.font = [UIFont systemFontOfSize:15];
    titlabel.text = @"店铺简介";
    [headView addSubview:titlabel];
    
    UILabel *contLb = [[UILabel alloc]initWithFrame:CGRectMake(10, titlabel.bottom+10, screen_Width-20, 15)];
    contLb.font = [UIFont systemFontOfSize:14];
    contLb.numberOfLines = 0;
    contLb.textColor = [UIColor lightGrayColor];
    contLb.text = self.infomodel.m_content;
    [headView addSubview:contLb];
    [contLb sizeToFit];
    headView.height = contLb.bottom +10;
    
    return headView;
    
    
  
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.p_infoArr[section];
    return  arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.p_infoArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellsign = @"DeailTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellsign];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    NSDictionary *dic = self.p_infoArr[indexPath.section][indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"Detail"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    if ([dic[@"accessory"]integerValue]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.p_infoArr[indexPath.section][indexPath.row];
    if ([dic[@"accessory"] integerValue]) {
    
        if ([dic[@"type"] isEqualToString:@"call"]) {
            [self call:self.infomodel.m_corphone];
        }else if ([dic[@"type"] isEqualToString:@"push"]){
        
            Ocean_storeAptitudeController *vc = [[Ocean_storeAptitudeController alloc]init];
            vc.infomodel = self.infomodel;
            vc.title = @"营业资质";
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([dic[@"type"] isEqualToString:@"nav"]){
        
            StepViewController *stepVC = [[StepViewController alloc]init];
            stepVC.s_infomodel = self.infomodel;
            [self.navigationController pushViewController:stepVC animated:YES];
        }
    }
}

-(void)call:(NSString *)phone{

    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

@end

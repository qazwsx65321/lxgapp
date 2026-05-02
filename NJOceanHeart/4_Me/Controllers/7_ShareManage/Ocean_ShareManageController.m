//
//  Ocean_ShareManageController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ShareManageController.h"
#import "UIImage+Zirkfied.h"
#import "YiRenShareTools.h"
@interface Ocean_ShareManageController ()
@property (nonatomic,weak) UIImageView  * p_backImageV;
@property (nonatomic,weak) UIImageView  * p_backImageV1;
@property (nonatomic,weak) UIImageView  * p_backImageV2;
@property (nonatomic,strong) NSString * m_content;
@end

@implementation Ocean_ShareManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享";
    CGFloat y = screen_Height *243/781;
    CGFloat W = SCREEN_WIDTH /2 -10;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *iamgeV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iamgeV.y = 64;
    iamgeV.height -=64;
    iamgeV.image = [UIImage imageNamed:@""];
    [self.view addSubview:iamgeV];
    self.p_backImageV = iamgeV;
    
    UIImageView *iamgeV1 = [[UIImageView alloc]init];
    [self.view addSubview:iamgeV1];
    iamgeV1.x = 5;
    iamgeV1.width = iamgeV1.height = W;
    iamgeV1.y = y;
    self.p_backImageV1 = iamgeV1;
    
    UIImageView *iamgeV2 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:iamgeV2];
    iamgeV2.x = SCREEN_WIDTH/2 +5;
    iamgeV2.width =iamgeV2.height = W;
    iamgeV2.y = iamgeV1.y;
    self.p_backImageV2 = iamgeV2;
    [self QRCODE1];
    [self QRCODE2];
    
    UILabel *title1 = [[UILabel alloc]init];
    title1.text = @"扫描下载APP";
    title1.font = [UIFont systemFontOfSize:15];
    [title1 sizeToFit];
    [self.view addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc]init];
    title2.font = [UIFont systemFontOfSize:15];

    title2.text = @"扫码进入官网";
    [title2 sizeToFit];
    
    [self.view addSubview:title2];
    
    
    
    title1.y = title2.y = iamgeV1.bottom +15;
    title1.centerX = iamgeV1.centerX;
    title2.centerX = iamgeV2.centerX;
    
    UIButton *rightbutton  =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage:[UIImage imageNamed:@"threePoint"] forState:0];
    [rightbutton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [rightbutton sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];;

    
}

-(void)share{

    if (!self.m_content.length) {
        [MBProgressHUD showWarnMessage:@"暂未获取分享信息"];
        return;
    }
    [YiRenShareTools ShareTitle:@"注册&下载" andiconName:@"HYZXIcon" andInfo:@"" andUrl:self.m_content];
    
}

-(void)QRCODE1{
    
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_flag":@"0"} methodName:@"QRCODE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
            NSString *str =  respInfo[@"m_content"];
                self.m_content = str;
            CGFloat W = SCREEN_WIDTH /2 -10;
            weakSelf.p_backImageV1.image =  [UIImage imageForCodeString:str size:W color:BackgroundColors(1) pattern:1];
                UIImageView *iconImage = [[UIImageView alloc]init];
                NSString *icon = @"HYZXIcon";
                iconImage.image = [UIImage imageNamed:icon];
                [weakSelf.p_backImageV1 addSubview:iconImage];
                CGFloat iconW = weakSelf.p_backImageV1.width *48/214;
                iconImage.size = CGSizeMake(iconW, iconW);
                iconImage.centerX = weakSelf.p_backImageV1.width/2;
                iconImage.centerY = weakSelf.p_backImageV1.height/2;
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];


    

}

-(void)QRCODE2{
    
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_flag":@"1"} methodName:@"QRCODE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [weakSelf.p_backImageV2 sd_setImageWithURL:[NSURL URLWithString:respInfo[@"m_content"]]];
                
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
    
    
    
}



@end

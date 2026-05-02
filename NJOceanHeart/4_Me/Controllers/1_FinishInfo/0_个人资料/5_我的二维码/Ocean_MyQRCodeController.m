//
//  Ocean_MyQRCodeController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/9.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MyQRCodeController.h"
#import "UIImage+Zirkfied.h"
#include "NSData+AES256.h"

@interface Ocean_MyQRCodeController ()

@property (nonatomic,weak) UIView * p_QRimageV1;
@property (nonatomic,weak) UIView * p_QRimageV2;
@end

@implementation Ocean_MyQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    CGFloat Left = screen_Width *82/480;
//    CGFloat W = SCREEN_WIDTH - 2*Left;
    
    imageV.image = [UIImage imageNamed:@""];
    [self.view addSubview:imageV];
    self.p_QRimageV1 = [self creatQRImageV:CGRectMake(0, screen_Height *60/796 +64, screen_Width, screen_Height *267/796) andTitle:@"扫一扫上面的二维码图案,加我好友" andKey:[Ocean_UserInfo sharedOcean_UserInfo].m_uid andType:@"1" QRColor: BackgroundColors(1)];
    
    self.p_QRimageV2 = [self creatQRImageV:CGRectMake(0, screen_Height *60/796, screen_Width, screen_Height *267/796) andTitle:@"无须添加好友,扫二维码向我付款" andKey:[Ocean_UserInfo sharedOcean_UserInfo].m_uid andType:@"3" QRColor:[UIColor blueColor]];
    
    self.p_QRimageV2.bottom = self.view.height - 20;
    
    

}

-(UIView *)creatQRImageV:(CGRect)rect andTitle:(NSString *)title andKey:(NSString *)key andType:(NSString *)type QRColor:(UIColor *)color{
    
    UIView *QRView =[[UIView alloc]initWithFrame:rect];
    [self.view addSubview:QRView];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    CGFloat Left = screen_Width *117/447;
        CGFloat W = SCREEN_WIDTH - 2*Left;
    
  
    
    NSString* enKey = [NSData AES256EncryptWithPlainText:key];
    NSString *infoStr = [NSString stringWithFormat:@"%@&&%@",type,enKey];
    
    
    [QRView addSubview:imageV];
    imageV.x = Left;
    imageV.height = imageV.width = W;
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    CGFloat iconW= imageV.width *54 /210;
    iconImage.size = CGSizeMake(iconW, iconW);
    iconImage.centerX = imageV.height/2;
    iconImage.centerY = imageV.height/2;
    iconImage.image = [UIImage imageNamed:icon];
    [imageV addSubview:iconImage];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = BackgroundColors(1);
    label.font = [UIFont systemFontOfSize:14];
    label.text= title;
    [QRView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.x =0;
    label.height = 15;
    label.width = QRView.width;
    label.bottom = QRView.height;
    
    imageV.image = [self creatQR:infoStr :W :color];
    
    return QRView;
    
}

-(UIImage *)creatQR:(NSString *)str :(CGFloat)W :(UIColor*)color{
    
    return  [UIImage imageForCodeString:str size:W color:color pattern:1];
    
}

@end

//
//  Ocean_AboutOurController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AboutOurController.h"
#import "Ocean_TransferAccountsController.h"
#import "YiRenShareTools.h"
@interface Ocean_AboutOurController ()
@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)UILabel *versionLabel;
@property (strong, nonatomic)UILabel *nameLabel;
@property (strong, nonatomic)UILabel *contentLabel;
@property (strong, nonatomic)UILabel *phoneLabel;
@property (nonatomic,weak) WKWebView * webView;
@end

@implementation Ocean_AboutOurController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =@"关于我们";
    
    [self initView];
}
- (void)initView {
    UIImageView *iamgeV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iamgeV.y = 64;
    iamgeV.height -=64;
    iamgeV.image = [UIImage imageNamed:@"shareBackImage"];
    [self.view addSubview:iamgeV];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.y = 64 ;
    webView.backgroundColor = [UIColor clearColor];
    self.webView = webView;
    [webView setOpaque:NO];
    [self.view addSubview:webView];
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HYZXIcon"]];
    iconImage.height = iconImage.width = screen_Width *132/479;
    iconImage.y = 20 +64;
    iconImage.centerX = screen_Width/2;
    [self.view addSubview:iconImage];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"V%@",appCurVersion];
    label.width = screen_Width;
    label.font = [UIFont systemFontOfSize:16];
    label.height = 16;
    label.textAlignment = NSTextAlignmentCenter;
    label.y = iconImage.bottom +15;
    [self.view addSubview:label];
    
    webView.y = label.bottom +20;
    webView.height = self.view.height - webView.y;
    
    UILabel *bottomLb1 =[[UILabel alloc]init];
    bottomLb1.text = @"86-15996306872";
    bottomLb1.font = [UIFont systemFontOfSize:14];
    bottomLb1.textAlignment = NSTextAlignmentCenter;
    bottomLb1.height = 15;
    [self.view addSubview:bottomLb1];
    
    UILabel *bottomLb =[[UILabel alloc]init];
    bottomLb.text = @"南京轩瑞网络科技有限公司";
    bottomLb.font = [UIFont systemFontOfSize:14];
    bottomLb.textAlignment = NSTextAlignmentCenter;
    bottomLb.height = 15;
    [self.view addSubview:bottomLb];
    
    bottomLb1.width = bottomLb.width = self.view.width;
    
    bottomLb1.bottom = self.view.height - 10;
    bottomLb.bottom = bottomLb1.y -10;
    
    webView.height -=(self.view.height - bottomLb.y);

    
    
    [self SETTLEMENTAGREEMENT];
}

-(void)share{

    


}

-(void)SETTLEMENTAGREEMENT{
        
        MJWeakSelf;
        [HttpRequestTools  requestUNUserInfoWithData:@{@"m_flag":@"3"} methodName:@"SETTLEMENTAGREEMENT" completion:^(id respInfo, NSError *error) {
            if (!error) {
                if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                    
                    [weakSelf.webView loadHTMLString:respInfo[@"m_content"] baseURL:[NSURL URLWithString:@"www.baidu.com"]];
                    
                    
                }else{
                    [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
                }
            }else{
                [MBProgressHUD showErrorMessage:@"网路问题..."];
            }
        }];
        
        
        
    }
@end

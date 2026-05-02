//
//  Ocean_EnterStoreProtolController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_EnterStoreProtolController.h"
#import <WebKit/WebKit.h>

@interface Ocean_EnterStoreProtolController ()
@property (nonatomic,weak) UIWebView * webView;
@end

@implementation Ocean_EnterStoreProtolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView = webView;
    [self.view addSubview:webView];

    
    [self SETTLEMENTAGREEMENT];
}

-(void)SETTLEMENTAGREEMENT{
    
    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_flag":self.m_flag} methodName:@"SETTLEMENTAGREEMENT" completion:^(id respInfo, NSError *error) {
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

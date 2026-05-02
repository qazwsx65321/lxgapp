//
//  Ocean_NewsDetailVC.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/13.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_NewsDetailVC.h"

@interface Ocean_NewsDetailVC ()<UIWebViewDelegate>

@end

@implementation Ocean_NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻详情";
    
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    webView.backgroundColor = [UIColor lightlightGrayColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    webView.delegate = self;
    [self.view addSubview:webView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBProgressHUD hideHUD];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

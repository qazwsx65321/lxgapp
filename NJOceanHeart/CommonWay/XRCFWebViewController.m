//
//  XRCFWebViewController.m
//  NJXRCharterFlights
//
//  Created by houyi.chu on 2018/11/13.
//  Copyright © 2018年 qiushi. All rights reserved.
//

#import "XRCFWebViewController.h"
#import <WebKit/WebKit.h>

#define XRBackgroundColors  [UIColor colorWithHexString:@"4c4c4e" alpha:1]
//20260504 moidfy
@interface XRCFWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong)WKWebView * webView;

@end

@implementation XRCFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XRBackgroundColors;
    [self setWebView];
}
-(void)setWebView{
    
    self.webView = [[WKWebView alloc] init];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    
    if (self.webBackColor) {
        self.webView.scrollView.backgroundColor = self.webBackColor;
    }

//    self.webView.sd_layout
//    .leftEqualToView(self.view)
//    .topSpaceToView(self.view, 0)
//    .rightEqualToView(self.view)
//    .bottomEqualToView(self.view);
    self.webView.frame = CGRectMake(0, 0, screen_Width, screen_Height);
    
}
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
//    self.title = webView.title;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;

    if (navigationAction.navigationType==WKNavigationTypeBackForward) {//判断是返回类型
    }
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}

@end

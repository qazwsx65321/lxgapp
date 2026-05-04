//
//  Ocean_WuliuWebController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/24.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_WuliuWebController.h"

@interface Ocean_WuliuWebController ()

@end

@implementation Ocean_WuliuWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"物流详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *comurl =[self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:comurl]]];
    [self.view addSubview:webView];
    
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

//
//  Ocean_ProclamationDetailController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ProclamationDetailController.h"

@interface ProclamationDetailModel : NSObject

@property (nonatomic,strong) NSString * m_title;
@property (nonatomic,strong) NSString * m_listpic;
@property (nonatomic,strong) NSString * m_content;
@property (nonatomic,strong) NSString * m_buildtime;

@end

@implementation ProclamationDetailModel


@end


@interface Ocean_ProclamationDetailController ()
@property (nonatomic,weak) UIWebView * webView;
@property (nonatomic,strong) ProclamationDetailModel * model;
@end

@implementation Ocean_ProclamationDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView = webView;
    [self.view addSubview:webView];
    [self NOTICEDETAIL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)NOTICEDETAIL{

    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:@{@"m_id":self.m_id} methodName:@"NOTICEDETAIL" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                weakSelf.model = [ProclamationDetailModel mj_objectWithKeyValues:respInfo];
                [weakSelf.webView loadHTMLString:weakSelf.model.m_content baseURL:[NSURL URLWithString:@"www.baidu.com"]];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
                
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];


}

@end

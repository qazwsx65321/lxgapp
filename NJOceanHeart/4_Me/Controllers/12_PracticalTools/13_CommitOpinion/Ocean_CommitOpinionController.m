//
//  Ocean_CommitOpinionController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/24.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_CommitOpinionController.h"
#import "XDTextView.h"
@interface Ocean_CommitOpinionController ()<XDTextViewDelegate>
@property (nonatomic,weak) XDTextView * p_xdtv;
@property (nonatomic,weak) UILabel * p_label;
@end

@implementation Ocean_CommitOpinionController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"意见反馈";
    
    UILabel*label = [[UILabel alloc]init];
    [self.view addSubview:label];
    
    XDTextView *xdTV = [[XDTextView alloc]init];
    xdTV.width = screen_Width *200/218;
    xdTV.height = xdTV.width*142 /202;
    xdTV.y = 15+64;
    self.p_xdtv = xdTV;
    xdTV.delegate =self;
    xdTV.centerX = self.view.width/2;
    xdTV.layer.cornerRadius = 5;
    xdTV.layer.masksToBounds = YES;
    xdTV.layer.borderColor = BackgroundColors(1).CGColor;
    xdTV.layer.borderWidth = 1;
    xdTV.XD_font = [UIFont systemFontOfSize:14];
    xdTV.XD_placehodel = @"请留下您的宝贵建议";
    
    [self.view addSubview:xdTV];
    
    label.width = xdTV.width;
    label.textAlignment = NSTextAlignmentRight;
    label.x = xdTV.x;
    label.y = xdTV.bottom +15;
    label.height = 16;
    self.p_label = label;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"0/300";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:BackgroundColors(1)];
    [btn addTarget:self action:@selector(clickAccount) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    
    btn.width = screen_Width *190/218;
    btn.height = screen_Width *35/218;
    btn.centerX = screen_Width/2;
    btn.bottom = self.view.height - self.view.height/6;
    
    
}

- (void)didChangeXDText:(XDTextView *)textView{
    
    NSLog(@"%@",textView.XD_text);
    
    if (textView.XD_text.length>300) {
        self.p_label.textColor = BackgroundColors(1);
        self.p_label.text = @"内容超出范围";
        textView.XD_textColor = BackgroundColors(1);
    }else{
    self.p_label.textColor = [UIColor blackColor];
     self.p_label.text = [NSString stringWithFormat:@"%ld/300",textView.XD_text.length];
    textView.XD_textColor = [UIColor lightGrayColor];

    }
    
   

}

-(void)clickAccount{

    if (!_p_xdtv.XD_text.length) {
        [MBProgressHUD showErrorMessage:@"请输入内容后提交"];
        return;
    }else if (_p_xdtv.XD_text.length>300){
    
        [MBProgressHUD showErrorMessage:@"超出范围无法提交"];

        return;
    }
    
    NSString *uid = [Ocean_UserInfo sharedOcean_UserInfo].m_uid.length?[Ocean_UserInfo sharedOcean_UserInfo].m_uid:@"";
    
    [MBProgressHUD showActivityMessageInView:@""];
    
    [HttpRequestTools  requestUNUserInfoWithData:@{
                                                   @"m_content":_p_xdtv.XD_text,
                                                   @"m_uid":uid
                                                   } methodName:@"FEEDBACKCOMMIT" completion:^(id respInfo, NSError *error) {
                                                       [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                [MBProgressHUD showSuccessMessage:@"提交成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];


}


@end

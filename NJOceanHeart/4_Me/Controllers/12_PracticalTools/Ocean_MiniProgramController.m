//
//  Ocean_MiniProgramController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/14.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MiniProgramController.h"


@interface Ocean_MiniProgramController ()

@end

@implementation Ocean_MiniProgramController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




- (void)usingToolsPayWithID:(NSString *)toolid withPrice:(NSString *)toolprice withSuccess:(void(^)(void))success  {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_sid":toolid,
                          @"m_price":toolprice
                          };
    
    
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"USINGTOOLSPAY" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                if (success) {
                    success();
                }
                
            }else{
                [MBProgressHUD showTipMessageInWindow:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showTipMessageInWindow:@"网路问题..."];
        }
        
    }];
    
    
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

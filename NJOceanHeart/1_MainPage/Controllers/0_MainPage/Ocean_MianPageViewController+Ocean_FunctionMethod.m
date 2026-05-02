//
//  Ocean_MianPageViewController+Ocean_FunctionMethod.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MianPageViewController+Ocean_FunctionMethod.h"
#import "Ocean_FriendInfoModel.h"
#import "Ocean_TransferAccountsController.h"
@implementation Ocean_MianPageViewController (Ocean_FunctionMethod)

-(void)getUserinfoFromQRUid:(NSString *)m_uid{

    MJWeakSelf;
    
    [MBProgressHUD showActivityMessageInView:@""];
    
    [HttpRequestTools  requestUserInfoWithData:@{@"m_fuid":m_uid} methodName:@"GETFRIENDSINFO" completion:^(id respInfo, NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                Ocean_FriendInfoModel *model = [Ocean_FriendInfoModel mj_objectWithKeyValues:respInfo];
                Ocean_TransferAccountsController *transVC = [[Ocean_TransferAccountsController alloc]init];
                transVC.m_infoModel = model;
                transVC.m_fuid = m_uid;
                [weakSelf.navigationController pushViewController:transVC animated:YES];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];


}

@end

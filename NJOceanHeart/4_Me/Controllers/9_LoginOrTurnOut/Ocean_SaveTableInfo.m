//
//  Ocean_SaveTableInfo.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_SaveTableInfo.h"

#import "Ocean_GroupModel.h"
#import "Ocean_FriendsModel.h"

@implementation Ocean_SaveTableInfo


//存好友信息
+ (void)saveFriendsInfo {
    [HttpRequestTools requestUserInfoWithData:nil methodName:@"GETFRIENDS" completion:^(id respInfo, NSError *error) {
        
        if (!error) {
            
            Ocean_FriendsHead *head = [Ocean_FriendsHead mj_objectWithKeyValues:respInfo];
            
            if ([head.ERRORCODE isEqualToString:@"0000"]) {
                
                for (Ocean_FriendsModel *model in head.m_myfriends) {
                    J_Insert(model).updateResult;
                }
                
                
                
            }else{
                
            }
        }else{
           
        }
        
        
        
    }];
}

//存群组信息
+ (void)saveGroup {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[Ocean_UserInfo sharedOcean_UserInfo].m_uid,@"m_uid",
                         [Ocean_UserInfo sharedOcean_UserInfo].m_session,@"m_session",
                         @"0",@"m_type",nil];
    [HttpRequestTools  requestUNUserInfoWithData:dic methodName:@"GETGROUPLIST" completion:^(id respInfo, NSError *error) {
        
        [MBProgressHUD hideHUD];
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                Ocean_GroupHead *head = [Ocean_GroupHead mj_objectWithKeyValues:respInfo];
                
                for (Ocean_GroupModel *model in head.m_myfriends) {
                    J_Insert(model).updateResult;
                }
                
            }else{
                
            }
        }else{
            
        }
        
    }];
}

@end

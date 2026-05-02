//
//  Ocean_XDConnectRongCloud+Ocean_GetInfo.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XDConnectRongCloud+Ocean_GetInfo.h"

#import "Ocean_GroupModel.h"
#import "Ocean_FriendsModel.h"

@implementation Ocean_XDConnectRongCloud (Ocean_GetInfo)


- (RCUserInfo *)getFriendInfo:(NSString *)userId {
    
    NSArray *result = J_Select(Ocean_FriendsModel).Where([NSString stringWithFormat:@"m_uid = '%@'",userId]).list;
    

    if (result.count) {
        Ocean_FriendsModel *model = result[0];
        RCUserInfo *user = [[RCUserInfo alloc] init];
        user.userId = model.m_uid;
        user.name = model.m_nickname;
        user.portraitUri = model.m_headpic;
        
        return user;
        
    }else {
        return [RCUserInfo new];
    }
    
}


- (RCGroup *)getGroupInfo:(NSString *)groupId {
    
    NSArray *result = J_Select(Ocean_GroupModel).Where([NSString stringWithFormat:@"m_qid = '%@'",groupId]).list;
    
    if (result.count) {
        Ocean_GroupModel *model = result[0];
        RCGroup *groupinfo = [[RCGroup alloc] init];
        groupinfo.groupId = model.m_qid;
        groupinfo.groupName = model.m_name;
        groupinfo.portraitUri = model.m_picture;
        
        return groupinfo;
        
    }else {
        return [RCGroup new];
    }
    
}

@end

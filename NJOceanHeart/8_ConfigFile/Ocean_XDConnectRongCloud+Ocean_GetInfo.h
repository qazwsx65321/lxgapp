//
//  Ocean_XDConnectRongCloud+Ocean_GetInfo.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XDConnectRongCloud.h"

@interface Ocean_XDConnectRongCloud (Ocean_GetInfo)

- (RCUserInfo *)getFriendInfo:(NSString *)userId;

- (RCGroup *)getGroupInfo:(NSString *)groupId;

@end

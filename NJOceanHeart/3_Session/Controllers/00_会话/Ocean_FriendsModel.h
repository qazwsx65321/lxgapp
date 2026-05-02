//
//  Ocean_FriendsModel.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_FriendsModel : NSObject
@property (nonatomic,copy) NSString *m_uid;
@property (nonatomic,copy) NSString *m_token;
@property (nonatomic,copy) NSString *m_nickname;
@property (nonatomic,copy) NSString *m_phone;
@property (nonatomic,copy) NSString *m_headpic;
@property (nonatomic,copy) NSString *m_mark;

@end

@interface Ocean_FriendsHead : NSObject

@property (nonatomic,copy) NSString *ERRORCODE;
@property (nonatomic,copy) NSString *ERRORDESTRIPTION;
@property (nonatomic,strong) NSArray *m_myfriends;

@end

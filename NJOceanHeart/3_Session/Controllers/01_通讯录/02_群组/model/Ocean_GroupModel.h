//
//  Ocean_GroupModel.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_GroupModel : NSObject

@property (nonatomic,copy) NSString *m_qid;
@property (nonatomic,copy) NSString *m_picture;
@property (nonatomic,copy) NSString *m_name;
@property (nonatomic,strong) NSArray *m_myfriends0;

@end


@interface Ocean_GroupHead : NSObject

@property (nonatomic,copy) NSString *ERRORCODE;
@property (nonatomic,copy) NSString *ERRORDESTRIPTION;
@property (nonatomic,strong) NSArray *m_myfriends;

@end


@interface Ocean_GroupBody : NSObject

@property (nonatomic,copy) NSString *m_uid;
@property (nonatomic,copy) NSString *m_headpic;
@property (nonatomic,copy) NSString *m_mark;
@property (nonatomic,copy) NSString *m_ismanager;

@end


@interface Ocean_GroupMemberHead : NSObject

@property (nonatomic,copy) NSString *ERRORCODE;
@property (nonatomic,copy) NSString *ERRORDESTRIPTION;
@property (nonatomic,strong) NSArray *m_myfriends;

@end


@interface Ocean_GroupMemberModel : NSObject

@property (nonatomic,copy) NSString *m_uid;
@property (nonatomic,copy) NSString *m_token;
@property (nonatomic,copy) NSString *m_headpic;
@property (nonatomic,copy) NSString *m_mark;
@property (nonatomic,copy) NSString *m_ismanager;

@end

//
//  UserCommentModel.h
//  Glad9TM
//
//  Created by 陈志伟 on 17/6/8.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCommentModel : NSObject

@property (nonatomic,copy) NSString *m_headpicture;
@property (nonatomic,copy) NSString *m_name;
@property (nonatomic,copy) NSString *m_buildtime;
@property (nonatomic,copy) NSString *m_star;
@property (nonatomic,copy) NSString *m_content;
@property (nonatomic,strong) NSArray *m_picturedesc;

@end

@interface UserCommentHead : NSObject

@property (nonatomic,copy) NSString *ERRORCODE;
@property (nonatomic,copy) NSString *ERRORDESTRIPTION;
@property (nonatomic,strong) NSArray *EVALUATEINFO;

@end

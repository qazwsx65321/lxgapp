//
//  GoodDetailCommentBody.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/3.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDetailCommentBody : NSObject

@end

@interface GoodDetailCommentReqBody : GoodDetailCommentBody

@property (nonatomic, copy)NSString *JUDGEMETHOD;
@property (nonatomic, copy)NSString *m_goodsid;

@end

@interface GoodDetailCommentRespBody : GoodDetailCommentBody

@property (nonatomic, copy)NSString *ERRORCODE;
@property (nonatomic, copy)NSString *ERRORDESTRIPTION;
@property (nonatomic, strong)NSArray *EVALUATEINFO;

@end

@interface GoodDetailCommentModel : NSObject

@property (nonatomic, copy)NSString *m_headpicture;
@property (nonatomic, copy)NSString *m_name;
@property (nonatomic, copy)NSString *m_content;
@property (nonatomic, copy)NSString *m_buildtime;
@property (nonatomic, copy)NSString *m_star;

@end


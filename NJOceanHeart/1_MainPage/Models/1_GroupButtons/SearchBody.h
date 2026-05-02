//
//  SearchBody.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/17.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchBody : NSObject

@end

@interface SearchReqBody : SearchBody

@property (nonatomic, copy)NSString *JUDGEMETHOD;
@property (nonatomic, copy)NSString *m_content;
@property (nonatomic, copy)NSString *m_flag;

@end

@interface SearchRespBody : SearchBody

@property (nonatomic, copy)NSString *ERRORCODE;
@property (nonatomic, copy)NSString *ERRORDESTRIPTION;
@property (nonatomic, strong)NSArray *GOODSINFO;

@end

@interface SearchModel : NSObject

@property (nonatomic, copy)NSString *m_picturelist;
@property (nonatomic, copy)NSString *m_name;
@property (nonatomic, copy)NSString *m_price;
@property (nonatomic, copy)NSString *m_oldprice;
@property (nonatomic, copy)NSString *m_goodsid;

@end

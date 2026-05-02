//
//  MeOrderCountBody.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/5/5.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeOrderCountBody : NSObject

@end

@interface MeOrderCountReqBody : MeOrderCountBody

@property (nonatomic, copy)NSString *JUDGEMETHOD;
@property (nonatomic, copy)NSString *m_userid;

@end

@interface MeOrderCountRespBody : MeOrderCountBody

@property (nonatomic, copy)NSString *ERRORCODE;
@property (nonatomic, copy)NSString *ERRORDESTRIPTION;
@property (nonatomic, copy)NSString *m_num0;
@property (nonatomic, copy)NSString *m_num1;
@property (nonatomic, copy)NSString *m_num2;
@property (nonatomic, copy)NSString *m_num3;
@property (nonatomic, copy)NSString *m_num4;

@end

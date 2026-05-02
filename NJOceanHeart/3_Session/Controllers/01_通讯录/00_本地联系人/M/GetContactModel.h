//
//  GetContactModel.h
//  X16.QiHu
//
//  Created by 史伟文 on 16/10/25.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetContactModel : NSObject

@end

@interface GetContactReqBody : GetContactModel

@property (nonatomic, copy)NSString *Interface;
@property (nonatomic, copy)NSString *Userid;
@property (nonatomic, copy)NSString *Session;

@end

@interface GetContactRespBody : GetContactModel

@property (nonatomic, copy)NSString *Code;
@property (nonatomic, copy)NSString *Desp;
@property (nonatomic, strong)NSArray *myInfo;

@end

@interface ContactInfoModel : NSObject

@property (nonatomic, copy)NSString *Token;
@property (nonatomic, copy)NSString *Userphone;
@property (nonatomic, copy)NSString *Headpic;
@property (nonatomic, copy)NSString *Username;

@end

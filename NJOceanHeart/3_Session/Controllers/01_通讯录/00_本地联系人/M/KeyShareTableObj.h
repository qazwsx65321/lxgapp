//
//  KeyShareTableObj.h
//  DBDemo
//
//  Created by qiushi on 2016/12/22.
//  Copyright © 2016年 JXTL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyShareTableObj : NSObject

+(instancetype)initWithDictionary:(NSDictionary *)paramdic;

@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *userid;
@property (nonatomic,copy)NSString *deviceid;
@property (nonatomic,copy)NSString *devicename;
@property (nonatomic,copy)NSString *usecount;
@property (nonatomic,copy)NSString *starttime;
@property (nonatomic,copy)NSString *endtime;
@property (nonatomic,copy)NSString *updatetime;
@property (nonatomic,copy)NSString *status;

@end

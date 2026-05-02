//
//  KeyShareTableObj.m
//  DBDemo
//
//  Created by qiushi on 2016/12/22.
//  Copyright © 2016年 JXTL. All rights reserved.
//

#import "KeyShareTableObj.h"

@implementation KeyShareTableObj
+(instancetype)initWithDictionary:(NSDictionary *)paramdic{
    KeyShareTableObj *obj = [KeyShareTableObj new];
    obj.devicename = paramdic[@"devicename"];
    obj.username = paramdic[@"tousername"];
    obj.userid =  paramdic[@"touserId"];
    obj.deviceid = paramdic[@"deviceId"];
    obj.starttime = paramdic[@"starttime"];
    obj.endtime = paramdic[@"endtime"];
    obj.updatetime = paramdic[@"updatetime"];
    obj.status = paramdic[@"status"];

    return obj;
}
@end

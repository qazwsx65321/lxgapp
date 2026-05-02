//
//  SharTransverterConnect.m
//  IntelligentLock
//
//  Created by qiushi on 2016/12/28.
//  Copyright © 2016年 JXTL. All rights reserved.
//

#import "SharTransverterConnect.h"
#import "KeyShareTableObj.h"
#import "ContactModel.h"
#import "Ocean_SearchModel.h"
@implementation SharTransverterConnect

+(NSArray *)ShareModelTransConnect:(NSArray *)keyShareArr{
    NSMutableArray *mutalArr  =[NSMutableArray array];
    for (KeyShareTableObj *keyModel in keyShareArr) {
        
        ContactModel *model = [ContactModel new];
        model.name = keyModel.username;
        
        model.phone = keyModel.userid;
        [mutalArr addObject:model];
    }
    return mutalArr;
}

+(NSArray *)AddressModelTransConnect:(NSArray *)AddressArr{

    NSMutableArray *mutalArr  =[NSMutableArray array];
    for (Ocean_SearchModel *matchModel in AddressArr) {
        
        ContactModel *model = [ContactModel new];
        model.uid = matchModel.m_uid;
        model.name = matchModel.m_nickname;
        model.phone = matchModel.m_phone;
        model.type = matchModel.m_isfriend;
        model.iconUrl = matchModel.m_headpic;
        [mutalArr addObject:model];
    }
    return mutalArr;
}

@end

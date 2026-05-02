//
//  Ocean_XDTableObject.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XDTableObject.h"
#import "Ocean_GroupModel.h"
#import "Ocean_FriendsModel.h"

@implementation Ocean_XDTableObject

+(void)CreateTableObj {
        
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",@"OceanTable"]];
    //NSLog(@"%@",filePath);
    //初始化数据库
    [[JRDBMgr shareInstance] setDefaultDatabasePath:filePath];

    
//    [[JRDBMgr shareInstance] setDefaultDatabasePath:[JRDBMgr shareInstance].defaultDatabasePath];
    
    [[JRDBMgr shareInstance] registerClazzes:@[
                                             [Ocean_GroupModel class],
                                             [Ocean_FriendsModel class]
                                             ]];
    
    J_CreateTable(Ocean_GroupModel);
    J_CreateTable(Ocean_FriendsModel);
    
}

@end

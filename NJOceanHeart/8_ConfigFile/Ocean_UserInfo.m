//
//  Ocean_UserInfo.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_UserInfo.h"
#import "UICKeyChainStore.h"
@implementation Ocean_UserInfo

singleton_m(Ocean_UserInfo)

-(void)setInfoData{
    
   UICKeyChainStore*keyChain =  [[UICKeyChainStore alloc]initWithService:@"com.nanjinghyzx.userinfo"];
    [keyChain removeAllItems];

    NSDictionary *infoDic =[self mj_keyValues];
    [infoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"isLogin"]) {
            [[NSUserDefaults standardUserDefaults]setBool:_isLogin forKey:@"isLogin"];
        }else{
            [keyChain setString:obj forKey:key];
        }
    }];
    
}




-(void)initInfoData{
    _isLogin =  [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    if (_isLogin) {
        UICKeyChainStore*keyChain =  [[UICKeyChainStore alloc]initWithService:@"com.nanjinghyzx.userinfo"];
        NSArray *arr = keyChain.allItems;
        for (NSDictionary *dic in arr) {
            NSMutableDictionary *objectdic= [NSMutableDictionary dictionaryWithObjectsAndKeys:dic[@"value"],dic[@"key"],nil];
            [self mj_setKeyValues:objectdic];
            //        [self setValue:dic[@"value"] forKey:dic[@"key"]];
        }
    }
}

-(void)saveValue:(NSString *)value forKey:(NSString *)key{
    [self setValue:value forKey:key];
    UICKeyChainStore*keyChain =  [[UICKeyChainStore alloc]initWithService:@"com.nanjinghyzx.userinfo"];
    [keyChain setString:value forKey:key];
    [[NSUserDefaults standardUserDefaults]setBool:_isLogin forKey:@"isLogin"];
}

-(void)removeKeyChain{
    
    UICKeyChainStore*keyChain =  [[UICKeyChainStore alloc]initWithService:@"com.nanjinghyzx.userinfo"];
    [keyChain removeAllItems];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    NSDictionary *infoDic =[self mj_keyValues];
    [infoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"isLogin"]) {
            self.isLogin = NO;
        }else{
            [self setValue:nil forKey:key];
        }
    }];

}

@end

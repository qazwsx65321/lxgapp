//
//  KX9UserHistoryTable.m
//  Glad9TM
//
//  Created by qiushi on 2017/6/29.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "KX9UserHistoryTable.h"

@implementation KX9UserHistoryTable

-(NSArray *)formHistoryTabelGetInfo{
    
    if (!_m_searchKey) {
        return nil;
    }
    NSError *error;
    NSArray *arr= [NSJSONSerialization JSONObjectWithData:[_m_searchKey dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    return arr;
}

-(void)setKeyFrom:(NSArray *)arr{
    NSString *jsonstr = [[NSString alloc]initWithData:arr.mj_JSONData encoding:NSUTF8StringEncoding];
    _m_searchKey = jsonstr;
}

@end

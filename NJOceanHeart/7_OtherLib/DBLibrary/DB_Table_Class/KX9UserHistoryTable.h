//
//  KX9UserHistoryTable.h
//  Glad9TM
//
//  Created by qiushi on 2017/6/29.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KX9UserHistoryTable : NSObject

@property (nonatomic,strong) NSString * m_searchKey;

@property (nonatomic,strong) NSString  * m_userId;

-(NSArray *)formHistoryTabelGetInfo;

-(void)setKeyFrom:(NSArray *)arr;

@end

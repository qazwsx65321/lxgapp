//
//  Ocean_RecommandModel.h
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_RecommandModel : NSObject

@property (nonatomic, strong)NSString *m_name;
@property (nonatomic, strong)NSString *m_phone;
@property (nonatomic, strong)NSString *m_num;
@property (nonatomic, strong)NSString *m_pageSize;
@property (nonatomic, strong)NSArray *m_list;

@end

@interface Ocean_RecommandBody : NSObject

@property (nonatomic, strong)NSString *m_name;
@property (nonatomic, strong)NSString *m_phone;
@property (nonatomic, strong)NSString *m_buildtime;

@end

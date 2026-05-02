//
//  Ocean_GroupModel.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupModel.h"

@implementation Ocean_GroupModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"m_myfriends0":@"Ocean_GroupBody"};
}

@end

@implementation Ocean_GroupHead

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"m_myfriends":@"Ocean_GroupModel"};
}

@end

@implementation Ocean_GroupBody

@end

@implementation Ocean_GroupMemberHead

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"m_myfriends":@"Ocean_GroupMemberModel"};
}

@end


@implementation Ocean_GroupMemberModel

@end

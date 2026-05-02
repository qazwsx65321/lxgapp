//
//  Ocean_XDMessage.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/22.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XDMessage.h"

@implementation Ocean_XDMessage


+(instancetype)messageWithContent:(NSString *)content {
    Ocean_XDMessage *msg = [[Ocean_XDMessage alloc] init];
    if (msg) {
        msg.content = content;
    }
    
    return msg;
}

- (NSString *)conversationDigest
{
    return @"asdasdsad";
}

@end

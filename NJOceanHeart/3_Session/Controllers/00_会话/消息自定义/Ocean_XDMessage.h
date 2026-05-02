//
//  Ocean_XDMessage.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/22.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface Ocean_XDMessage : RCContactNotificationMessage<NSCoding,RCMessageContentView>

/** 文本消息内容 */
@property(nonatomic, strong) NSString* content;

/**
 * 根据参数创建文本消息对象
 * @param content 文本消息内容
 */
+(instancetype)messageWithContent:(NSString *)content;

@end

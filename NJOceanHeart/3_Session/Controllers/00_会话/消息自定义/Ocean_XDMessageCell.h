//
//  Ocean_XDMessageCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/22.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

/**
 * 文本消息Cell
 */
@interface Ocean_XDMessageCell : RCUnknownMessageCell

/**
 * 设置消息数据模型
 *
 * @param model 消息数据模型
 */
- (void)setDataModel:(RCMessageModel *)model;

@end

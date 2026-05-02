//
//  Ocean_XDMessageCell.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/22.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XDMessageCell.h"

@interface Ocean_XDMessageCell()


@end

@implementation Ocean_XDMessageCell




- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    
    
    if ([model.content isKindOfClass:[RCContactNotificationMessage class]]) {
        
        RCContactNotificationMessage *messagecontent = (RCContactNotificationMessage *) model.content;
        
        //NSLog(@"--->%@,====>%@",messagecontent.message,messagecontent.extra);
        
        self.messageLabel.text = messagecontent.message;
        
        CGSize mess = [StringSizeModel sizeWithText:self.messageLabel.text font:[UIFont systemFontOfSize:15]];
        
        self.messageLabel.size = CGSizeMake(mess.width+10, mess.height+5);
        self.messageLabel.centerX = self.centerX;
        
    }
    
//    NSArray *arr = [model.extra componentsSeparatedByString:@"&::&"];
    
    
    
    
    
}


@end

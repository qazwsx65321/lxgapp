//
//  Ocean_RevicedImageTool.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_RevicedImageTool.h"

@implementation Ocean_RevicedImageTool


-(instancetype)initWithUrl:(NSString *)imageUrlStr{

    if (self = [super init]) {
        [self sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    
            [self.delegate RevicedImageReloadPreView];
            
        }];
    }
    return self;

}
@end

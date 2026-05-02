//
//  Ocean_RevicedImageTool.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Ocean_RevicedImageToolDelegate <NSObject>

-(void)RevicedImageReloadPreView;

@end

@interface Ocean_RevicedImageTool : UIImageView


-(instancetype)initWithUrl:(NSString *)imageUrlStr;

@property (nonatomic,weak) id<Ocean_RevicedImageToolDelegate> delegate;

@end

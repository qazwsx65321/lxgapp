//
//  UIImage+FTImageToolBox.h
//  X16.QiHu
//
//  Created by 史伟文 on 16/9/18.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FTImageToolBox)

+ (UIImage *)resizeImageWithName:(NSString *)name;

+ (UIImage *)getImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

@end

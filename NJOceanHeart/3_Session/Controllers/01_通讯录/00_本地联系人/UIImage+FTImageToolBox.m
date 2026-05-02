//
//  UIImage+FTImageToolBox.m
//  X16.QiHu
//
//  Created by 史伟文 on 16/9/18.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import "UIImage+FTImageToolBox.h"

@implementation UIImage (FTImageToolBox)

+ (UIImage *)resizeImageWithName:(NSString *)name {
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage*) getImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end

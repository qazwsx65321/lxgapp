//
//  UIImage+XRImageToolBox.m
//  WEC4Teacher
//
//  Created by 史伟文 on 15/5/14.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import "UIImage+XRImageToolBox.h"

@implementation UIImage (XRImageToolBox)

+ (UIImage *)resizeImageWithName:(NSString *)name
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end

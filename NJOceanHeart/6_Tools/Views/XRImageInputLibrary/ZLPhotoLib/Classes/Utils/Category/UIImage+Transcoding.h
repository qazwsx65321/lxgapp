//
//  UIImage+Transcoding.h
//  AssertLibraryDemo
//
//  Created by 史伟文 on 15/12/3.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Transcoding)

- (NSString *)imageToBase64Data;

- (NSData *)imageToData;

- (NSData *)compressedImageData;

@end

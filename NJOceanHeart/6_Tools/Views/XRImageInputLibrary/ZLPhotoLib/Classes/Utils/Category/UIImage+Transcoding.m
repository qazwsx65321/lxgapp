//
//  UIImage+Transcoding.m
//  AssertLibraryDemo
//
//  Created by 史伟文 on 15/12/3.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import "UIImage+Transcoding.h"

@implementation UIImage (Transcoding)

- (NSString *)imageToBase64Data
{
    NSData *pData = UIImageJPEGRepresentation(self, 1.0);
    CGFloat ratio = 0.3;
    NSInteger ppdata = pData.length;
    while (pData.length > 10240)
    {
        pData = UIImageJPEGRepresentation(self, ratio);
        if(pData.length != ppdata)
        {
            ppdata = pData.length;
            ratio *= ratio;
            NSLog(@"%ld",pData.length);
        }
        else
            break;
    } ;
    NSData *photoData = [pData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [[NSString alloc] initWithData:photoData encoding:NSUTF8StringEncoding];
}


- (NSData *)imageToData {
    NSData *pData = UIImageJPEGRepresentation(self, 1.0);
    return pData;
}


- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(NSData *)compressedImageData{

    NSData *pData = UIImageJPEGRepresentation(self, 1.0);
    
    CGFloat ratio = 0.8;
    NSInteger ppdata = pData.length;
    UIImage *iamge = self;
    while (pData.length > 102400*3)
    {
        pData = UIImageJPEGRepresentation(iamge, ratio);
        
        iamge = [UIImage imageWithData:pData];
        
        if(pData.length != ppdata)
        {
            ppdata = pData.length;
            ratio *= ratio;
        }
        else
            break;
    } ;
    return pData;

}


@end

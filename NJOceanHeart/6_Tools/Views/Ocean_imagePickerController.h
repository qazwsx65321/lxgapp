//
//  Ocean_imagePickerController.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_imagePickerControllerDelegate <NSObject>

-(void)Ocean_imagePickerControllerdidFinishPickingImageData:(NSData *)imageData;

@end

@interface Ocean_imagePickerController : UIImagePickerController

@property (nonatomic,weak) id<Ocean_imagePickerControllerDelegate>pickerDelegate;

@end

//
//  Ocean_imagePickerController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/1.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_imagePickerController.h"

@interface Ocean_imagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation Ocean_imagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSUInteger imageLen = data.length;
    float scale = 0.8;
    while(imageLen > 1024 *200){
        data = UIImageJPEGRepresentation(image, scale);
        if(imageLen==data.length)break;
        scale *=0.8;
        imageLen = data.length;
    }
    [self.pickerDelegate Ocean_imagePickerControllerdidFinishPickingImageData:data];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)dealloc{
    
    NSLog(@"销毁了");

}

@end

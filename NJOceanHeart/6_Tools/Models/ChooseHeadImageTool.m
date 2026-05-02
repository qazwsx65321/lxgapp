//
//  ChooseHeadImageTool.m
//  WorkerPort
//
//  Created by qiushi on 2017/3/10.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "ChooseHeadImageTool.h"
@implementation ChooseHeadImageTool

+(void)chooseImageFormLibOrAlbum:(UIViewController *)rootVC Edit:(BOOL)edit andDelegate:(id<UIImagePickerControllerDelegate>)delegate{
    UIAlertController *alterC = [UIAlertController alertControllerWithTitle:@"选取图片" message:@"从相册或者摄像头获取图片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *libact = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum:rootVC Delegate:delegate Edit:edit];
    }];
    UIAlertAction *Camera = [UIAlertAction actionWithTitle:@"从相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectImageFromCamera:rootVC Delegate:delegate Edit:edit];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alterC addAction:libact];
    [alterC addAction:Camera];
    [alterC addAction:cancel];
    [rootVC presentViewController:alterC animated:YES completion:nil];
    
}



#pragma mark 从摄像头获取图片或视频
+ (void)selectImageFromCamera:(UIViewController *)Agent Delegate:(id<UIImagePickerControllerDelegate>)delegate Edit:(BOOL)edit
{
    
    Ocean_imagePickerController *imagePickerController = [[Ocean_imagePickerController alloc] init];
    imagePickerController.pickerDelegate = delegate;
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    imagePickerController.allowsEditing = edit;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [Agent presentViewController:imagePickerController animated:YES completion:nil];
}
#pragma mark 从相册获取图片或视频
+ (void)selectImageFromAlbum:(UIViewController *)Agent Delegate:(id<UIImagePickerControllerDelegate>)delegate Edit:(BOOL)edit
{
    Ocean_imagePickerController *imagePickerController = [[Ocean_imagePickerController alloc] init];
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    imagePickerController.pickerDelegate =delegate;
    imagePickerController.allowsEditing = edit;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [Agent presentViewController:imagePickerController animated:YES completion:nil];
}


@end

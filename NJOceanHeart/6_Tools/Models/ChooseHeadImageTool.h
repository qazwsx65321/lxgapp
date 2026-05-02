//
//  ChooseHeadImageTool.h
//  WorkerPort
//
//  Created by qiushi on 2017/3/10.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Ocean_imagePickerController.h"

@interface ChooseHeadImageTool : NSObject

+(void)chooseImageFormLibOrAlbum:(UIViewController *)rootVC Edit:(BOOL)edit andDelegate:(id<UIImagePickerControllerDelegate>)delegate;
@end

//
//  KX9UploadLocation.h
//  Glad9TM
//
//  Created by qiushi on 2017/7/18.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入base相关所有的头文件
typedef void(^callBack)(CLLocationCoordinate2D coord,NSError *LocationServiceError);

@interface KX9UploadLocation : NSObject
singleton_h(KX9UploadLocation);
-(void)startLocationAndUpLoad;
-(void)stopUpLoadLocation;

-(void)startLocationGetLongitudeAndLatitude:(callBack)backLocation;
@end

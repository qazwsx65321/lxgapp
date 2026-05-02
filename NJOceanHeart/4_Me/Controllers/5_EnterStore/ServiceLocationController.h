//
//  ServiceLocationController.h
//  X15.YiXiuDa
//
//  Created by 轩瑞 on 2016/9/26.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<BaiduMapAPI_Location/BMKLocationService.h>

@class ServiceLocationController;
@protocol SlectLocationDelegate <NSObject>

-(void)selectLocation:(CLLocationCoordinate2D)CLLocationCoordinate2D andTitle:(NSString *)title andAddress:(NSString *)address;

@end

@interface ServiceLocationController : UIViewController
@property (nonatomic,assign)id<SlectLocationDelegate>delegate;
@end

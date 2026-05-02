//
//  KX9UploadLocation.m
//  Glad9TM
//
//  Created by qiushi on 2017/7/18.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "KX9UploadLocation.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface KX9UploadLocation()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic,strong) BMKLocationService * p_locationServer;

@property (nonatomic,strong) NSTimer * p_timer;

@property (nonatomic,strong) BMKGeoCodeSearch * p_geoCode;

@property (nonatomic,copy) callBack p_locationBlock;


@end

@implementation KX9UploadLocation

-(BMKGeoCodeSearch *)p_geoCode{
    
    if (!_p_geoCode) {
        _p_geoCode =[[BMKGeoCodeSearch alloc]init];
        _p_geoCode.delegate = self;
    }
    return _p_geoCode;
}



-(BMKLocationService *)p_locationServer{
    if (!_p_locationServer) {
        _p_locationServer = [[BMKLocationService alloc]init];
        _p_locationServer.delegate = self;
        _p_locationServer.distanceFilter = 10;
        _p_locationServer.desiredAccuracy =kCLLocationAccuracyNearestTenMeters;
//        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
//            _p_locationServer.allowsBackgroundLocationUpdates =  YES;
//        }
//        _p_locationServer.pausesLocationUpdatesAutomatically = NO;
    }
    return _p_locationServer;
}

singleton_m(KX9UploadLocation);


-(void)startLocationGetLongitudeAndLatitude:(callBack)backLocation{
    _p_locationBlock = backLocation;
    [self.p_locationServer startUserLocationService];

}

-(void)timestart{

    [self.p_locationServer startUserLocationService];

}

-(void)startLocationAndUpLoad{
    [self timestart];

}

-(void)stopUpLoadLocation{

    [self.p_locationServer stopUserLocationService];

}


//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    CLLocationCoordinate2D coord =  userLocation.location.coordinate;
    
    if (self.p_locationBlock) {
        self.p_locationBlock(coord,nil);
        [self.p_locationServer stopUserLocationService];
        return;
    }
    [self reversegeo:coord];
}


- (void)didFailToLocateUserWithError:(NSError *)error{

    self.p_locationBlock(CLLocationCoordinate2DMake(0, 0), error);

}


-(void)reversegeo:(CLLocationCoordinate2D)point{
    
    
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = point;
    BOOL flag = [self.p_geoCode reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
        
    }
    else
    {
        NSLog(@"反geo检索发送失败");
        
    }
    
}


-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
        BMKPoiInfo *INFO =  [result.poiList firstObject];
        CLLocationCoordinate2D coor = INFO.pt;
        [self USER_UPDATELOCATION:[NSString stringWithFormat:@"%f",coor.longitude] :[NSString stringWithFormat:@"%f",coor.latitude] :INFO.name];
    }
    else {
        
    }
}



-(void)USER_UPDATELOCATION:(NSString *)x :(NSString *)y :(NSString *)address{
    
    NSDictionary *postdic = [NSDictionary dictionaryWithObjectsAndKeys:x,@"m_coordinatex",y,@"m_coordinatey",address,@"m_address",nil];
    [HttpRequestTools  requestUserInfoWithData:postdic methodName:@"USER-UPDATELOCATION" completion:^(id respInfo, NSError *error) {
        
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {

            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }

    }];

}




@end

//
//  CLLocation+TransLocationTool.h
//  Glad9TM
//
//  Created by qiushi on 2017/6/6.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (TransLocationTool)

//从地图坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu;

//从火星坐标到地图坐标
- (CLLocation*)locationEarthFromMars;

//从百度坐标到地图坐标
- (CLLocation*)locationEarthFromBaidu;

@end

//
//  XRCF_Common_Way.h
//  NJXRCharterFlights
//
//  Created by zhangxiaole on 2020/1/19.
//  Copyright © 2020年 qiushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRCF_Common_Way:NSObject
-(NSString *)GetMoneyMark:(NSString *)moneytype;
-(NSString *)GetMoneyType:(NSString *)moneyname;
-(NSString *)getphonetypename;
-(NSString *)GetContinentName:(NSString *)continenttype;

-(NSInteger)GetFitScreenSubValue;
@end

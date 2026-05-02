//
//  XRCF_Common_Way.m
//  NJXRCharterFlights
//
//  Created by zhangxiaole on 2020/1/19.
//  Copyright © 2020年 qiushi. All rights reserved.
//

#import "XRCF_Common_Way.h"

@implementation XRCF_Common_Way

//20200118,多币种
-(NSString *)GetMoneyMark:(NSString *)moneytype
{
    NSString *moneymark;
    if ([moneytype isEqualToString:@"101"])
    {
        moneymark=@"$";
    }
    else if ([moneytype isEqualToString:@"102"])
    {
        moneymark=@"€";
    }
    else if ([moneytype isEqualToString:@"103"])
    {
        moneymark=@"￡";
    }
    else
    {
        moneymark=@"¥";
    }
    return moneymark;
}

-(NSString *)GetMoneyType:(NSString *)moneyname
{
    NSString *moneytype;
    if ([moneyname isEqualToString:@"美元"])
    {
        moneytype=@"101";
    }
    else if ([moneyname isEqualToString:@"欧元"])
    {
        moneytype=@"102";
    }
    else if ([moneyname isEqualToString:@"英镑"])
    {
        moneytype=@"103";
    }
    else
    {
        moneytype=@"100";
    }
    return moneytype;
}

-(NSString *)getphonetypename{
    NSString *userPhoneNameStr = [[UIDevice currentDevice] name];//手机名称,iPhone X等
    //NSString *deviceNameStr = [[UIDevice currentDevice] systemName];//手机系统名称
    //NSString *systemVersionStr = [[UIDevice currentDevice] systemVersion];//手机系统版本号
    //NSLog(@"userPhoneNameStr=%@",userPhoneNameStr);
    //NSLog(@"deviceNameStr=%@",deviceNameStr);
    //NSLog(@"systemVersionStr=%@",systemVersionStr);
    return userPhoneNameStr;
}

-(NSString *)GetContinentName:(NSString *)continenttype
{
    NSString *continentname;
    if ([continenttype isEqualToString:@"1"])
    {
        continentname=@"亚洲";
    }
    else if ([continenttype isEqualToString:@"2"])
    {
        continentname=@"北美洲";
    }
    else if ([continenttype isEqualToString:@"3"])
    {
        continentname=@"欧洲";
    }
    else if ([continenttype isEqualToString:@"4"])
    {
        continentname=@"南美洲";
    }
    else if ([continenttype isEqualToString:@"5"])
    {
        continentname=@"非洲";
    }
    else if ([continenttype isEqualToString:@"6"])
    {
        continentname=@"大洋洲";
    }
    else
    {
        continentname=@"南极洲";
    }
    return continentname;
}

-(NSInteger)GetFitScreenSubValue{
    NSInteger subvalue = 0;
    if(SCREEN_HEIGHT <= 700.00)    //iphone6 iphone7 iphone8
    {
        subvalue = 0;
    }
    else if(SCREEN_HEIGHT <= 800.00)   //iphone6 plus,iphone7 plus, iphone8 plus
    {
        subvalue = 0;
    }
    else if(SCREEN_HEIGHT <= 850.00)   //Ipnone 11 pro
    {
        subvalue = 30;
    }
    else if(SCREEN_HEIGHT <= 900.00)   //Ipnone 11,iphone11 pro Max
    {
        subvalue = 30;
    }
    
    return subvalue;
}

@end

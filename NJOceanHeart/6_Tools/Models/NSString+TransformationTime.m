//
//  NSString+TransformationTime.m
//  NanjingFirstMiddleSchool
//
//  Created by qiushi on 15/12/20.
//  Copyright © 2015年 XuanRuiTechnology. All rights reserved.
//

#import "NSString+TransformationTime.h"

@implementation NSString (TransformationTime)

+(NSString *)stringWithDateFormater:(NSString *)dateFormatter andTimeString:(NSString *)timeStr{
    NSDateFormatter *dateMatter =[[NSDateFormatter alloc]init];
    [dateMatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateMatter dateFromString:timeStr];
    
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:dateFormatter];

    return [dateFormater stringFromDate:date];
}

-(NSString *)stringDateFormat:(NSString *)originalFormat transitionToFormat:(NSString *)toFormat{

    NSDateFormatter *originalFormatter =[[NSDateFormatter alloc]init];
    [originalFormatter setDateFormat:originalFormat];
    NSDate *date = [originalFormatter dateFromString:self];
    
    NSDateFormatter *toFormater = [[NSDateFormatter alloc]init];
    [toFormater setDateFormat:toFormat];
    return [toFormater stringFromDate:date];

}


@end

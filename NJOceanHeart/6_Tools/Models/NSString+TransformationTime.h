//
//  NSString+TransformationTime.h
//  NanjingFirstMiddleSchool
//
//  Created by qiushi on 15/12/20.
//  Copyright © 2015年 XuanRuiTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TransformationTime)

+(NSString *)stringWithDateFormater:(NSString *)dateFormatter andTimeString:(NSString *)timeStr;


-(NSString *)stringDateFormat:(NSString *)originalFormat transitionToFormat:(NSString *)toFormat;

@end

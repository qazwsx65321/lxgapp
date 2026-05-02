//
//  KX9RechargeOrderTool.m
//  Glad9TM
//
//  Created by qiushi on 2017/7/14.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "KX9RechargeOrderTool.h"

@implementation KX9RechargeOrderTool

+(NSString *)getRechargeorder:(NSString *)userID andType:(NSString *)type{
    NSMutableString *mutal = [NSMutableString string];
    [mutal appendString:@"10H"];
    [mutal appendString:[self getRandomStringLen:4]];
    [mutal appendString:[self getNowTime]];
    [mutal appendString:userID];
    [mutal appendString:type];
    return mutal;
}

+(NSString *)getNowTime{

    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat =@"MMddHHmmss";
    return  [formatter stringFromDate:date];
}

+(NSString *)getRandomStringLen:(int)len{
    NSString *base = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9";
    NSArray *arr = [base componentsSeparatedByString:@" "];
//    char arr1[len];
//    const char *char_content = [base cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSMutableString *mutal  = [NSMutableString string];
    for (int i= 0; i<len; i++) {
        int index = arc4random_uniform(62);
//        char num  = char_content[index];
//        arr1[i] = num;
        [mutal appendString:arr[index]];
    }
//    NSString *random =  [NSString stringWithFormat:@"%s",arr1];
    return mutal;
}

@end

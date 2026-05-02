//
//  NSObject+InitProperty.m
//  XRElectricMall
//
//  Created by qiushi on 16/4/12.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import "NSObject+InitProperty.h"
#import <objc/message.h>

@implementation NSObject (InitProperty)
-(void)initWithPropertyValueString{
    
    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSString *propertytype = [NSString stringWithUTF8String:type];
        NSString *propertyname = [NSString stringWithUTF8String:name];
        
        if ([propertytype isEqualToString:@"@\"NSString\""]) {
            [self setValue:@"" forKey:propertyname];
        }
    }
    free(ivars);
    
}

-(NSString *)judgePostModelToStandard:(NSDictionary *)dic{

    unsigned int methodCount = 0;
    
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    NSString * waring;
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
//        const char * type = ivar_getTypeEncoding(ivar);
//        NSString *propertytype = [NSString stringWithUTF8String:type];
        NSString *propertyname = [NSString stringWithUTF8String:name];
        NSString * flag = dic[propertyname];
        if (!flag.length) {
            continue;
        }
        NSString * object =  object_getIvar(self, ivar);
        if (object ==nil ||!object.length) {
                waring = dic[propertyname];
                break;
        }
    }
    free(ivars);
    return waring;
}

-(void)judgeObjectPropertyNull{
    
    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSString *propertytype = [NSString stringWithUTF8String:type];
        NSString *propertyname = [NSString stringWithUTF8String:name];
        
        if ([propertytype isEqualToString:@"@\"NSString\""]) {
            
           NSString *str =  object_getIvar(self, ivar);
            if (str ==nil||[str isKindOfClass:[NSNull class]] ||[@"null" isEqualToString:str]) {
                [self setValue:@"" forKeyPath:propertyname];
            }
//            NSLog(@"%@",str);
        }
    }
    free(ivars);
    

}
-(BOOL)judgePostPropertyValueAndIgnore:(NSString *)classIgnoreType{
    
    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    BOOL isRight = YES;
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * type = ivar_getTypeEncoding(ivar);
        NSString *propertytype = [NSString stringWithUTF8String:type];
        if ([propertytype containsString:classIgnoreType]) {
            continue;
        }
        
        if ([propertytype isEqualToString:@"@\"NSString\""]) {
            
            NSString *str =  object_getIvar(self, ivar);
            if (!str.length){
                isRight = NO;
                break;
            }
        }else if ([propertytype isEqualToString:@"@\"NSArray\""]||[propertytype isEqualToString:@"\"NSMutableArray\""]){
            NSArray *arr = object_getIvar(self, ivar);
            if (!arr.count){
                isRight = NO;
                break;
                
            }
        }else{
            id obj = object_getIvar(self, ivar);
            if (!obj){
                isRight = NO;
                break;
            }
        }
    }
    free(ivars);
    
    return isRight;
    
}


@end

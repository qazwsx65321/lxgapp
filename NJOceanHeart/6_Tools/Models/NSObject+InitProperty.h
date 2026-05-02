//
//  NSObject+InitProperty.h
//  XRElectricMall
//
//  Created by qiushi on 16/4/12.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (InitProperty)

-(void)initWithPropertyValueString;

-(void)judgeObjectPropertyNull;

-(BOOL)judgePostPropertyValueAndIgnore:(NSString *)classIgnoreType;

-(NSString *)judgePostModelToStandard:(NSDictionary *)dic;
@end

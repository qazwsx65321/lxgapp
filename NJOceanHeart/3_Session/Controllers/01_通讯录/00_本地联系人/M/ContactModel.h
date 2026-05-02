//
//  ContactModel.h
//  X16.QiHu
//
//  Created by 史伟文 on 16/9/21.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject

@property (nonatomic, copy)NSData *icon;
@property (nonatomic, copy)NSString *iconUrl;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, assign)BOOL selected;
@property (nonatomic, copy) NSString *type;
@property (nonatomic,copy) NSString *uid;

@end


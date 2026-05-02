//
//  Ocean_AddressModel.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/4.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AddressModel.h"

@implementation Ocean_AddressModel

@end



@implementation ShopAddressModel

@end

@implementation ShopAddressBody

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"MYADDRESS":@"ShopAddressModel"};
}

@end




@implementation MyAddressModel

@end

@implementation MyAddressBody

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"MYADDRESS":@"MyAddressModel"};
}

@end


@implementation AddAddressModel

@end


//
//  BottomView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/4/13.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView
@synthesize bt_addBasket,bt_buyNow,bt_collection,bt_service,bt_shop;
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        bt_service= [UIButton buttonWithType:UIButtonTypeCustom];
//        bt_service.frame = CGRectMake(0, 0,51, self.frame.size.height);
//        [bt_service setBackgroundImage:[UIImage imageNamed:@"service"] forState:0];
//        [self addSubview:bt_service];
        
        bt_shop= [UIButton buttonWithType:UIButtonTypeCustom];
        [bt_shop setImage:[UIImage imageNamed:@"usercar"] forState:0];
        bt_shop.frame = CGRectMake(bt_service.frame.size.width+bt_service.frame.origin.x, 0,40, 40);
        [self addSubview:bt_shop];

        
//        bt_collection= [UIButton buttonWithType:UIButtonTypeCustom];
//        bt_collection.frame = CGRectMake(bt_shop.frame.size.width+bt_shop.frame.origin.x, 0,52, self.frame.size.height);
//        [bt_collection setBackgroundImage:[UIImage imageNamed:@"collection"] forState:0];
//        [bt_collection setBackgroundImage:[UIImage imageNamed:@"collected"] forState:UIControlStateSelected];
//        [self addSubview:bt_collection];

        UIView *linV = [[UIView alloc]init];
        linV.size = CGSizeMake(screen_Width, .8);
        linV.backgroundColor = RGB(240, 240, 240);
        
        
        bt_addBasket= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_addBasket.backgroundColor = RGB(243, 157, 41);
        [bt_addBasket setTitle:@"加入购物车" forState:UIControlStateNormal];
        bt_addBasket.titleLabel.font = [UIFont systemFontOfSize:14];
        bt_addBasket.frame = CGRectMake(bt_collection.frame.size.width+bt_collection.frame.origin.x, 0,109, self.frame.size.height);
//        [bt_addBasket setBackgroundImage:[UIImage imageNamed:@"addbasket"] forState:0];
        [self addSubview:bt_addBasket];
        
        bt_buyNow= [UIButton buttonWithType:UIButtonTypeCustom];
//        [bt_buyNow setBackgroundImage:[UIImage imageNamed:@"buynow"] forState:0];
        [bt_buyNow setTitle:@"立即购买" forState:UIControlStateNormal];
        bt_buyNow.backgroundColor = BackgroundColors(1);
        bt_buyNow.titleLabel.font = [UIFont systemFontOfSize:14];

        bt_buyNow.frame = CGRectMake(bt_addBasket.frame.size.width+bt_addBasket.frame.origin.x, 0,self.frame.size.width-(bt_addBasket.frame.size.width+bt_addBasket.frame.origin.x), self.frame.size.height);
        [self addSubview:bt_buyNow];
        [self addSubview:linV];


    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    bt_buyNow.width  =self.bt_buyNow.height *2;
    bt_buyNow.right  =self.width;
    bt_addBasket.width = bt_addBasket.height *2;
    bt_addBasket.right = bt_buyNow.x;
    
    bt_shop.x = 15;
    bt_shop.centerY = self.height/2;
}

@end

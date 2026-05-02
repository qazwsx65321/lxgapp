//
//  TypeView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TypeView;
@protocol TypeSeleteDelegete <NSObject>

-(void)btnFromView:(TypeView*)typeV index:(int) tag andGuiGe:(NSString *)guige;

@end
@interface TypeView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,weak) id<TypeSeleteDelegete> delegate;
@property (nonatomic,assign) BOOL isselect;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename;
@end

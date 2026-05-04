//
//  ImageWebview.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/4/14.
//  Copyright © 2016年 江萧. All rights reserved.
//

//20260504 modify
//#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MJRefresh.h"
@protocol ImageWebDelegete <NSObject>

-(void)dragWebview;

@end
@interface ImageWebview : UIView<WKNavigationDelegate>
{
    int selectindex;
    NSArray *webarr;
    
}

@property(nonatomic, retain)UIScrollView *scro;
@property (nonatomic,weak) id<ImageWebDelegete> delegate;
-(instancetype)initWithFrame:(CGRect)frame andwebArr:(NSArray *)webArr;
@end

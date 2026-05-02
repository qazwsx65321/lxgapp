//
//  ZFTapGestureRecognizer.h
//  ZFDropDownDemo
//
//  Created by apple on 2017/1/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFTapGestureRecognizerDelegate <NSObject>

-(BOOL)ZFTapGestureRecognizerresponseGesture;

@end

@interface ZFTapGestureRecognizer : UITapGestureRecognizer<UIGestureRecognizerDelegate>

@property (nonatomic,weak) id<ZFTapGestureRecognizerDelegate>ZFTapGestureDelegate;

@end

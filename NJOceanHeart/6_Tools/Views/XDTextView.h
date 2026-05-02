//
//  XDTextView.h
//  WorkerPort
//
//  Created by 陈志伟 on 17/2/15.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDTextView;
@protocol XDTextViewDelegate <NSObject>

@optional
/**
 该代理为按下键盘return键之后需要做的事件
 */
- (void)didKeyBoardReturn:(XDTextView *)textView;

/**
  该代理为输入框开始编辑时的事件
 */
- (void)didChangeXDText:(XDTextView *)textView;

@end

@interface XDTextView : UIView

@property (nonatomic,assign) id<XDTextViewDelegate>delegate;
@property (nonatomic,copy) NSString *XD_placehodel;//placehodel的值
@property (nonatomic,copy) NSString *XD_text;//内容
@property (nonatomic,strong) UIFont *XD_font;//字体
@property (nonatomic,strong) UIColor *XD_placehodelColor;//placehodel的字体颜色
@property (nonatomic,strong) UIColor *XD_textColor;//内容的字体颜色
@property (nonatomic,assign) BOOL XD_isTop;   //文字是否置顶

@end

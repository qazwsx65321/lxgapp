//
//  XDDatePickerView.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XDDatePickerViewDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate;

@end


@interface XDDatePickerView : UIView

@property (copy, nonatomic) NSString *title;


@property (nonatomic,assign) BOOL isCurrentAuto; //默认YES：选中时间比当前时间小时会自动刷新到当前时间
@property (nonatomic,assign) BOOL isHour;        //默认YES：返回年月日时分秒       设置NO：返回年月日
@property (weak, nonatomic) id <XDDatePickerViewDelegate> delegate;

/// 显示
- (void)show;

@end

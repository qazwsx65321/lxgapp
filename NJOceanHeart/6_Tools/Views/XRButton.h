//
//  XRButton.h
//  WEC4Teacher
//
//  Created by 史伟文 on 15/5/13.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XRButton : UIButton

@property (nonatomic, strong)UITabBarItem *item;

- (instancetype)initWithFrame:(CGRect)frame andIsTabItem:(BOOL)isTab;

@property (nonatomic,strong) id infoModel;

@end

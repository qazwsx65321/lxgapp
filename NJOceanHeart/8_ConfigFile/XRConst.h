//
//  XRConst.h
//  XRElectricMall
//
//  Created by 史伟文 on 16/1/24.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>




#pragma mark - 服务器地址
extern NSString * const ServerUrl;
extern NSString * const APPPAGREEMENTURL;

#pragma mark - 常用字体
extern NSString * const Heiti_Medium;
extern NSString * const Heiti_Light;
extern NSString * const Heiti_TC_Light;


#pragma mark - 导航条
extern NSString * const Navi_Return_Icon;
extern NSString * const Navi_Background_Color;
extern NSString * const Navi_Title_Color;
extern NSString * const Navi_Item_Text_Color_Enable;
extern NSString * const Navi_Item_Text_Color_Disable;

#pragma mark - tabbar
extern NSString * const Tabbar_Text_Color_Normal;
extern NSString * const Tabbar_Text_Color_Selected;

#pragma mark - notification name
UIKIT_EXTERN NSString * const XRUserLoginNotification;
UIKIT_EXTERN NSString * const XRUserLogoutNotification;
UIKIT_EXTERN NSString * const XRChooseHeadImageNotification;
UIKIT_EXTERN NSString * const XRModifyInfoNotification;
UIKIT_EXTERN NSString * const XRReviceRemoteWinnerNotification;
UIKIT_EXTERN NSString * const XRPushThemeNotification;
UIKIT_EXTERN NSString * const XRPopVCRemoveTabNotification;
//控制

/** 常量数 */
UIKIT_EXTERN CGFloat const DCMargin;
/** 导航栏高度 */
UIKIT_EXTERN CGFloat const DCNaviH;
/** 底部tab高度 */
UIKIT_EXTERN CGFloat const DCBottomTabH;
/** 顶部Nav高度+指示器 */
UIKIT_EXTERN CGFloat const DCTopNavH;

extern BOOL QSisCan;


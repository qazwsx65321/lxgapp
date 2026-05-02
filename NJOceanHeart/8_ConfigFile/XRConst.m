//
//  XRConst.m
//  XRElectricMall
//
//  Created by 史伟文 on 16/1/24.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import "XRConst.h"

/*
 *  测试服务器地址
 */

//NSString * const ServerUrl = @"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/JsHyZxSoftWareServer";//测试地址
NSString * const ServerUrl = @"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/JsHyZxSoftWareServer";//正式地址

//20220418 add,增加隐私协议网址
NSString * const APPPAGREEMENTURL = @"http://www.soudu88.com/userAgreement/agreementtext.html";

// 常用字体
NSString * const Heiti_Medium = @"STHeitiSC-Medium";
NSString * const Heiti_Light = @"STHeitiSC-Light";
NSString * const Heiti_TC_Light = @"STHeitiTC-Light";

// 导航条
NSString * const Navi_Return_Icon = @"navibar_返回";
//NSString * const Navi_Background_Color = @"A500B1";
NSString * const Navi_Background_Color = @"E5443F";
NSString * const Navi_Title_Color = @"FFFFFF";
NSString * const Navi_Item_Text_Color_Enable = @"FFFFFF";
NSString * const Navi_Item_Text_Color_Disable = @"333333";


// tabbar
NSString * const Tabbar_Text_Color_Normal = @"999999";
NSString * const Tabbar_Text_Color_Selected = @"FFEA7F";
// notification name
NSString * const XRUserLoginNotification = @"XRUserLoginNotification";
NSString * const XRUserLogoutNotification = @"XRUserLogoutNotification";
NSString * const XRChooseHeadImageNotification = @"XRChooseHeadImageNotification";
NSString * const XRModifyInfoNotification = @"XRModifyInfoNotification";
NSString * const XRReviceRemoteWinnerNotification = @"XRReviceRemoteWinnerNotification";
NSString * const XRPushThemeNotification = @"XRPushThemeNotification";
NSString * const XRPopVCRemoveTabNotification = @"XRPopVCRemoveTabNotification";

//OPEN/OFF
/** 常量数 */
CGFloat const DCMargin = 10;

/** 导航栏高度 */
CGFloat const DCNaviH = 44;

/** 底部tab高度 */
CGFloat const DCBottomTabH = 44;
/** 顶部Nav高度+指示器 */
CGFloat const DCTopNavH = 64;

BOOL QSisCan = NO;


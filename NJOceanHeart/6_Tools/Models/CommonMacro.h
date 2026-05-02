//
//  CommonMacro.h
//  WisdomLake
//
//  Created by 史伟文 on 15/9/23.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//


#ifndef WisdomLake_CommonMacro_h
#define WisdomLake_CommonMacro_h

/* RGB颜色宏 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]      // RGB颜色值（带透明度）
#define RGB(r,g,b) RGBA(r,g,b,1.0f)     // RGB颜色值（不透明）
#define FONT(s)       [UIFont systemFontOfSize:s]
#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height

#define BackgroundColors(alp) [UIColor colorWithRed:228/255.0f green:61/255.0f blue:63/255.0f alpha:alp]
#define MainColor        [UIColor colorWithRed:24/255.0f green:161/255.0f blue:76/255.0f alpha:1]

#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1]

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RemoveSelfNotification  [[NSNotificationCenter defaultCenter]removeObserver:self];

/* 定义字体常量 */
#define TextFont  13

/* 设备型号 */
#define iPhone4S (SCREENHEIGHT == 480)

/* 常用路径 */
#define ROOTPATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]   // app根目录路径
#define WXRChangeRootVC(changeVC) [[UIApplication sharedApplication].delegate window].rootViewController = changeVC 

#define LoginVC [[Ocean_NavigationController alloc]initWithRootViewController:[[LoginController alloc]init]]

//----------------------其他----------------------------

//G－C－D
#define BACKGROUND(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define ProjectListPath(name,type)  [[NSBundle mainBundle] pathForResource:name ofType:type]

/*输出打印*/
#ifdef DEBUG
#  define LOG(fmt, ...) do {                                            \
NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
NSLog((@"%@(%d) " fmt), [file lastPathComponent], __LINE__, ##__VA_ARGS__); \
[file release];                                                 \
} while(0)
#  define LOG_METHOD NSLog(@"%s", __func__)
#  define LOG_CMETHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#  define COUNT(p) NSLog(@"%s(%d): count = %d\n", __func__, __LINE__, [p retainCount]);
#  define LOG_TRACE(x) do {printf x; putchar('\n'); fflush(stdout);} while (0)
#else
#  define LOG(...)
#  define LOG_METHOD
#  define LOG_CMETHOD
#  define COUNT(p)
#  define LOG_TRACE(x)
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//判断是真机还是模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif
//获取系统版本
#define IOS_VERSION [[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [UIDevice currentDevice] systemVersion]
//-------------------打印日志-------------------------

//重写NSLog,Debug模式下打印日志和当前行数
//#if DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString  stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
//#else
//#define NSLog(FORMAT, ...) nil
//#endif
//-------------------获取设备大小-------------------------

#define StatusBar_HEIGHT 20

#define NavigationBar_HEIGHT 44

#define NavigationBarIcon 20

#define TabBar_HEIGHT 49

#define TabBarIcon 30

/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define DCBGColor RGB(245,245,245)

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];



#endif

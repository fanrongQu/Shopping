//
//  UtilsMacro.h
//  NetEase News
//
//  Created by 1860 on 16/6/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  为简化代码定义的宏

#ifndef UtilsMacro_h
#define UtilsMacro_h

/** 代理 */
#define kDelegete ((AppDelegate*)[[UIApplication sharedApplication]delegate])
/** NSUserDefaults */
#define kNSUserDefaults [NSUserDefaults standardUserDefaults]
/** 屏幕大小 */
#define kScreenBounds [UIScreen mainScreen].bounds
/** 屏幕宽度 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** 字体大小 */
#define kFontSize(size) [UIFont systemFontOfSize:(size)]
/** 系统版本 */
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
/** 颜色 */
#define kUIColor_RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
/** 分割线颜色 */
#define KLineViewColor kUIColor_RGB(200, 200, 200, 1)

#define kSubjectColor kUIColor_RGB(4, 107, 179, 1)

#define kRedColor kUIColor_RGB(224, 50, 53, 1)

#define kGrayColor kUIColor_RGB(124, 124, 127, 1)

#endif /* UtilsMacro_h */

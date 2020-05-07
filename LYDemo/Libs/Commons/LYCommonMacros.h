//
//  LYCommonMacros.h
//  LYDemo
//
//  Created by 李杨 on 2020/1/13.
//  Copyright © 2020 kosien. All rights reserved.
//

#ifndef LYCommonMacros_h
#define LYCommonMacros_h


/// 1:测试
/// 0:生产
#ifndef LY_VERSION_TEST
#define LY_VERSION_TEST 1
#endif

#if LY_VERSION_TEST
#define ISPRODUCTION NO
#else
#define ISPRODUCTION YES
#endif


/// App版本号
#define LY_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


/// 设备尺寸
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kIs_iPhoneX   KDeviceHeight >= 812.0f
#define kStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44
#define kTabBarHeight (kIs_iPhoneX ? 83 : 49)
#define kBottomHeight (kIs_iPhoneX ? 34 : 0)
#define kNavBarAndStatusBarHeight kStatusHeight + kNavBarHeight


/// 调试打印
#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [%d行] %s\n", __TIME__, [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif


#endif /* LYCommonMacros_h */

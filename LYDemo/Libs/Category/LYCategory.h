//
//  LYCategory.h
//  text
//
//  Created by liyang on 15/7/12.
//  Copyright © 2015年 liyang. All rights reserved.
//
//  用法：将LYCategory文件夹导入工程中，然后在pch文件中引入头文件"LYCategory.h"

#import "Tools.h"
// UIKit
#import "UIView+Utils.h"
#import "UIView+LYExtension.h"
#import "UIButton+Utils.h"
#import "UILabel+Utils.h"
#import "UIImage+Utils.h"
#import "UIFont+Scale.h"
#import "UIColor+Utils.h"
// Foundation
#import "NSString+Valid.h"
#import "NSDateFormatter+Category.h"

// 屏幕宽高
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height    //状态栏高度
#define NAVBAR_HEIGHT (STATUS_HEIGHT + 44)                  //导航栏高度
#define TABBAR_HEIGHT ((kSCREEN_HEIGHT > 800) ? 83 : 49)    //TabBar高度
#define BOTTOM_MARGIN ((kSCREEN_HEIGHT > 800) ? 34 : 0)


// 判断系统版本
#define IOS_7  [[UIDevice currentDevice].systemVersion floatValue] >= 7.0
#define IOS_8  [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
#define IOS_9  [[UIDevice currentDevice].systemVersion floatValue] >= 9.0
#define IOS_10 [[UIDevice currentDevice].systemVersion floatValue] >= 10.0
#define IOS_11 [[UIDevice currentDevice].systemVersion floatValue] >= 11.0


//打印日志
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
//解决Xcode8+iOS10打印不全的问题
#ifdef DEBUG
#define MSLog(format, ...) printf("[%s] %s [%d行] %s\n", __TIME__, [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define MSLog(format, ...)
#endif


// 单例
#define LYUserDefault [NSUserDefaults standardUserDefaults]
#define LYFileManager [NSFileManager defaultManager]
#define LYKeyWindow   [UIApplication sharedApplication].keyWindow

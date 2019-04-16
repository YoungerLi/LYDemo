//
//  LYCategory.h
//  text
//
//  Created by liyang on 15/7/12.
//  Copyright © 2015年 liyang. All rights reserved.
//
//  用法：将LYCategory文件夹导入工程中，然后在pch文件中引入头文件"LYCategory.h"

#import "Tools.h"
#import "NSString+Valid.h"
#import "UIView+LYExtension.h"
#import "UIView+Animation.h"
#import "UIFont+Scale.h"
#import "NSDateFormatter+Category.h"

// 屏幕宽高
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height    //状态栏高度
#define NAVBAR_HEIGHT (STATUS_HEIGHT + 44)                  //导航栏高度
#define TABBAR_HEIGHT ((kSCREEN_HEIGHT > 800) ? 83 : 49)     //TabBar高度
#define BOTTOM_MARGIN ((kSCREEN_HEIGHT > 800) ? 34 : 0)

// 颜色
#define LINECOLOR [UIColor colorWithRed:211/255.0f green:211/255.0f blue:211/255.0f alpha:1]    //d3d3d3
#define BACKGROUNDCOLOR [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1] //f6f6f6
#define WHITECOLOR [UIColor whiteColor]

#define RandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
#define RGB_COLOR(r, g, b, al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 判断系统版本
#define IOS_7  [[UIDevice currentDevice].systemVersion floatValue] >= 7.0
#define IOS_8  [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
#define IOS_9  [[UIDevice currentDevice].systemVersion floatValue] >= 9.0
#define IOS_10 [[UIDevice currentDevice].systemVersion floatValue] >= 10.0
#define IOS_11 [[UIDevice currentDevice].systemVersion floatValue] >= 11.0


// 判断手机型号
#define IS_IPHONE_4  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_5  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_6  (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(kSCREEN_WIDTH, kSCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(kSCREEN_WIDTH, kSCREEN_HEIGHT))


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


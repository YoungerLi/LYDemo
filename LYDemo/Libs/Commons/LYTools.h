//
//  LYTools.h
//  LYDemo
//
//  Created by 李杨 on 2020/1/14.
//  Copyright © 2020 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTools : NSObject

/// 获取当前显示界面的controller
+ (UIViewController *)getCurrentViewController;


/// 自定义某些个文字的颜色大小
+ (NSMutableAttributedString *)attributString:(NSString *)string
                                        range:(NSRange)range
                                        color:(nullable UIColor *)color
                                         font:(nullable UIFont *)font;
/// 为某些个文字添加下划线
+ (NSMutableAttributedString *)attributAddLineString:(NSString *)string range:(NSRange)range;


/// 计算该路径的大小（单位：M）
+ (float)fileSizeAtPath:(NSString *)path;
/// 删除该路径
+ (void)clearCache:(NSString *)path;
/// 磁盘总空间（单位：M）
+ (float)diskOfAllSizeMBytes;
/// 磁盘可用空间（单位：M）
+ (float)diskOfFreeSizeMBytes;


/// 把秒转化成时分秒 -- 12:59:59
+ (NSString *)changeTimeWithSecond:(NSInteger)seconds;
/// 把秒转化成分秒 -- 12:23
+ (NSString *)changeTimeMSWithSecond:(NSInteger)seconds;
/// 把秒转化成时分秒 -- 1天3小时25分钟
+ (NSString *)changeTimeStringWithSecond:(NSInteger)seconds;


/// 获取粘贴板的信息
+ (NSString *)getPasteString;

/// MD5加密
+ (NSString *)getMD5_32Bit_string:(NSString *)srcString;


/// URL编码（特殊符号不会被编码）（转换成 %E6%88%91%E6 这种形式的）
+ (NSString *)URLEncodedString:(NSString *)string;

/// URL编码（特殊符号会被编码）
+ (NSString *)URLEncodedStringIncludeCharacter:(NSString *)string;

/// URL解码
+ (NSString *)URLDecodedString:(NSString *)string;


/// 字典转JSON字符串
+ (NSString *)convertToJsonStringFrom:(NSDictionary *)dict;

/// JSON字符串转字典
+ (NSDictionary *)convertToDictFromJsonString:(NSString *)string;


#pragma mark - 系统功能

/// 获取当前版本号
+ (NSString *)getAppCurrentVersion;

/// 调起打电话
+ (void)callPhone:(NSString *)number;

/// 跳转到系统设置
+ (void)openSettingURL;

/// 获取手机型号
+ (NSString *)getSystemModel;


#pragma mark - ********** 压缩照片

/// 压缩图片
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

@end




#pragma mark -
#pragma mark -

@interface NSArray (Valid)

/// 判断是否是数组并且不为空
+ (BOOL)isArrayAndCount:(id)obj;

@end

NS_ASSUME_NONNULL_END

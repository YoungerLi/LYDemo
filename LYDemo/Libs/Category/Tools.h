//
//  Tools.h
//  test
//
//  Created by liyang on 15/8/31.
//  Copyright (c) 2015年 liyang. All rights reserved.

//  此类是一个工厂类，用来直接调用封装好的各种方法

#import <Foundation/Foundation.h>

@interface Tools : NSObject

#pragma mark - 富文本

/** 自定义某些个文字的颜色大小 */
+ (NSMutableAttributedString *)attributString:(NSString *)string range:(NSRange)range color:(UIColor *)color font:(CGFloat)font;
/** 为某些个文字添加下划线 */
+ (NSMutableAttributedString *)attributAddLineString:(NSString *)string range:(NSRange)range;


#pragma mark - 文件路径大小

/** 计算该路径的大小（单位：M） */
+ (float)fileSizeAtPath:(NSString *)path;
/** 删除该路径 */
+ (void)clearCache:(NSString *)path;
/** 磁盘总空间（单位：M） */
+ (float)diskOfAllSizeMBytes;
/** 磁盘可用空间（单位：M） */
+ (float)diskOfFreeSizeMBytes;


#pragma mark - 时间格式转换

/** 把秒转化成时分秒 -- 12:59:59 */
+ (NSString *)changeTimeWithSecond:(NSInteger)seconds;
/** 把秒转化成分秒 -- 12:23 */
+ (NSString *)changeTimeMSWithSecond:(NSInteger)seconds;
/** 把秒转化成时分秒 -- 1天3小时25分钟 */
+ (NSString *)changeTimeStringWithSecond:(NSInteger)seconds;


#pragma mark - 获取粘贴板的信息

/** 获取粘贴板的信息 */
+ (NSString *)getPasteString;


#pragma mark - MD5加密

/** MD5加密 */
+ (NSString *)getMD5_32Bit_string:(NSString *)srcString;


#pragma mark - URL编码/解码

/** URL编码（特殊符号不会被编码）（转换成 %E6%88%91%E6 这种形式的） */
+ (NSString *)URLEncodedString:(NSString *)string;

/** URL编码（特殊符号会被编码） */
+ (NSString *)URLEncodedStringIncludeCharacter:(NSString *)string;

/** URL解码 */
+ (NSString *)URLDecodedString:(NSString *)string;


#pragma mark - 类型转换

/** 字典转JSON字符串 */
+ (NSString *)convertToJsonStringFrom:(NSDictionary *)dict;

/** JSON字符串转字典 */
+ (NSDictionary *)convertToDictFromJsonString:(NSString *)string;


#pragma mark - 系统功能

/** 获取当前版本号 */
+ (NSString *)getAppCurrentVersion;

/** 调起打电话 */
+ (void)callPhone:(NSString *)number;

/** 跳转到系统设置 */
+ (void)openSettingURL;

/** 获取手机型号 */
+ (NSString *)getSystemModel;


#pragma mark - ********** 压缩照片

/** 压缩图片 */
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

@end




#pragma mark -
#pragma mark -

@interface NSArray (Valid)

/** 判断是否是数组并且不为空 */
+ (BOOL)isArrayAndCount:(id)obj;

@end

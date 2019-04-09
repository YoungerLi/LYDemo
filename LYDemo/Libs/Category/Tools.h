//
//  Tools.h
//  test
//
//  Created by liyang on 15/8/31.
//  Copyright (c) 2015年 liyang. All rights reserved.

//  此类是一个工厂类，用来直接调用封装好的各种方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LYCategory.h"

@interface Tools : NSObject


#pragma mark - ********** UIImage

/** 加载图片 优势：不会将图片加到内存缓存中（适用类型：较大图片的处理） */
+ (UIImage *)imageWithName:(NSString *)imgName;
/** 根据UIColor生成一个图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;




#pragma mark - ********** UIView

/** 创建一条灰色的线 */
+ (UIView *)lineWithFrame:(CGRect)frame;
/** 创建一条线，可自定义颜色 */
+ (UIView *)lineWithFrame:(CGRect)frame color:(UIColor *)color;




#pragma mark - ********** UIImageView

/** 创建一个图片mode0为填充1为原图填充 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image mode:(UIViewContentMode)mode;




#pragma mark - ********** UIButton

/** 创建button */
+ (UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action;
+ (UIButton *)createButtonWithFrame:(CGRect)frame backgroundImage:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action;
+ (UIButton *)createButtonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color title:(NSString *)title addTarget:(id)target action:(SEL)action;
+ (UIButton *)createButtonWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font addTarget:(id)target action:(SEL)action;




#pragma mark - ********** UILabel

/** 创建label */
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color textAlignment:(NSTextAlignment)align;




#pragma mark - ********** 自适应高度/宽度

/** 自适应高度(无限制)（字体有比例） */
+ (CGFloat)getMyHeightWithString:(NSString *)string width:(CGFloat)width font:(CGFloat)fontSize;
/** 自适应高度(无限制)（字体无比例） */
+ (CGFloat)getMyHeightWithString:(NSString *)string width:(CGFloat)width rFont:(CGFloat)fontSize;
/** 自适应高度(有限制)（字体有比例） */
+ (CGFloat)getMyHeightWithString:(NSString *)string size:(CGSize)size font:(CGFloat)fontSize;
/** 自适应高度(有限制)（字体无比例） */
+ (CGFloat)getMyHeightWithString:(NSString *)string size:(CGSize)size rFont:(CGFloat)fontSize;
/** 自适应宽度（字体有比例）*/
+ (CGFloat)getMyWidthWithString:(NSString *)string size:(CGSize)size font:(CGFloat)fontSize;
/** 自适应宽度（字体无比例） */
+ (CGFloat)getMyWidthWithString:(NSString *)string size:(CGSize)size rFont:(CGFloat)fontSize;
/** 自适应size（字体有比例） */
+ (CGSize)getMySizeWithString:(NSString *)string size:(CGSize)size font:(CGFloat)fontSize;
/** 自适应size（字体无比例） */
+ (CGSize)getMySizeWithString:(NSString *)string size:(CGSize)size rFont:(CGFloat)fontSize;




#pragma mark - ********** 展示AlertView

/** 展示系统 UIAlertView */
+ (void)showAlertViewOfSystemWithTitle:(NSString *)title andMessage:(NSString *)message;




#pragma mark - ********** 富文本

/** 自定义某些个文字的颜色大小 */
+ (NSMutableAttributedString *)attributString:(NSString *)string range:(NSRange)range color:(UIColor *)color font:(CGFloat)font;
/** 为某些个文字添加下划线 */
+ (NSMutableAttributedString *)attributAddLineString:(NSString *)string range:(NSRange)range;




#pragma mark - ********** 文件路径大小

/** 计算该路径的大小（单位：M） */
+ (float)fileSizeAtPath:(NSString *)path;
/** 删除该路径 */
+ (void)clearCache:(NSString *)path;
/** 磁盘总空间（单位：M） */
+ (float)diskOfAllSizeMBytes;
/** 磁盘可用空间（单位：M） */
+ (float)diskOfFreeSizeMBytes;




#pragma mark - ********** 时间格式转换

/** 把秒转化成时分秒 -- 12:59:59 */
+ (NSString *)changeTimeWithSecond:(NSInteger)seconds;
/** 把秒转化成分秒 -- 12:23 */
+ (NSString *)changeTimeMSWithSecond:(NSInteger)seconds;
/** 把秒转化成时分秒 -- 1天3小时25分钟 */
+ (NSString *)changeTimeStringWithSecond:(NSInteger)seconds;




#pragma mark - ********** 获取粘贴板的信息

/** 获取粘贴板的信息 */
+ (NSString *)getPasteString;




#pragma mark - ********** MD5加密

/** MD5加密 */
+ (NSString *)getMD5_32Bit_string:(NSString *)srcString;




#pragma mark - ********** URL编码/解码

/** URL编码（不包含特殊符号）（转换成 %E6%88%91%E6 这种形式的） */
+ (NSString *)URLEncodedString:(NSString *)string;

/** URL编码（包含特殊符号） */
+ (NSString *)URLEncodedStringIncludeCharacter:(NSString *)string;

/** URL解码 */
+ (NSString *)URLDecodedString:(NSString *)string;




#pragma mark - ********** 类型转换

/** 字典转JSON字符串 */
+ (NSString *)convertToJsonStringFrom:(NSDictionary *)dict;

/** JSON字符串转字典 */
+ (NSDictionary *)convertToDictFromJsonString:(NSString *)string;




#pragma mark - ********** 系统功能

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

@interface UIButton (Attribute)

/** set image for button with Normal and Highlighted state */
- (void)setNormalAndHighlightedImage:(UIImage *)image;

/** set title for button with Normal and Highlighted state */
- (void)setNormalAndHighlightedTitle:(NSString *)title;

/** set titleColor for button with Normal and Highlighted state */
- (void)setNormalAndHighlightedTitleColor:(UIColor *)color;

@end




@interface NSArray (Valid)

/** 判断是否是数组并且不为空 */
+ (BOOL)isArrayAndCount:(id)obj;

@end

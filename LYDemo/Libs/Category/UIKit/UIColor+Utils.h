//
//  UIColor+Utils.h
//  LYDemo
//
//  Created by 李杨 on 2019/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Utils)

/**
 随机颜色
 */
+ (UIColor *)colorWithRandomColor;

/**
 普通的255颜色转换，转换为UIKit的 0.0 - 1.0 颜色值, alpha = 1.0
 */
+ (UIColor *)colorWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)colorWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END

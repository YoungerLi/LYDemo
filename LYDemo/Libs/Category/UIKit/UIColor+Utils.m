//
//  UIColor+Utils.m
//  LYDemo
//
//  Created by 李杨 on 2019/4/16.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

#pragma mark - 随机颜色

+ (UIColor *)colorWithRandomColor {
    return [self colorWith255Red:arc4random()%256 green:arc4random()%256 blue:arc4random()%256 alpha:1.0];
}


#pragma mark - 普通的255颜色转换

+ (UIColor *)colorWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [self colorWith255Red:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

@end

//
//  UIImage+Utils.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

// 通过文件路径加载图片，该方法加载图片优势：不会将图片加到内存缓存中（适用类型：较大图片的处理）图片名需加.png/.jpg
+ (UIImage *)imageWithName:(NSString *)imgName {
    if (imgName) {
        NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    return nil;
}

// 根据UIColor生成一个图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    return image;
}

@end

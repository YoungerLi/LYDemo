//
//  UIImage+Utils.h
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utils)

/**
 加载图片
 优势：不会将图片加到内存缓存中
 适用类型：较大图片的处理
 图片名需加.png/.jpg
 */
+ (UIImage *)imageWithName:(NSString *)imgName;

/**
 根据UIColor生成一个图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

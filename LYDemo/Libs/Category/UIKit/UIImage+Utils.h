//
//  UIImage+Utils.h
//  LYDemo
//
//  Created by 李杨 on 2019/4/16.
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

@end

NS_ASSUME_NONNULL_END

//
//  UIView+Utils.h
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Utils)

/**
 创建一个UIView
 */
+ (UIView *)viewWithFrame:(CGRect)frame color:(UIColor *)color;

/**
 开始旋转
 */
- (void)rotationAnimation;

/**
 停止旋转
 */
- (void)stopRotation;

@end

NS_ASSUME_NONNULL_END

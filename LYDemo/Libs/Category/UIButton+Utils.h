//
//  UIButton+Utils.h
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utils)

/**
 创建一个UIButton
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action;

/**
 创建一个UIButton
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame backgroundImage:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action;

/**
 创建一个UIButton
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color title:(NSString *)title addTarget:(id)target action:(SEL)action;


/**
 set image for button with Normal and Highlighted state
 */
- (void)setNormalAndHighlightedImage:(UIImage *)image;

/**
 set title for button with Normal and Highlighted state
 */
- (void)setNormalAndHighlightedTitle:(NSString *)title;

/**
 set titleColor for button with Normal and Highlighted state
 */
- (void)setNormalAndHighlightedTitleColor:(UIColor *)color;

@end

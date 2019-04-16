//
//  UIButton+Utils.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)

+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action {
    return [self buttonWithFrame:frame image:image backgroundImage:nil backgroundColor:nil title:title addTarget:target action:action];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame backgroundImage:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action {
    return [self buttonWithFrame:frame image:nil backgroundImage:image backgroundColor:nil title:title addTarget:target action:action];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color title:(NSString *)title addTarget:(id)target action:(SEL)action {
    return [self buttonWithFrame:frame image:nil backgroundImage:nil backgroundColor:color title:title addTarget:target action:action];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
              backgroundImage:(UIImage *)backgroundImage
              backgroundColor:(UIColor *)backgroundColor
                        title:(NSString *)title
                    addTarget:(id)target
                       action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (image) { [btn setNormalAndHighlightedImage:image]; }
    if (backgroundImage) { [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal]; }
    if (backgroundColor) { btn.backgroundColor = backgroundColor; }
    if (title) { [btn setTitle:title forState:UIControlStateNormal]; }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)setNormalAndHighlightedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
}

- (void)setNormalAndHighlightedTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setNormalAndHighlightedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

@end

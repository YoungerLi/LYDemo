//
//  UIFont+Scale.m
//  Demo
//
//  Created by liyang on 2018/11/30.
//  Copyright © 2018 kosien. All rights reserved.
//

#import "UIFont+Scale.h"

@implementation UIFont (Scale)

+ (UIFont *)fontOfSize:(CGFloat)fontSize
{
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        return [UIFont systemFontOfSize:fontSize];
    } else {
        return [UIFont systemFontOfSize:fontSize - 1];
    }
}

@end

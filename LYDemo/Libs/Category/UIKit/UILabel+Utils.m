//
//  UILabel+Utils.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font textAlignment:(NSTextAlignment)align
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.textColor = color ?: [UIColor darkTextColor];
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = align;
    return label;
}

@end

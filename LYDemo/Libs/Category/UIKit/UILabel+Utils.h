//
//  UILabel+Utils.h
//  LYDemo
//
//  Created by 李杨 on 2019/4/16.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)

/**
 创建一个UILabel
 */
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font textAlignment:(NSTextAlignment)align;

@end

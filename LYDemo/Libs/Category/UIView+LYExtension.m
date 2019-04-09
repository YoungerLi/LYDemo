//
//  UIView+LYExtension.m
//  LYDemo
//
//  Created by liyang on 2018/1/12.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "UIView+LYExtension.h"

@implementation UIView (LYExtension)

#pragma mark - ly_x

- (void)setLy_x:(CGFloat)ly_x
{
    CGRect frame = self.frame;
    frame.origin.x = ly_x;
    self.frame = frame;
}
- (CGFloat)ly_x
{
    return self.frame.origin.x;
}




#pragma mark - ly_y

- (void)setLy_y:(CGFloat)ly_y
{
    CGRect frame = self.frame;
    frame.origin.y = ly_y;
    self.frame = frame;
}
- (CGFloat)ly_y
{
    return self.frame.origin.y;
}




#pragma mark - ly_w

- (void)setLy_w:(CGFloat)ly_w
{
    CGRect frame = self.frame;
    frame.size.width = ly_w;
    self.frame = frame;
}
- (CGFloat)ly_w
{
    return self.frame.size.width;
}




#pragma mark - ly_h

- (void)setLy_h:(CGFloat)ly_h
{
    CGRect frame = self.frame;
    frame.size.height = ly_h;
    self.frame = frame;
}
- (CGFloat)ly_h
{
    return self.frame.size.height;
}




#pragma mark - ly_centerX

- (void)setLy_centerX:(CGFloat)ly_centerX
{
    CGPoint center = self.center;
    center.x = ly_centerX;
    self.center = center;
}
- (CGFloat)ly_centerX
{
    return self.center.x;
}




#pragma mark - ly_centerY

- (void)setLy_centerY:(CGFloat)ly_centerY
{
    CGPoint center = self.center;
    center.y = ly_centerY;
    self.center = center;
}
- (CGFloat)ly_centerY
{
    return self.center.y;
}




#pragma mark - ly_right

- (void)setLy_right:(CGFloat)ly_right
{
    CGRect frame = self.frame;
    frame.origin.x = ly_right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)ly_right
{
    return self.frame.origin.x + self.frame.size.width;
}




#pragma mark - ly_bottom

- (void)setLy_bottom:(CGFloat)ly_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ly_bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)ly_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}




#pragma mark - ly_size

- (void)setLy_size:(CGSize)ly_size
{
    CGRect frame = self.frame;
    frame.size = ly_size;
    self.frame = frame;
}
- (CGSize)ly_size
{
    return self.frame.size;
}




#pragma mark - ly_origin

- (void)setLy_origin:(CGPoint)ly_origin
{
    CGRect frame = self.frame;
    frame.origin = ly_origin;
    self.frame = frame;
}
- (CGPoint)ly_origin
{
    return self.frame.origin;
}

@end


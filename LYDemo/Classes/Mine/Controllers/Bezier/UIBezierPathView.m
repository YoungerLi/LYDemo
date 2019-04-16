//
//  UIBezierPathView.m
//  text
//
//  Created by Kosien on 16/11/3.
//  Copyright © 2016年 kosienDGL. All rights reserved.
//

#import "UIBezierPathView.h"

@implementation UIBezierPathView

- (instancetype)initWithCGPoint:(CGPoint)point
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        _point = point;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"%@", NSStringFromCGRect(rect));
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_point];
    [path addLineToPoint:CGPointMake(kSCREEN_WIDTH-40, 200)];
    [path addLineToPoint:CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT-40)];
    [path addLineToPoint:CGPointMake(kSCREEN_WIDTH/2, 74)];
    [path closePath];
    
    path.lineWidth = 2;
    [[UIColor orangeColor] set];
    [path fill];
    [[UIColor magentaColor] set];
    [path stroke];
    
}


@end

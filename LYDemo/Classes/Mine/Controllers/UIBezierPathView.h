//
//  UIBezierPathView.h
//  text
//
//  Created by Kosien on 16/11/3.
//  Copyright © 2016年 kosienDGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPathView : UIView
{
    CGPoint _point;
}
- (instancetype)initWithCGPoint:(CGPoint)point;

@end

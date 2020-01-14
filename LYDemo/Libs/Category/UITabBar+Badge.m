//
//  UITabBar+Badge.m
//  AppNew
//
//  Created by liyang on 17/9/2.
//  Copyright © 2017年 Kosien. All rights reserved.
//

#import "UITabBar+Badge.h"

#define TabbarItemNums 5.0    //tabbar的数量

@implementation UITabBar (Badge)

// 显示小红点
- (void)showBadgeOnItemIndex:(int)index num:(NSString *)num {
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    if ([num integerValue] == 0) {
        return;
    }
    //新建小红点
    UILabel *redLabel = [[UILabel alloc] init];
    redLabel.backgroundColor = [UIColor whiteColor];
    redLabel.textAlignment = 1;
    redLabel.text = num;
    redLabel.textColor = [UIColor redColor];
    redLabel.font = [UIFont systemFontOfSize:8];
    redLabel.layer.masksToBounds = YES;
    redLabel.layer.cornerRadius = 6;
    redLabel.layer.borderColor = [UIColor redColor].CGColor;
    redLabel.layer.borderWidth = 1.0f;
    redLabel.tag = 888 + index;
    //确定小红点的位置
    float percentX = (index + 0.57) / TabbarItemNums;
    CGFloat x = ceilf(percentX * self.frame.size.width);
    CGFloat w = [num widthForFont:[UIFont systemFontOfSize:8]] + 4;
    w = w > 12 ? w : 12;
    redLabel.frame = CGRectMake(x - 2, 5, w, 12); //圆形大小
    [self addSubview:redLabel];
}

// 隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index {
    [self removeBadgeOnItemIndex:index];
}

// 移除小红点
- (void)removeBadgeOnItemIndex:(int)index {
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + index) {
            [subView removeFromSuperview];
        }
    }
}

@end

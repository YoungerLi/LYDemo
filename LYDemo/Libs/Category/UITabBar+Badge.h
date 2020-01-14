//
//  UITabBar+Badge.h
//  AppNew
//
//  Created by liyang on 17/9/2.
//  Copyright © 2017年 Kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

/** 显示小红点（index是TabBar的索引） */
- (void)showBadgeOnItemIndex:(int)index num:(NSString *)num;

/** 隐藏小红点 */
- (void)hideBadgeOnItemIndex:(int)index;

@end
